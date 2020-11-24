#!/bin/bash
OUT="$1"

if [[ $# -lt 1 ]]; then
  echo "Please supply an output directory."
  echo "ie. ./test.sh nfs"
  exit 1
fi

if [[ ! -d $1 ]]; then
  mkdir -p $1
fi


fio --name=job-w --rw=write --size=2G --ioengine=libaio --iodepth=4 --bs=128k --direct=1 --filename=bench.file --output-format=normal,terse --output=$OUT/fio-write.log
sleep 5
fio --name=job-r --rw=read --size=2G --ioengine=libaio --iodepth=4 --bs=128K --direct=1 --filename=bench.file --output-format=normal,terse --output=$OUT/fio-read.log
sleep 5
fio --name=job-randw --rw=randwrite --size=2G --ioengine=libaio --iodepth=32 --bs=4k --direct=1 --filename=bench.file --output-format=normal,terse --output=$OUT/fio-randwrite.log
sleep 5
fio --name=job-randr --rw=randread --size=2G --ioengine=libaio --iodepth=32 --bs=4K --direct=1 --filename=bench.file --output-format=normal,terse --output=$OUT/fio-randread.log

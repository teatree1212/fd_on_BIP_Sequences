#!/bin/bash

#ls
#echo "creating output dir"
#mkdir SRA_download
#cd SRA_download
#mv ../$1 .

while read line
do
  var=$(echo $line | tr ',' '\t' | awk '{print $2}')
  if [[  "$var" = [Seq_id] ]]; then
    echo "skipping header">>Sequence_retrieval_summary.txt
  fi
##retrieve sequences
  if [ "${var:0:1}" != "S" ]; then
  var2=$(echo $line | tr ',' '\t' | awk '{print $1}')
  echo "No sequence available for Accession $var2, skipping this Accession" >>Sequence_retrieval_summary.txt
elif [[  "$var" =~ [\;] ]]; then
  var3=$(echo $var | tr ';' '\t' | awk '{print $1}')
  echo "Multiple sequences discovered, using first one given: $var3" >>Sequence_retrieval_summary.txt
#  fastq-dump '${1}'  --outdir .
else
  echo "retrieving $var from SRA" >>Sequence_retrieval_summary.txt
#  fastq-dump '${2}'  --outdir .
  fi
done <$1

#-v "$(pwd)":/data -w /data

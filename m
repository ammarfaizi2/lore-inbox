Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318708AbSIEW3m>; Thu, 5 Sep 2002 18:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318710AbSIEW3m>; Thu, 5 Sep 2002 18:29:42 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:15581 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S318708AbSIEW3l>; Thu, 5 Sep 2002 18:29:41 -0400
Message-ID: <20020905223414.5442.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Date: Fri, 06 Sep 2002 06:34:14 +0800
Subject: Re: BYTE UNIX Benchmarks (Version 4.1.0)
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the NOT complete previous email.

Here it goes the report of the 2.4.20-pre5aa1.
Again, the baseline is a vanilla 2.4.19.


  BYTE UNIX Benchmarks (Version 4.1.0)
  System -- Linux localhost.localdomain 2.4.20-pre5aa1 #21 Thu Sep 5 22:44:13 BST 2002 i686 unknown
  Start Benchmark Run: Thu Sep  5 22:52:20 BST 2002
   1 interactive users.
   10:52pm  up 0 min,  1 user,  load average: 0.19, 0.06, 0.02
  lrwxrwxrwx    1 root     root            4 Jul 11 21:33 /bin/sh -> bash
  /bin/sh: symbolic link to bash
  /dev/hda6              3817344   2624280    999152  73% /
Dhrystone 2 using register variables     1682300.5 lps   (10.0 secs, 10 samples)
Double-Precision Whetstone                  417.8 MWIPS (10.1 secs, 10 samples)
System Call Overhead                     411749.2 lps   (10.0 secs, 10 samples)
Pipe Throughput                          480723.5 lps   (10.0 secs, 10 samples)
Pipe-based Context Switching             227789.1 lps   (10.0 secs, 10 samples)
Process Creation                           9281.9 lps   (30.0 secs, 3 samples)
Execl Throughput                            933.3 lps   (29.7 secs, 3 samples)
File Read 1024 bufsize 2000 maxblocks    196276.0 KBps  (30.0 secs, 3 samples)
File Write 1024 bufsize 2000 maxblocks   137821.0 KBps  (30.0 secs, 3 samples)
File Copy 1024 bufsize 2000 maxblocks     98855.0 KBps  (30.0 secs, 3 samples)
File Read 256 bufsize 500 maxblocks      140402.0 KBps  (30.0 secs, 3 samples)
File Write 256 bufsize 500 maxblocks      84355.0 KBps  (30.0 secs, 3 samples)
File Copy 256 bufsize 500 maxblocks       51581.0 KBps  (30.0 secs, 3 samples)
File Read 4096 bufsize 8000 maxblocks    197291.0 KBps  (30.0 secs, 3 samples)
File Write 4096 bufsize 8000 maxblocks   139374.0 KBps  (30.0 secs, 3 samples)
File Copy 4096 bufsize 8000 maxblocks    107897.0 KBps  (30.0 secs, 3 samples)
Shell Scripts (1 concurrent)                915.3 lpm   (60.0 secs, 3 samples)
Shell Scripts (8 concurrent)                136.0 lpm   (60.0 secs, 3 samples)
Shell Scripts (16 concurrent)                69.0 lpm   (60.0 secs, 3 samples)
Arithmetic Test (type = short)           203506.7 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = int)             200129.4 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = long)            200123.6 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = float)           210471.8 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = double)          210513.7 lps   (10.0 secs, 3 samples)
Arithoh                                  3664144.7 lps   (10.0 secs, 3 samples)
C Compiler Throughput                       468.7 lpm   (60.0 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places          42615.1 lpm   (30.0 secs, 3 samples)
Recursion Test--Tower of Hanoi            28605.8 lps   (20.0 secs, 3 samples)


                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Arithmetic Test (type = double)             210515.1   210513.7       10.0
Arithmetic Test (type = float)              210516.4   210471.8       10.0
Arithmetic Test (type = int)                200121.7   200129.4       10.0
Arithmetic Test (type = long)               200131.7   200123.6       10.0
Arithmetic Test (type = short)              203544.0   203506.7       10.0
Arithoh                                    3664143.2  3664144.7       10.0
C Compiler Throughput                          469.7      468.7       10.0
Dc: sqrt(2) to 99 decimal places             42687.3    42615.1       10.0
Dou

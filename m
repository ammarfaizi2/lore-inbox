Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbTABMBd>; Thu, 2 Jan 2003 07:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTABMBd>; Thu, 2 Jan 2003 07:01:33 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:49630 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261448AbTABMBc>; Thu, 2 Jan 2003 07:01:32 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.54
Date: Thu, 2 Jan 2003 17:39:47 +0530
Message-ID: <005101c2b257$d82111e0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
X-OriginalArrivalTime: 02 Jan 2003 12:09:47.0751 (UTC) FILETIME=[D81D8F70:01C2B257]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the unixbench result for kernel 2.5.54. when compared with
kernel 2.5.53 there was no significant differnece in the test results.
------------------------------------------------------------------------
--
				    kernel 2.5.54
------------------------------------------------------------------------
----
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.54 #9 Thu Jan 2 12:12:40 IST 2003 i686
unknown
Start Benchmark Run: Thu Jan  2 13:40:32 IST 2003
1 interactive users.
1:40pm  up 2 min,  1 user,  load average: 0.07, 0.07, 0.02
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   4322732   3519640  56% /data

Dhrystone 2 using register variables     1804903.9lps (10.0 secs,10
samples)
Double-Precision Whetstone               476.2 MWIPS  (10.0 secs,10
samples)
System Call Overhead                     462787.1 lps (10.0 secs,10
samples)
Pipe Throughput                          441760.2 lps (10.0 secs,10
samples)
Pipe-based Context Switching             202474.6 lps (10.0 secs,10
samples)
Process Creation                         4564.8 lps   (30.0 secs, 3
samples)
Execl Throughput                         912.5 lps    (29.7 secs, 3
samples)
File Read 1024 bufsize 2000 maxblocks    244356.0KBps (30.0 secs, 3
samples)
File Write 1024 bufsize 2000 maxblocks   99888.0KBps  (30.0 secs, 3
samples)
File Copy 1024 bufsize 2000 maxblocks    69507.0KBps  (30.0 secs, 3
samples)
File Read 256 bufsize 500 maxblocks      115282.0KBps (30.0 secs, 3
samples)
File Write 256 bufsize 500 maxblocks     55905.0KBps  (30.0 secs, 3
samples)
File Copy 256 bufsize 500 maxblocks      35402.0KBps  (30.0 secs, 3
samples)
File Read 4096 bufsize 8000 maxblocks    338268.0KBps (30.0 secs, 3
samples)
File Write 4096 bufsize 8000 maxblocks   126844.0KBps (30.0 secs, 3
samples)
File Copy 4096 bufsize 8000 maxblocks    90025.0 KBps (30.0 secs, 3
samples)
Shell Scripts (1 concurrent)             892.0 lpm    (60.0 secs, 3
samples)
Shell Scripts (8 concurrent)             116.0 lpm    (60.0 secs, 3
samples)
Shell Scripts (16 concurrent)            58.0 lpm     (60.0 secs, 3
samples)
Arithmetic Test (type = short)           208141.3lps  (10.0 secs, 3
samples)
Arithmetic Test (type = int)             225324.7lps  (10.0 secs, 3
samples)
Arithmetic Test (type = long)            225343.2lps  (10.0 secs, 3
samples)
Arithmetic Test (type = float)           227412.1lps  (10.0 secs, 3
samples)
Arithmetic Test (type = double)          227416.9lps  (10.0 secs, 3
samples)
Arithoh                                  3995227.0lps (10.0 secs, 3
samples)
C Compiler Throughput                    411.0 lpm    (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places         34813.1lpm   (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi           28910.8 lps  (20.0 secs, 3
samples)


                     INDEX VALUES            
TEST                                        BASELINE     RESULT
INDEX

Dhrystone 2 using register variables        116700.0   1804903.9
154.7
Double-Precision Whetstone                  55.0       476.2
86.6
Execl Throughput                            43.0       912.5
212.2
File Copy 1024 bufsize 2000 maxblocks       3960.0     69507.0
175.5
File Copy 256 bufsize 500 maxblocks         1655.0     35402.0
213.9
File Copy 4096 bufsize 8000 maxblocks       5800.0     90025.0
155.2
Pipe Throughput                             12440.0    441760.2
355.1
Process Creation                            126.0      4564.8
362.3
Shell Scripts (8 concurrent)                6.0        116.0
193.3
System Call Overhead                        15000.0    462787.1
308.5
 
=========
     FINAL SCORE
204.4
------------------------------------------------------------------------
----

Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086
sowmya.adiga@wipro.com


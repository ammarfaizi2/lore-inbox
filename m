Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267468AbTACJAv>; Fri, 3 Jan 2003 04:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267469AbTACJAv>; Fri, 3 Jan 2003 04:00:51 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:17642 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267468AbTACJAt>; Fri, 3 Jan 2003 04:00:49 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.54mm2
Date: Fri, 3 Jan 2003 14:39:07 +0530
Message-ID: <003d01c2b307$c5496620$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 03 Jan 2003 09:09:07.0595 (UTC) FILETIME=[C54AC5B0:01C2B307]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the unixbench result for kernel 2.5.54mm2. Kernel 2.5.54mm2
when compared with kernel 2.5.54 showed difference of performance in
following tests:- 
we can find that 2.5.54mm2 had a drop in performance
in file copy operation
========================================================================
====
File Copy 1024 bufsize 2000 maxblocks[2.5.54mm2]     66095.0KBps 
File Copy 1024 bufsize 2000 maxblocks[2.5.54]        69507.0KBps
     
File Copy 256 bufsize 500 maxblocks[2.5.54mm2]       32065.0KBps 
File Copy 1024 bufsize 2000 maxblocks[2.5.54]        35402.0KBps

File Copy 4096 bufsize 8000 maxblocks[2.5.54mm2]     88297.0KBps 
File Copy 1024 bufsize 2000 maxblocks[2.5.54]        90025.0KBps 
    
========================================================================
====
*There is no significant difference in other test result.

------------------------------------------------------------------------
----
					kernel 2.5.54mm2
------------------------------------------------------------------------
----
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.54 #10 Fri Jan 3 09:18:32 IST 2003 i686
unknown
Start Benchmark Run: Fri Jan  3 10:39:33 IST 2003
1 interactive users.
10:39am  up 1 min,  1 user,  load average: 0.15, 0.08, 0.03
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   4576280   3266092  59% /data

Dhrystone 2 using register variables     1804686.3lps (10.0 secs,10
samples)
Double-Precision Whetstone               476.6MWIPS   (10.0 secs,10
samples)
System Call Overhead                     449293.5 lps (10.0 secs,10
samples)
Pipe Throughput                          437334.0 lps (10.0 secs,10
samples)
Pipe-based Context Switching             192422.0 lps (10.0 secs,10
samples)
Process Creation                         3795.2 lps   (30.0 secs, 3
samples)
Execl Throughput                         881.4 lps    (30.0 secs, 3
samples)
File Read 1024 bufsize 2000 maxblocks    242924.0KBps (30.0 secs, 3
samples)
File Write 1024 bufsize 2000 maxblocks   93954.0KBps  (30.0 secs, 3
samples)
File Copy 1024 bufsize 2000 maxblocks    66095.0KBps  (30.0 secs, 3
samples)
File Read 256 bufsize 500 maxblocks      111993.0KBps (30.0 secs, 3
samples)
File Write 256 bufsize 500 maxblocks     49555.0 KBps (30.0 secs, 3
samples)
File Copy 256 bufsize 500 maxblocks      32065.0 KBps (30.0 secs, 3
samples)
File Read 4096 bufsize 8000 maxblocks    336507.0KBps (30.0 secs, 3
samples)
File Write 4096 bufsize 8000 maxblocks   124444.0KBps (30.0 secs, 3
samples)
File Copy 4096 bufsize 8000 maxblocks    88297.0 KBps (30.0 secs, 3
samples)
Shell Scripts (1 concurrent)             882.4 lpm    (60.0 secs, 3
samples)
Shell Scripts (8 concurrent)             116.0 lpm    (60.0 secs, 3
samples)
Shell Scripts (16 concurrent)            57.0 lpm     (60.0 secs, 3
samples)
Arithmetic Test (type = short)           208190.1 lps (10.0 secs, 3
samples)
Arithmetic Test (type = int)             225131.2 lps (10.0 secs, 3
samples)
Arithmetic Test (type = long)            225136.4 lps (10.0 secs, 3
samples)
Arithmetic Test (type = float)           227408.6 lps (10.0 secs, 3
samples)
Arithmetic Test (type = double)          227410.0 lps (10.0 secs, 3
samples)
Arithoh                                  3996455.5 lps(10.0 secs, 3
samples)
C Compiler Throughput                    406.0 lpm    (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places         32513.2 lpm  (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi           28918.3 lps  (20.0 secs, 3
samples)


                     INDEX VALUES            
TEST                                      BASELINE     RESULT     INDEX

Dhrystone 2 using register variables      116700.0    1804686.3   154.6
Double-Precision Whetstone                55.0        476.6       86.7
Execl Throughput                          43.0        881.4       205.0
File Copy 1024 bufsize 2000 maxblocks     3960.0      66095.0     166.9
File Copy 256 bufsize 500 maxblocks       1655.0      32065.0     193.7
File Copy 4096 bufsize 8000 maxblocks     5800.0      88297.0     152.2
Pipe Throughput                           12440.0     437334.0    351.6
Process Creation                          126.0       3795.2      301.2
Shell Scripts (8 concurrent)              6.0         116.0       193.3
System Call Overhead                      15000.0     449293.5    299.5
 
=========
     FINAL SCORE                                                  195.8
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


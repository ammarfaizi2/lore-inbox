Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267382AbTACEwj>; Thu, 2 Jan 2003 23:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbTACEwj>; Thu, 2 Jan 2003 23:52:39 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:3726 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267382AbTACEwf>; Thu, 2 Jan 2003 23:52:35 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.54mm1.
Date: Fri, 3 Jan 2003 10:30:53 +0530
Message-ID: <002b01c2b2e5$17885220$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 03 Jan 2003 05:00:53.0253 (UTC) FILETIME=[17928B50:01C2B2E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the unixbench result for kernel 2.5.54mm1. Kernel 2.5.54mm1
when compared with kernel 2.5.54 showed difference of performance in
following tests:- 
========================================================================
====
File Copy 1024 bufsize 2000 maxblocks[2.5.54mm1]    67146.0KBps  
File Copy 1024 bufsize 2000 maxblocks[2.5.54]       69507.0KBps


File Copy 256 bufsize 500 maxblocks[2.5.54mm1]      32733.0KBps 
File Copy 256 bufsize 500 maxblocks[2.5.54]         35402.0KBps
                                           
File Copy 4096 bufsize 8000 maxblocks[2.5.54mm1]    88675.0KBps 
File Copy 4096 bufsize 8000 maxblocks[2.5.54]       90025.0KBps

========================================================================
===
*There is no much difference in other test result.

------------------------------------------------------------------------
----					kernel 2.5.54mm1
------------------------------------------------------------------------
----
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.54 #8 Thu Jan 2 15:09:44 IST 2003 i686
unknown
Start Benchmark Run: Thu Jan  2 16:53:35 IST 2003
1 interactive users.
4:53pm  up 1 min,  1 user,  load average: 0.14, 0.09, 0.03
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   4322740   3519632  56% /data

Dhrystone 2 using register variables     1804912.5lps (10.0 secs,10
samples)
Double-Precision Whetstone               476.3MWIPS   (10.0 secs,10
samples)
System Call Overhead                     464363.2lps  (10.0 secs,10
samples)
Pipe Throughput                          444949.2lps  (10.0 secs,10
samples)
Pipe-based Context Switching             196155.6lps  (10.0 secs,10
samples)
Process Creation                         4903.9 lps   (30.0 secs, 3
samples)
Execl Throughput                         907.5 lps    (30.0 secs, 3
samples)
File Read 1024 bufsize 2000 maxblocks    244029.0KBps (30.0 secs, 3
samples)
File Write 1024 bufsize 2000 maxblocks   94377.0KBps  (30.0 secs, 3
samples)
File Copy 1024 bufsize 2000 maxblocks    67146.0KBps  (30.0 secs, 3
samples)
File Read 256 bufsize 500 maxblocks      113200.0KBps (30.0 secs, 3
samples)
File Write 256 bufsize 500 maxblocks     49755.0KBps  (30.0 secs, 3
samples)
File Copy 256 bufsize 500 maxblocks      32733.0KBps  (30.0 secs, 3
samples)
File Read 4096 bufsize 8000 maxblocks    338731.0KBps (30.0 secs, 3
samples)
File Write 4096 bufsize 8000 maxblocks   124266.0KBps (30.0 secs, 3
samples)
File Copy 4096 bufsize 8000 maxblocks    88675.0KBps  (30.0 secs, 3
samples)
Shell Scripts (1 concurrent)             886.1 lpm    (60.0 secs, 3
samples)
Shell Scripts (8 concurrent)             116.0 lpm    (60.0 secs, 3
samples)
Shell Scripts (16 concurrent)            57.3 lpm     (60.0 secs, 3
samples)
Arithmetic Test (type = short)           208152.6 lps (10.0 secs, 3
samples)
Arithmetic Test (type = int)             225050.6 lps (10.0 secs, 3
samples)
Arithmetic Test (type = long)            225141.4 lps (10.0 secs, 3
samples)
Arithmetic Test (type = float)           227412.2 lps (10.0 secs, 3
samples)
Arithmetic Test (type = double)          227411.2 lps (10.0 secs, 3
samples)
Arithoh                                  3992482.2 lps(10.0 secs, 3
samples)
C Compiler Throughput                    407.4 lpm    (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places         33752.9 lpm  (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi           28920.0 lps  (20.0 secs, 3
samples)


                     INDEX VALUES            
TEST                                      BASELINE   RESULT    INDEX

Dhrystone 2 using register variables      116700.0   1804912.5  154.7
Double-Precision Whetstone                55.0       476.3      86.6
Execl Throughput                          43.0       907.5      211.0
File Copy 1024 bufsize 2000 maxblocks     3960.0     67146.0    169.6
File Copy 256 bufsize 500 maxblocks       1655.0     32733.0    197.8
File Copy 4096 bufsize 8000 maxblocks     5800.0     88675.0    152.9
Pipe Throughput                           12440.0    444949.2   357.7
Process Creation                          126.0      4903.9     389.2
Shell Scripts (8 concurrent)              6.0        116.0      193.3
System Call Overhead                      15000.0    464363.2   309.6
                                                               =========
     FINAL SCORE                                                203.3

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


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbTATKM7>; Mon, 20 Jan 2003 05:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTATKM7>; Mon, 20 Jan 2003 05:12:59 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:9709 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261527AbTATKM4>; Mon, 20 Jan 2003 05:12:56 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] unixbench result for kernel 2.5.59
Date: Mon, 20 Jan 2003 15:51:46 +0530
Message-ID: <003b01c2c06d$bc9ab920$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 20 Jan 2003 10:21:46.0829 (UTC) FILETIME=[BC9ED7D0:01C2C06D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the unixbench result for kernel 2.5.59. Kernel 2.5.59 when
compared with kernel 2.5.58 showed difference of performance in
following tests:- 
========================================================================
Execl Throughput[2.5.59]                          952.5lps   
Execl Throughput[2.5.58]                          866.4lps  
  
File Copy 1024 bufsize 2000 maxblocks[2.5.59]     71112.0KBps 
File Copy 1024 bufsize 2000 maxblocks[2.5.58]     69405.0KBps      

File Copy 256 bufsize 500 maxblocks[2.5.59]       36978.0KBps     
File Copy 256 bufsize 500 maxblocks[2.5.58]       34824.0KBps 
========================================================================
====
*There is no much difference in other test result.

------------------------------------------------------------------------
----
					kernel-2.5.59
------------------------------------------------------------------------
----
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.59 #14 Mon Jan 20 12:12:35 IST 2003 i686
unknown
Start Benchmark Run: Mon Jan 20 13:57:54 IST 2003
1 interactive users.
1:57pm  up 9 min,  1 user,  load average: 0.01, 0.02, 0.00
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   3315448   4526924  43% /data

Dhrystone 2 using register variables    1804740.6 lps (10.0
secs,10samples)
Double-Precision Whetstone              477.1 MWIPS   (10.0
secs,10samples)
System Call Overhead                    460969.1lps   (10.0
secs,10samples)
Pipe Throughput                         451357.3 lps  (10.0
secs,10samples)
Pipe-based Context Switching            205677.1 lps  (10.0
secs,10samples)
Process Creation                        4502.7 lps    (30.0 secs,
3samples)
Execl Throughput                        952.5 lps     (29.7 secs,
3samples)
File Read 1024 bufsize 2000 maxblocks   243601.0KBps  (30.0 secs,
3samples)
File Write 1024 bufsize 2000 maxblocks  104533.0KBps  (30.0 secs,
3samples)
File Copy 1024 bufsize 2000 maxblocks   71112.0 KBps  (30.0 secs,
3samples)
File Read 256 bufsize 500 maxblocks     113743.0KBps  (30.0 secs,
3samples)
File Write 256 bufsize 500 maxblocks    61466.0 KBps  (30.0 secs,
3samples)
File Copy 256 bufsize 500 maxblocks     36978.0 KBps  (30.0 secs,
3samples)
File Read 4096 bufsize 8000 maxblocks   335488.0KBps  (30.0 secs,
3samples)
File Write 4096 bufsize 8000 maxblocks  127733.0KBps  (30.0 secs,
3samples)
File Copy 4096 bufsize 8000 maxblocks   89889.0 KBps  (30.0 secs,
3samples)
Shell Scripts (1 concurrent)            889.8 lpm     (60.0 secs,
3samples)
Shell Scripts (8 concurrent)            115.0 lpm     (60.0 secs,
3samples)
Shell Scripts (16 concurrent)           58.0 lpm      (60.0 secs,
3samples)
Arithmetic Test (type = short)          208210.2 lps  (10.0 secs,
3samples)
Arithmetic Test (type = int)            225125.9 lps  (10.0 secs,
3samples)
Arithmetic Test (type = long)           225088.4 lps  (10.0 secs,
3samples)
Arithmetic Test (type = float)          227555.3 lps  (10.0 secs,
3samples)
Arithmetic Test (type = double)         227558.8 lps  (10.0 secs,
3samples)
Arithoh                                 3998978.2 lps (10.0 secs,
3samples)
C Compiler Throughput                   410.0 lpm     (60.0 secs,
3samples)
Dc: sqrt(2) to 99 decimal places        34186.5 lpm   (30.0 secs,
3samples)
Recursion Test--Tower of Hanoi          28899.1 lps   (20.0 secs,
3samples)


                     INDEX VALUES            
TEST                                      BASELINE     RESULT    INDEX

Dhrystone 2 using register variables      116700.0  1804740.6    154.6
Double-Precision Whetstone                55.0      477.1        86.7
Execl Throughput                          43.0      952.5        221.5
File Copy 1024 bufsize 2000 maxblocks     3960.0    71112.0      179.6
File Copy 256 bufsize 500 maxblocks       1655.0    36978.0      223.4
File Copy 4096 bufsize 8000 maxblocks     5800.0    89889.0      155.0
Pipe Throughput                           12440.0   451357.3     362.8
Process Creation                          126.0     4502.7       357.4
Shell Scripts (8 concurrent)              6.0       115.0        191.7
System Call Overhead                      15000.0   460969.1     307.3
 
=========
     FINAL SCORE                                                 206.5
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
 


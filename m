Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSLZGB5>; Thu, 26 Dec 2002 01:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSLZGB5>; Thu, 26 Dec 2002 01:01:57 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:22656 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262415AbSLZGBx>; Thu, 26 Dec 2002 01:01:53 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.53
Date: Thu, 26 Dec 2002 11:39:54 +0530
Organization: Wipro Technologies
Message-ID: <001e01c2aca5$68e75e90$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
X-OriginalArrivalTime: 26 Dec 2002 06:09:54.0478 (UTC) FILETIME=[68A154E0:01C2ACA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the unixbench result for kernel 2.5.53. Kernel 2.5.53 when
compared with kernel 2.5.52 showed difference of performance in
following tests:-
========================================================================
===
1 Dhrystone 2 using register variables[2.5.53]        1805936.3 
  Dhrystone 2 using register variables[2.5.52]        1753628.8      

2 System Call Overhead[2.5.53]                        464936.0 
  System Call Overhead[2.5.52]                        450934.1   

========================================================================
====
*There is no much difference in other test result.

------------------------------------------------------------------------
---
                             kernel 2.5.53
------------------------------------------------------------------------
---
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.53 #5 Tue Dec 24 13:36:45 IST 2002 i686
unknown
Start Benchmark Run: Tue Dec 24 15:39:28 IST 2002
3 interactive users.
3:39pm  up  1:49,  3 users,  load average: 0.10, 0.03, 0.01
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   4308952   3533420  55% /data

Dhrystone 2 using register variables     1805936.3lps (10.0 secs,10
samples)
Double-Precision Whetstone               477.1MWIPS   (10.0 secs,10
samples)
System Call Overhead                     464936.0lps  (10.0 secs,10
samples)
Pipe Throughput                          448266.7lps  (10.0 secs,10
samples)
Pipe-based Context Switching             198940.0lps  (10.0 secs,10
samples)
Process Creation                         4428.7 lps   (30.0 secs, 3
samples)
Execl Throughput                         910.1 lps    (29.7 secs, 3
samples)
File Read 1024 bufsize 2000 maxblocks    241397.0KBps (30.0 secs, 3
samples)
File Write 1024 bufsize 2000 maxblocks   100755.0KBps (30.0 secs, 3
samples)
File Copy 1024 bufsize 2000 maxblocks    69697.0KBps  (30.0 secs, 3
samples)
File Read 256 bufsize 500 maxblocks      112989.0KBps (30.0 secs, 3
samples)
File Write 256 bufsize 500 maxblocks     56950.0KBps  (30.0 secs, 3
samples)
File Copy 256 bufsize 500 maxblocks      35835.0 KBps (30.0 secs, 3
samples)
File Read 4096 bufsize 8000 maxblocks    339040.0 KBps(30.0 secs, 3
samples)
File Write 4096 bufsize 8000 maxblocks   125866.0 KBps(30.0 secs, 3
samples)
File Copy 4096 bufsize 8000 maxblocks    89616.0 KBps (30.0 secs, 3
samples)
Shell Scripts (1 concurrent)             841.0 lpm    (60.0 secs, 3
samples)
Shell Scripts (8 concurrent)             111.0 lpm    (60.0 secs, 3
samples)
Shell Scripts (16 concurrent)            56.0 lpm     (60.0 secs, 3
samples)
Arithmetic Test (type = short)           208273.3lps  (10.0 secs, 3
samples)
Arithmetic Test (type = int)             225260.3 lps (10.0 secs, 3
samples)
Arithmetic Test (type = long)            225281.8 lps (10.0 secs, 3
samples)
Arithmetic Test (type = float)           227632.2 lps (10.0 secs, 3
samples)
Arithmetic Test (type = double)          227562.0 lps (10.0 secs, 3
samples)
Arithoh                                  3997659.1lps (10.0 secs, 3
samples)
C Compiler Throughput                    408.7 lpm    (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places         32559.2 lpm  (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi           28908.3 lps  (20.0 secs, 3
samples)


                     INDEX VALUES            
TEST                                       BASELINE     RESULT
INDEX

Dhrystone 2 using register variables       116700.0   1805936.3
154.8
Double-Precision Whetstone                 55.0       477.1         86.7
Execl Throughput                           43.0       910.1
211.7
File Copy 1024 bufsize 2000 maxblocks      3960.0     69697.0
176.0
File Copy 256 bufsize 500 maxblocks        1655.0     35835.0
216.5
File Copy 4096 bufsize 8000 maxblocks      5800.0     89616.0
154.5
Pipe Throughput                            12440.0    448266.7
360.3
Process Creation                           126.0      4428.7
351.5
Shell Scripts (8 concurrent)               6.0        111.0
185.0
System Call Overhead                       15000.0    464936.0
310.0
 
=========
     FINAL SCORE
203.5
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


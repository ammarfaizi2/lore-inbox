Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbTAMIaw>; Mon, 13 Jan 2003 03:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267626AbTAMIaw>; Mon, 13 Jan 2003 03:30:52 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:20971 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267472AbTAMIas>; Mon, 13 Jan 2003 03:30:48 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.56.
Date: Mon, 13 Jan 2003 14:09:26 +0530
Message-ID: <00fb01c2badf$47916720$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 13 Jan 2003 08:39:26.0123 (UTC) FILETIME=[479537B0:01C2BADF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Here are the unixbench result for kernel 2.5.56. when compared
with kernel 2.5.55 there was no significant differnece in the test
results.

------------------------------------------------------------------------
----
                                 kernel-2.5.56
------------------------------------------------------------------------
----    BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.56 #11 Mon Jan 13 09:39:52 IST 2003 i686
unknown
Start Benchmark Run: Mon Jan 13 11:20:42 IST 2003
1 interactive users.
11:20am  up 3 min,  1 user,  load average: 0.01, 0.04, 0.01
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   4069092   3773280  52% /data

Dhrystone 2 using register variables     1804724.6lps  (10.0
secs,10samples)
Double-Precision Whetstone               476.1  MWIPS  (10.0
secs,10samples)
System Call Overhead                     447528.3 lps  (10.0
secs,10samples)
Pipe Throughput                          444037.8 lps  (10.0
secs,10samples)
Pipe-based Context Switching             202318.6 lps  (10.0
secs,10samples)
Process Creation                         3878.9   lps  (30.0 secs,
3samples)
Execl Throughput                         895.1    lps  (29.8 secs,
3samples)
File Read 1024 bufsize 2000 maxblocks    244628.0 KBps (30.0 secs,
3samples)
File Write 1024 bufsize 2000 maxblocks   97111.0  KBps (30.0 secs,
3samples)
File Copy 1024 bufsize 2000 maxblocks    67393.0  KBps (30.0 secs,
3samples)
File Read 256 bufsize 500 maxblocks      113043.0 KBps (30.0 secs,
3samples)
File Write 256 bufsize 500 maxblocks     52833.0  KBps (30.0 secs,
3samples)
File Copy 256 bufsize 500 maxblocks      32197.0  KBps (30.0 secs,
3samples)
File Read 4096 bufsize 8000 maxblocks    338025.0 KBps (30.0 secs,
3samples)
File Write 4096 bufsize 8000 maxblocks   125066.0 KBps (30.0 secs,
3samples)
File Copy 4096 bufsize 8000 maxblocks    88974.0 KBps  (30.0 secs,
3samples)
Shell Scripts (1 concurrent)             887.7 lpm     (60.0 secs,
3samples)
Shell Scripts (8 concurrent)             115.7 lpm     (60.0 secs,
3samples)
Shell Scripts (16 concurrent)            58.0 lpm      (60.0 secs,
3samples)
Arithmetic Test (type = short)           208202.9 lps  (10.0 secs,
3samples)
Arithmetic Test (type = int)             225156.4 lps  (10.0 secs,
3samples)
Arithmetic Test (type = long)            225187.9 lps  (10.0 secs,
3samples)
Arithmetic Test (type = float)           227411.9 lps  (10.0 secs,
3samples)
Arithmetic Test (type = double)          227409.9 lps  (10.0 secs,
3samples)
Arithoh                                  3995124.7 lps (10.0 secs,
3samples)
C Compiler Throughput                    409.0 lpm     (60.0 secs,
3samples)
Dc: sqrt(2) to 99 decimal places         34546.5 lpm   (30.0 secs,
3samples)
Recursion Test--Tower of Hanoi           28910.0 lps   (20.0 secs,
3samples)


                     INDEX VALUES            
TEST                                       BASELINE     RESULT     INDEX

Dhrystone 2 using register variables       116700.0   1804724.6    154.6
Double-Precision Whetstone                 55.0       476.1        86.6
Execl Throughput                           43.0       895.1        208.2
File Copy 1024 bufsize 2000 maxblocks      3960.0     67393.0      170.2
File Copy 256 bufsize 500 maxblocks        1655.0     32197.0      194.5
File Copy 4096 bufsize 8000 maxblocks      5800.0     88974.0      153.4
Pipe Throughput                            12440.0    444037.8     356.9
Process Creation                           126.0      3878.9       307.8
Shell Scripts (8 concurrent)               6.0        115.7        192.8
System Call Overhead                       15000.0    447528.3     298.4
 
=========
     FINAL SCORE                                                   197.3
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
 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268040AbTBMNqn>; Thu, 13 Feb 2003 08:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268041AbTBMNqn>; Thu, 13 Feb 2003 08:46:43 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:47008 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S268040AbTBMNql>; Thu, 13 Feb 2003 08:46:41 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.60.
Date: Thu, 13 Feb 2003 19:26:14 +0530
Message-ID: <003e01c2d367$ac58d3f0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 13 Feb 2003 13:56:14.0894 (UTC) FILETIME=[AC7FBCE0:01C2D367]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the unixbench result for kernel 2.5.60. when compared with
kernel 2.5.59 there was no significant differnece in the test results.

Test Machine details
---------------------
processor : 0(single processor)
vendor_id : GenuineIntel
cpu family : 6
model  : 8
model name : Pentium III (Coppermine)
stepping : 10
cpu MHz  : 868.275
cache size : 256 KB
fdiv_bug : no
hlt_bug  : no
f00f_bug : no
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 2
wp  : yes
flags  : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse bogomips : 1716.22
------------------------------------------------------------------------
---
				          2.5.60
------------------------------------------------------------------------
--
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux sowmya 2.5.60 #2 SMP Tue Feb 11 15:14:35 IST 2003 i686 
GNU/Linux
Start Benchmark Run: Thu Feb 13 11:26:35 IST 2003
1 interactive users.
11:26am  up  2:14,  1 user,  load average: 0.00, 0.13, 0.08
lrwxrwxrwx    1 root     root     4 Feb  4 15:21 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda3              9835584   3055480   6280484  33% /home

Dhrystone 2 using register variables    1822374.2 lps (10.0secs,10
samples)
Double-Precision Whetstone              481.5 MWIPS   (10.0
secs,10samples)
System Call Overhead                    405113.1 lps  (10.0
secs,10samples)
Pipe Throughput                         317941.9 lps  (10.0
secs,10samples)
Pipe-based Context Switching            135749.0 lps  (10.0
secs,10samples)
Process Creation                        5157.3 lps    (30.0 secs,3
samples)
Execl Throughput                        1184.7 lps    (29.9 secs,3
samples)
File Read 1024 bufsize 2000 maxblocks   218010.0 KBps (30.0 secs,3
samples)
File Write 1024 bufsize 2000 maxblocks  96533.0 KBps  (30.0 secs,3
samples)
File Copy 1024 bufsize 2000 maxblocks   66564.0 KBps  (30.0 secs,3
samples)
File Read 256 bufsize 500 maxblocks     94203.0 KBps  (30.0 secs,3
samples)
File Write 256 bufsize 500 maxblocks    52137.0 KBps  (30.0 secs,3
samples)
File Copy 256 bufsize 500 maxblocks     32387.0 KBps  (30.0 secs,3
samples)
File Read 4096 bufsize 8000 maxblocks   320907.0 KBps (30.0 secs,3
samples)
File Write 4096 bufsize 8000 maxblocks  124977.0 KBps (30.0 secs,3
samples)
File Copy 4096 bufsize 8000 maxblocks   88151.0 KBps  (30.0 secs,3
samples)
Shell Scripts (1 concurrent)            827.7 lpm     (60.0 secs,3
samples)
Shell Scripts (8 concurrent)            107.0 lpm     (60.0
secs,3samples)
Shell Scripts (16 concurrent)           54.0 lpm      (60.0 secs,3
samples)
Arithmetic Test (type = short)          217523.7 lps  (10.0 secs,3
samples)
Arithmetic Test (type = int)            224252.7 lps  (10.0 secs,3
samples)
Arithmetic Test (type = long)           224250.1 lps  (10.0 secs,3
samples)
Arithmetic Test (type = float)          227547.5 lps  (10.0 secs,3
samples)
Arithmetic Test (type = double)         227546.9 lps  (10.0 secs,3
samples)
Arithoh                                 3990048.9 lps (10.0 secs,3
samples)
C Compiler Throughput                   363.7 lpm     (60.0 secs,3
samples)
Dc: sqrt(2) to 99 decimal places        39450.0 lpm   (30.0 secs,3
samples)
Recursion Test--Tower of Hanoi          32027.0 lps   (20.0 secs,3
samples)


                     INDEX VALUES            
TEST                                     BASELINE     RESULT      INDEX

Dhrystone 2 using register variables     116700.0    1822374.2    156.2
Double-Precision Whetstone               55.0        481.5        87.5
Execl Throughput                         43.0        1184.7       275.5
File Copy 1024 bufsize 2000 maxblocks    3960.0      66564.0      168.1
File Copy 256 bufsize 500 maxblocks      1655.0      32387.0      195.7
File Copy 4096 bufsize 8000 maxblocks    5800.0      88151.0      152.0
Pipe Throughput                          12440.0     317941.9     255.6
Process Creation                         126.0       5157.3       409.3
Shell Scripts (8 concurrent)             6.0         107.0        178.3
System Call Overhead                     15000.0     405113.1     270.1
 
=========
     FINAL SCORE                                                  198.5

------------------------------------------------------------------------
--
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbTBRLAa>; Tue, 18 Feb 2003 06:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267554AbTBRLAa>; Tue, 18 Feb 2003 06:00:30 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:31667 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267534AbTBRLA2>; Tue, 18 Feb 2003 06:00:28 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] unixbench result for kernel 2.5.62.
Date: Tue, 18 Feb 2003 16:40:11 +0530
Message-ID: <015d01c2d73e$4ddc42a0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
X-OriginalArrivalTime: 18 Feb 2003 11:10:11.0287 (UTC) FILETIME=[4DCAB670:01C2D73E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Here is the unixbench result for kernel 2.5.62. when compared
with kernel 2.5.61 there was no significant difference in the test
results.	

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
				    kernel-2.5.62
------------------------------------------------------------------------
---
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux sowmya 2.5.62 #4 SMP Tue Feb 18 11:34:19 IST 2003 i686
i686 i386 GNU/Linux
Start Benchmark Run: Tue Feb 18 14:03:10 IST 2003
1 interactive users.
2:03pm  up 2 min,  1 user,  load average: 0.06, 0.08, 0.03
lrwxrwxrwx    1 root     root            4 Feb  4 15:21 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda3              9835584   3097284   6238680  34% /home

Dhrystone 2 using register variables    1822052.3 lps (10.0
secs,10samples)
Double-Precision Whetstone              481.7 MWIPS   (10.0
secs,10samples)
System Call Overhead                    391196.7 lps  (10.0
secs,10samples)
Pipe Throughput                         314888.8 lps  (10.0
secs,10samples)
Pipe-based Context Switching            137403.8 lps  (10.0
secs,10samples)
Process Creation                        5633.4 lps    (30.0 secs,
3samples)
Execl Throughput                        1227.5 lps    (29.9 secs,
3samples)
File Read 1024 bufsize 2000 maxblocks   220065.0 KBps (30.0 secs,
3samples)
File Write 1024 bufsize 2000 maxblocks  98244.0 KBps  (30.0 secs,
3samples)
File Copy 1024 bufsize 2000 maxblocks   66163.0 KBps  (30.0 secs,
3samples)
File Read 256 bufsize 500 maxblocks     96529.0 KBps  (30.0 secs,
3samples)
File Write 256 bufsize 500 maxblocks    53600.0 KBps  (30.0 secs,
3samples)
File Copy 256 bufsize 500 maxblocks     31818.0 KBps  (30.0 secs,
3samples)
File Read 4096 bufsize 8000 maxblocks   321094.0 KBps (30.0 secs,
3samples)
File Write 4096 bufsize 8000 maxblocks  125955.0 KBps (30.0 secs,
3samples)
File Copy 4096 bufsize 8000 maxblocks   88010.0 KBps  (30.0 secs,
3samples)
Shell Scripts (1 concurrent)            828.3 lpm     (60.0 secs,
3samples)
Shell Scripts (8 concurrent)            107.0 lpm     (60.0 secs,
3samples)
Shell Scripts (16 concurrent)           54.0 lpm      (60.0 secs,
3samples)
Arithmetic Test (type = short)          217572.4 lps  (10.0 secs,
3samples)
Arithmetic Test (type = int)            224318.0 lps  (10.0 secs,
3samples)
Arithmetic Test (type = long)           224324.9 lps  (10.0 secs,
3samples)
Arithmetic Test (type = float)          227467.1 lps  (10.0 secs,
3samples)
Arithmetic Test (type = double)         227454.4 lps  (10.0 secs,
3samples)
Arithoh                                 3990121.3 lps (10.0 secs,
3samples)
C Compiler Throughput                   364.3 lpm     (60.0 secs,
3samples)
Dc: sqrt(2) to 99 decimal places        40483.0 lpm   (30.0 secs,
3samples)
Recursion Test--Tower of Hanoi          32009.9 lps   (20.0 secs,
3samples)


                     INDEX VALUES            
TEST                                      BASELINE     RESULT      INDEX

Dhrystone 2 using register variables      116700.0  1822052.3      156.1
Double-Precision Whetstone                55.0      481.7          87.6
Execl Throughput                          43.0      1227.5         285.5
File Copy 1024 bufsize 2000 maxblocks     3960.0    66163.0        167.1
File Copy 256 bufsize 500 maxblocks       1655.0    31818.0        192.3
File Copy 4096 bufsize 8000 maxblocks     5800.0    88010.0        151.7
Pipe Throughput                           12440.0   314888.8       253.1
Process Creation                          126.0     5633.4         447.1
Shell Scripts (8 concurrent)              6.0       107.0          178.3
System Call Overhead                      15000.0   391196.7       260.8
 
=========
     FINAL SCORE                                                   199.6
------------------------------------------------------------------------
---
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086


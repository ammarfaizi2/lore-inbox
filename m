Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267781AbTCFEmn>; Wed, 5 Mar 2003 23:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267786AbTCFEmn>; Wed, 5 Mar 2003 23:42:43 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:63678 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267781AbTCFEmk>; Wed, 5 Mar 2003 23:42:40 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.64.
Date: Thu, 6 Mar 2003 10:22:56 +0530
Message-ID: <006001c2e39c$40c0dda0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 06 Mar 2003 04:52:56.0023 (UTC) FILETIME=[40BB8670:01C2E39C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the unixbench result for kernel 2.5.64. when compared with
kernel 2.5.63 showed difference of performance in following tests:- 
========================================================================
File Copy 1024 bufsize 2000 maxblocks[2.5.64]     77329.0KBps 
File Copy 1024 bufsize 2000 maxblocks[2.5.63]     65577.0KBps
     
File Copy 256 bufsize 500 maxblocks[2.5.64]       36765.0KBps 
File Copy 1024 bufsize 2000 maxblocks[2.5.63]     31138.0KBps

File Copy 4096 bufsize 8000 maxblocks[2.5.64]     103982.0KBps 
File Copy 1024 bufsize 2000 maxblocks[2.5.63]     87666.0KBps 
    
========================================================================
*There is no significant difference in other test result.

------------------------------------------------------------------------
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
					kernel-2.5.64
------------------------------------------------------------------------
---
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux sowmya 2.5.64 #6 SMP Wed Mar 5 14:43:37 IST 2003 i686
i686 i386 GNU/Linux
Start Benchmark Run: Wed Mar  5 16:17:19 IST 2003
1 interactive users.
4:17pm  up  1:28,  1 user,  load average: 0.00, 0.09, 0.46
lrwxrwxrwx    1 root     root            4 Feb  4 15:21 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda3              9835584   3068672   6267292  33% /home

Dhrystone 2 using register variables     1822541.4 lps(10.2secs,
10samples)
Double-Precision Whetstone               482.0 MWIPS  (10.0
secs,10samples)
System Call Overhead                     391163.5 lps (10.2
secs,10samples)
Pipe Throughput                          309606.4 lps (10.2
secs,10samples)
Pipe-based Context Switching             134779.6 lps (10.2
secs,10samples)
Process Creation                         5505.7   lps (42.9 secs,
3samples)
Execl Throughput                         1192.9   lps (29.8 secs,
3samples)
File Read 1024 bufsize 2000 maxblocks    229462.0 KBps(30.0 secs,
3samples)
File Write 1024 bufsize 2000 maxblocks   131805.0 KBps(30.0 secs,
3samples)
File Copy 1024 bufsize 2000 maxblocks    77329.0  KBps(30.0 secs,
3samples)
File Read 256 bufsize 500 maxblocks      99747.0  KBps(30.0 secs,
3samples)
File Write 256 bufsize 500 maxblocks     68725.0  KBps(30.0 secs,
3samples)
File Copy 256 bufsize 500 maxblocks      36765.0  KBps(30.0 secs,
3samples)
File Read 4096 bufsize 8000 maxblocks    339453.0 KBps(30.0 secs,
3samples)
File Write 4096 bufsize 8000 maxblocks   171934.0 KBps(30.0 secs,
3samples)
File Copy 4096 bufsize 8000 maxblocks    103982.0 KBps(30.0 secs,
3samples)
Shell Scripts (1 concurrent)             823.9    lpm (67.0 secs,
3samples)
Shell Scripts (8 concurrent)             106.0    lpm (62.3 secs,
3samples)
Shell Scripts (16 concurrent)            53.1     lpm (62.2 secs,
3samples)
Arithmetic Test (type = short)           217138.7 lps (10.2 secs,
3samples)
Arithmetic Test (type = int)             224316.8 lps (10.2 secs,
3samples)
Arithmetic Test (type = long)            224280.3 lps (10.2 secs,
3samples)
Arithmetic Test (type = float)           227549.1 lps (10.2 secs,
3samples)
Arithmetic Test (type = double)          227503.7 lps (10.2 secs,
3samples)
Arithoh                                  3990587.3 lps(10.2 secs,
3samples)
C Compiler Throughput                    363.9     lpm(63.7 secs,
3samples)
Dc: sqrt(2) to 99 decimal places         39414.6   lpm(46.0 secs,
3samples)
Recursion Test--Tower of Hanoi           32016.2   lps(29.6 secs,
3samples)


                     INDEX VALUES            
TEST                                     BASELINE     RESULT      INDEX

Dhrystone 2 using register variables     116700.0    1822541.4    156.2
Double-Precision Whetstone               55.0        482.0        87.6
Execl Throughput                         43.0        1192.9       277.4
File Copy 1024 bufsize 2000 maxblocks    3960.0      77329.0      195.3
File Copy 256 bufsize 500 maxblocks      1655.0      36765.0      222.1
File Copy 4096 bufsize 8000 maxblocks    5800.0      103982.0     179.3
Pipe Throughput                          12440.0     309606.4     248.9
Process Creation                         126.0       5505.7       437.0
Shell Scripts (8 concurrent)             6.0         106.0        176.7
System Call Overhead                     15000.0     391163.5     260.8
 
=========
     FINAL SCORE                                                  207.5
------------------------------------------------------------------------
---

Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086


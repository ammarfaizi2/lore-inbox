Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbTDIGIx (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 02:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTDIGIx (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 02:08:53 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:42236 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262658AbTDIGIt (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 02:08:49 -0400
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.67
Date: Wed, 9 Apr 2003 11:50:09 +0530
Message-ID: <001f01c2fe60$1229ccc0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
X-OriginalArrivalTime: 09 Apr 2003 06:20:09.0488 (UTC) FILETIME=[122A6900:01C2FE60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no difference in the kernel prerformance when compared with
kernel-2.5.66
------------------------------------------------------------------------
--
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
--
					kernel-2.5.67
------------------------------------------------------------------------
--
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux sowmya 2.5.67 #3 SMP Tue Apr 8 08:54:26 IST 2003 i686
i686 i386 GNU/Linux
Start Benchmark Run: Tue Apr  8 11:43:52 IST 2003
2 interactive users.
11:43am  up  2:45,  2 users,  load average: 0.00, 0.00, 0.00
lrwxrwxrwx    1 root     root            4 Mar 27 17:20 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2             		12436772   1197016  10608000  11% /home

Dhrystone 2 using register variables    1822495.5 lps
(10.0secs,10samples)
Double-Precision Whetstone              482.0 MWIPS
(10.0secs,10samples)
System Call Overhead                    387362.4 lps
(10.0secs,10samples)
Pipe Throughput                         314360.2 lps
(10.0secs,10samples)
Pipe-based Context Switching            135691.0 lps
(10.0secs,10samples)
Process Creation                        6095.5   lps  (30.0secs,
3samples)
Execl Throughput                        1308.8   lps  (29.8
secs,3samples)
File Read 1024 bufsize 2000 maxblocks   224080.0 KBps (30.0
secs,3samples)
File Write 1024 bufsize 2000 maxblocks  118866.0 KBps (30.0
secs,3samples)
File Copy 1024 bufsize 2000 maxblocks   78599.0  KBps (30.0
secs,3samples)
File Read 256 bufsize 500 maxblocks     97435.0  KBps (30.0
secs,3samples)
File Write 256 bufsize 500 maxblocks    81282.0  KBps (30.0secs,
3samples)
File Copy 256 bufsize 500 maxblocks     44176.0  KBps (30.0
secs,3samples)
File Read 4096 bufsize 8000 maxblocks   331155.0 KBps (30.0
secs,3samples)
File Write 4096 bufsize 8000 maxblocks  136888.0 KBps (30.0
secs,3samples)
File Copy 4096 bufsize 8000 maxblocks   96645.0  KBps (30.0
secs,3samples)
Shell Scripts (1 concurrent)            859.6    lpm  (60.0
secs,3samples)
Shell Scripts (8 concurrent)            114.0    lpm  (60.0
secs,3samples)
Shell Scripts (16 concurrent)           57.0     lpm  (60.0
secs,3samples)
Arithmetic Test (type = short)          217656.5 lps  (10.0
secs,3samples)
Arithmetic Test (type = int)            224315.0 lps  (10.0
secs,3samples)
Arithmetic Test (type = long)           224382.4 lps  (10.0
secs,3samples)
Arithmetic Test (type = float)          227679.5 lps  (10.0
secs,3samples)
Arithmetic Test (type = double)         227612.1 lps  (10.0
secs,3samples)
Arithoh                                 3989927.0 lps (10.0
secs,3samples)
C Compiler Throughput                   369.0     lpm (60.0
secs,3samples)
Dc: sqrt(2) to 99 decimal places        42435.7   lpm (30.0
secs,3samples)
Recursion Test--Tower of Hanoi          32017.3   lps (20.0
secs,3samples)


                     INDEX VALUES            
TEST                                      BASELINE     RESULT      INDEX

Dhrystone 2 using register variables      116700.0   1822495.5     156.2
Double-Precision Whetstone                55.0       482.0         87.6
Execl Throughput                          43.0       1308.8        304.4
File Copy 1024 bufsize 2000 maxblocks     3960.0     78599.0       198.5
File Copy 256 bufsize 500 maxblocks       1655.0     44176.0       266.9
File Copy 4096 bufsize 8000 maxblocks     5800.0     96645.0       166.6
Pipe Throughput                           12440.0    314360.2      252.7
Process Creation                          126.0      6095.5        483.8
Shell Scripts (8 concurrent)              6.0        114.0         190.0
System Call Overhead                      15000.0    387362.4      258.2
 
=========
     FINAL SCORE                                                   216.0
------------------------------------------------------------------------
--

Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086


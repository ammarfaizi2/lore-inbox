Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbSLPD7d>; Sun, 15 Dec 2002 22:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSLPD7d>; Sun, 15 Dec 2002 22:59:33 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:21658 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S264950AbSLPD7a>; Sun, 15 Dec 2002 22:59:30 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK RESULT]Unixbench result for kernel 2.5.51 with mm1 patch
Date: Mon, 16 Dec 2002 09:37:08 +0530
Organization: Wipro Technologies
Message-ID: <008c01c2a4b8$99d66ea0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 16 Dec 2002 04:07:08.0192 (UTC) FILETIME=[99D9CA00:01C2A4B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
Here are the Unixbench result for kernel 2.5.51 with mm1 patch
kernel 2.5.51 with mm1 had small drop in performance in Pipe Throughput,
When compared with kernel 2.5.51.  

________________________________________________________________________
___
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
pat pse36 mmx fxsr sse
bogomips : 1716.22

------------------------------------------------------------------------
----
                                          kernel 2.5.51
------------------------------------------------------------------------
----
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.51 #3 Tue Dec 10 11:52:13 IST 2002 i686
unknown
Start Benchmark Run: Tue Dec 10 13:23:54 IST 2002
1 interactive users.
1:23pm  up 1 min,  1 user,  load average: 0.13, 0.08, 0.03
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   2711284   5131088  35% /data

Dhrystone 2 using register variables   1753562.1 lps(10.0 secs,10
samples)
Double-Precision Whetstone             477.0 MWIPS  (10.0 secs,10
samples)
System Call Overhead                   458680.5 lps (10.0 secs,10
samples)
Pipe Throughput                        452140.4 lps (10.0 secs,10
samples)
Pipe-based Context Switching           224110.7 lps (10.0 secs,10
samples)
Process Creation                       4090.9 lps   (30.0 secs, 3
samples)
Execl Throughput                       956.9 lps    (29.9 secs, 3
samples)
File Read 1024 bufsize 2000 maxblocks  244936.0 KBps(30.0 secs, 3
samples)
File Write 1024 bufsize 2000 maxblocks 99665.0 KBps (30.0 secs, 3
samples)
File Copy 1024 bufsize 2000 maxblocks  67488.0 KBps (30.0 secs, 3
samples)
File Read 256 bufsize 500 maxblocks    114320.0 KBps(30.0 secs, 3
samples)
File Write 256 bufsize 500 maxblocks   55900.0 KBps (30.0 secs, 3
samples)
File Copy 256 bufsize 500 maxblocks    33000.0 KBps (30.0 secs, 3
samples)
File Read 4096 bufsize 8000 maxblocks  336659.0 KBps(30.0 secs, 3
samples)
File Write 4096 bufsize 8000 maxblocks 125510.0 KBps(30.0 secs, 3
samples)
File Copy 4096 bufsize 8000 maxblocks  81771.0 KBps (30.0 secs, 3
samples)
Shell Scripts (1 concurrent)           867.7 lpm   (60.0 secs,  3
samples)
Shell Scripts (8 concurrent)           113.0 lpm   (60.0 secs, 3
samples)
Shell Scripts (16 concurrent)          57.0 lpm    (60.0 secs, 3
samples)
Arithmetic Test (type = short)         208206.7 lps(10.0 secs, 3
samples)
Arithmetic Test (type = int)           225297.0 lps(10.0 secs, 3
samples)
Arithmetic Test (type = long)          225335.1 lps(10.0 secs, 3
samples)
Arithmetic Test (type = float)         227559.9 lps(10.0 secs, 3
samples)
Arithmetic Test (type = double)        227389.7 lps(10.0 secs, 3
samples)
Arithoh                                3996200.7 lps(10.0 secs, 3
samples)
C Compiler Throughput                  409.7 lpm    (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places       34294.6 lpm  (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi         29280.8 lps  (20.0 secs, 3
samples)

                     INDEX VALUES            
TEST                                    BASELINE     RESULT    INDEX
Dhrystone 2 using register variables   116700.0    1753562.1   150.3
Double-Precision Whetstone             55.0        477.0       86.7
Execl Throughput                       43.0        956.9       222.5
File Copy 1024 bufsize 2000 maxblocks  3960.0      67488.0     170.4
File Copy 256 bufsize 500 maxblocks    1655.0      33000.0     199.4
File Copy 4096 bufsize 8000 maxblocks  5800.0      81771.0     141.0
Pipe Throughput                        12440.0     452140.4    363.5
Process Creation                       126.0       4090.9      324.7
Shell Scripts (8 concurrent)           6.0         113.0       188.3
System Call Overhead                   15000.0     458680.5    305.8
                                                             =========

     FINAL SCORE                                               198.4

------------------------------------------------------------------------
----
                            Kernel 2.5.51 with mm1 patch
------------------------------------------------------------------------
----
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.51 #4 Wed Dec 11 09:28:23 IST 2002 i686
unknown
Start Benchmark Run: Wed Dec 11 10:57:58 IST 2002
1 interactive users.
10:57am  up 2 min,  1 user,  load average: 0.11, 0.12, 0.05
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   3205688   4636684  41% /data

Dhrystone 2 using register variables   1753018.7 lps(10.0 secs,10
samples)
Double-Precision Whetstone             476.9 MWIPS  (10.0 secs,10
samples)
System Call Overhead                   440265.4 lps (10.0 secs,10
samples)
Pipe Throughput                        426098.1 lps (10.0 secs,10
samples)
Pipe-based Context Switching           209261.6 lps (10.0 secs,10
samples)
Process Creation                       3873.0 lps   (30.0 secs,3
samples)
Execl Throughput                       916.7 lps    (29.6 secs,3
samples)
File Read 1024 bufsize 2000 maxblocks  241155.0 KBps(30.0 secs,3
samples)
File Write 1024 bufsize 2000 maxblocks 99176.0 KBps (30.0 secs,3
samples)
File Copy 1024 bufsize 2000 maxblocks  68595.0 KBps (30.0 secs,3
samples)
File Read 256 bufsize 500 maxblocks    108472.0 KBps(30.0 secs,3
samples)
File Write 256 bufsize 500 maxblocks   55194.0 KBps (30.0 secs,3
samples)
File Copy 256 bufsize 500 maxblocks    33934.0 KBps (30.0 secs,3
samples)
File Read 4096 bufsize 8000 maxblocks  334975.0 KBps(30.0 secs,3
samples)
File Write 4096 bufsize 8000 maxblocks 125422.0 KBps(30.0 secs,3
samples)
File Copy 4096 bufsize 8000 maxblocks  89222.0 KBps (30.0 secs,3
samples)
Shell Scripts (1 concurrent)           863.7 lpm   (60.0 secs, 3
samples)
Shell Scripts (8 concurrent)           113.7 lpm   (60.0 secs, 3
samples)
Shell Scripts (16 concurrent)          57.0 lpm    (60.0 secs, 3
samples)
Arithmetic Test (type = short)         208123.8 lps(10.0 secs, 3
samples)
Arithmetic Test (type = int)           224899.2 lps(10.0 secs, 3
samples)
Arithmetic Test (type = long)          224735.5 lps(10.0 secs, 3
samples)
Arithmetic Test (type = float)         227386.4 lps(10.0 secs, 3
samples)
Arithmetic Test (type = double)        227388.4 lps(10.0 secs, 3
samples)
Arithoh                                3996139.1 lps(10.0 secs,3
samples)
C Compiler Throughput                  408.0 lpm   (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places       32425.7 lpm (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi         29259.7 lps (20.0 secs, 3
samples)

                     INDEX VALUES            
TEST                                    BASELINE     RESULT    INDEX
Dhrystone 2 using register variables    116700.0    1753018.7  150.2
Double-Precision Whetstone              55.0        476.9      86.7
Execl Throughput                        43.0        916.7      213.2
File Copy 1024 bufsize 2000 maxblocks   3960.0      68595.0    173.2
File Copy 256 bufsize 500 maxblocks     1655.0      33934.0    205.0
File Copy 4096 bufsize 8000 maxblocks   5800.0      89222.0    153.8
Pipe Throughput                         12440.0     426098.1   342.5
Process Creation                        126.0       3873.0     307.4
Shell Scripts (8 concurrent)            6.0         113.7      189.5
System Call Overhead                    15000.0     440265.4   293.5
                                                              =========

     FINAL SCORE                                               197.2

________________________________________________________________________
____
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086
sowmya.adiga@wipro.com
 


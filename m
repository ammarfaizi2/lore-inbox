Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbTDUMJz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 08:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbTDUMJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 08:09:55 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:39116 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S263828AbTDUMJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 08:09:51 -0400
Reply-To: <sowmya.adiga@wipro.com>
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.68
Date: Mon, 21 Apr 2003 17:51:36 +0530
Organization: Wipro
Message-ID: <015501c30800$8d928d80$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 21 Apr 2003 12:21:36.0417 (UTC) FILETIME=[8D8A2910:01C30800]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the unixbench result for kernel 2.5.68. when compared with
kernel 2.5.67 showed difference of performance in following tests:-
========================================================================
==
Execl Throughput[linux-2.5.68]                    1493.0 lps       
Execl Throughput[linux-2.5.67]                    1308.8 lps   

System Call Overhead[linux-2.5.68]             	  416758.1 lps
System Call Overhead[linux-2.5.67]                387362.4 lps     
========================================================================
==
*There is no significant difference in other test result.
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
--					kernel-2.5.68
------------------------------------------------------------------------
--
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux sowmya 2.5.68 #5 SMP Mon Apr 21 11:13:30 IST 2003 i686
i686 i386 GNU/Linux
Start Benchmark Run: Mon Apr 21 13:04:23 IST 2003
1 interactive users.
1:04pm  up 9 min,  1 user,  load average: 0.00, 0.02, 0.00
lrwxrwxrwx    1 root     root            4 Mar 27 17:20 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2             12436772   1579264  10225752  14% /home

Dhrystone 2 using register variables    1822218.4 lps(10.0
secs,10samples)
Double-Precision Whetstone              494.6   MWIPS(10.0
secs,10samples)
System Call Overhead                    416758.1 lps (10.0
secs,10samples)
Pipe Throughput                         317299.2 lps (10.0
secs,10samples)
Pipe-based Context Switching            137932.5 lps (10.0
secs,10samples)
Process Creation                        6024.4   lps (30.0
secs,3samples)
Execl Throughput                        1493.0   lps (29.9
secs,3samples)
File Read 1024 bufsize 2000 maxblocks   229812.0 KBps(30.0
secs,3samples)
File Write 1024 bufsize 2000 maxblocks  120244.0 KBps(30.0
secs,3samples)
File Copy 1024 bufsize 2000 maxblocks   79432.0  KBps(30.0
secs,3samples)
File Read 256 bufsize 500 maxblocks     100734.0 KBps(30.0
secs,3samples)
File Write 256 bufsize 500 maxblocks    83616.0  KBps(30.0
secs,3samples)
File Copy 256 bufsize 500 maxblocks     45381.0  KBps(30.0
secs,3samples)
File Read 4096 bufsize 8000 maxblocks   334775.0 KBps(30.0
secs,3samples)
File Write 4096 bufsize 8000 maxblocks  137511.0 KBps(30.0
secs,3samples)
File Copy 4096 bufsize 8000 maxblocks   96969.0  KBps(30.0
secs,3samples)
Shell Scripts (1 concurrent)            886.6    lpm (60.0
secs,3samples)
Shell Scripts (8 concurrent)            117.0    lpm (60.0
secs,3samples)
Shell Scripts (16 concurrent)           58.0     lpm (60.0
secs,3samples)
Arithmetic Test (type = short)          217659.6 lps (10.0
secs,3samples)
Arithmetic Test (type = int)            224307.5 lps (10.0
secs,3samples)
Arithmetic Test (type = long)           224306.9 lps (10.0
secs,3samples)
Arithmetic Test (type = float)          227683.8 lps (10.0
secs,3samples)
Arithmetic Test (type = double)         227670.3 lps (10.0
secs,3samples)
Arithoh                                 3989663.0 lps(10.0
secs,3samples)
C Compiler Throughput                   373.5     lpm(60.0
secs,3samples)
Dc: sqrt(2) to 99 decimal places        48095.1   lpm(30.0
secs,3samples)
Recursion Test--Tower of Hanoi          31977.0   lps(20.0
secs,3samples)


                     INDEX VALUES            
TEST                                      BASELINE     RESULT      INDEX

Dhrystone 2 using register variables      116700.0    1822218.4    156.1
Double-Precision Whetstone                55.0        494.6        89.9
Execl Throughput                          43.0        1493.0       347.2
File Copy 1024 bufsize 2000 maxblocks     3960.0      79432.0      200.6
File Copy 256 bufsize 500 maxblocks       1655.0      45381.0      274.2
File Copy 4096 bufsize 8000 maxblocks     5800.0      96969.0      167.2
Pipe Throughput                           12440.0     317299.2     255.1
Process Creation                          126.0       6024.4       478.1
Shell Scripts (8 concurrent)              6.0         117.0        195.0
System Call Overhead                      15000.0     416758.1     277.8
 
=========
     FINAL SCORE                                                   222.4
------------------------------------------------------------------------
--
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086


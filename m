Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTEFLdh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbTEFLdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:33:37 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:21901 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262571AbTEFLdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:33:32 -0400
Reply-To: <sowmya.adiga@wipro.com>
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.69
Date: Tue, 6 May 2003 17:15:39 +0530
Organization: Wipro
Message-ID: <008501c313c5$043dcd30$4e07740a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 06 May 2003 11:45:39.0124 (UTC) FILETIME=[03E39F40:01C313C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the unixbench result for kernel 2.5.69. when compared with
kernel 2.5.68 showed difference of performance in following tests:-
========================================================================
Execl Throughput[linux-2.5.69]               	  1327.0 lps       
Execl Throughput[linux-2.5.68]                    1493.0 lps   

Pipe Throughput[linux-2.5.69] 	              311523.8 lps
Pipe Throughput[linux-2.5.68]                     317299.2 lps     

System Call Overhead[linux-2.5.69]             	  421795.9 lps
System Call Overhead[linux-2.5.68]                416758.1 lps     
========================================================================
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
--
					kernel-2.5.69
------------------------------------------------------------------------
--
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux sowmya 2.5.69 #2 SMP Mon May 5 10:06:02 IST 2003 i686
i686 i386 GNU/Linux Start Benchmark Run: Mon May  5 12:04:35 IST 2003 1
interactive users. 12:04pm  up  1:34,  1 user,  load average: 0.00,
0.04, 0.37
lrwxrwxrwx    1 root     root            4 Mar 27 17:20 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2             12436772   1820896   9984120  16% /home

Dhrystone 2 using register variables    1822400.3lps (10.0
secs,10samples)
Double-Precision Whetstone              482.1 MWIPS  (10.0
secs,10samples)
System Call Overhead                    421795.9 lps (10.0
secs,10samples)
Pipe Throughput                         311523.8 lps (10.0
secs,10samples)
Pipe-based Context Switching            133572.2 lps (10.0
secs,10samples)
Process Creation                        5989.3 lps   (30.0 secs,3
samples)
Execl Throughput                        1327.0 lps   (29.7 secs,3
samples)
File Read 1024 bufsize 2000 maxblocks   229846.0 KBps(30.0 secs,3
samples)
File Write 1024 bufsize 2000 maxblocks  120133.0 KBps(30.0 secs,3
samples)
File Copy 1024 bufsize 2000 maxblocks   79059.0 KBps (30.0 secs,3
samples)
File Read 256 bufsize 500 maxblocks     99512.0 KBps (30.0 secs,3
samples)
File Write 256 bufsize 500 maxblocks    82861.0 KBps (30.0 sec, 3
samples)
File Copy 256 bufsize 500 maxblocks     44914.0 KBps (30.0 secs,3
samples)
File Read 4096 bufsize 8000 maxblocks   335423.0KBps (30.0 secs,3
samples)
File Write 4096 bufsize 8000 maxblocks  137689.0KBps (30.0 secs,3
samples)
File Copy 4096 bufsize 8000 maxblocks   97152.0 KBps (30.0 secs,3
samples)
Shell Scripts (1 concurrent)            871.9   lpm  (60.0 secs,3
samples)
Shell Scripts (8 concurrent)            115.0   lpm  (60.0 secs,3
samples)
Shell Scripts (16 concurrent)           58.0    lpm  (60.0 secs,3
samples)
Arithmetic Test (type = short)          217625.5 lps (10.0 secs,3
samples)
Arithmetic Test (type = int)            224363.1 lps (10.0 secs,3
samples)
Arithmetic Test (type = long)           224286.2 lps (10.0 secs,3
samples)
Arithmetic Test (type = float)          227645.2 lps (10.0 secs,3
samples)
Arithmetic Test (type = double)         227580.8 lps (10.0 secs,3
samples)
Arithoh                                 3989564.8 lps(10.0 secs,3
samples)
C Compiler Throughput                   372.3 lpm    (60.0 secs,3
samples)
Dc: sqrt(2) to 99 decimal places        43457.2 lpm  (30.0 secs,3
samples)
Recursion Test--Tower of Hanoi          32002.0 lps  (20.0 secs,3
samples)


                     INDEX VALUES            
TEST                                        BASELINE   RESULT    INDEX

Dhrystone 2 using register variables        116700.0  1822400.3   156.2
Double-Precision Whetstone                  55.0      482.1       87.7
Execl Throughput                            43.0      1327.0      308.6
File Copy 1024 bufsize 2000 maxblocks       3960.0    79059.0     199.6
File Copy 256 bufsize 500 maxblocks         1655.0    44914.0     271.4
File Copy 4096 bufsize 8000 maxblocks       5800.0    97152.0     167.5
Pipe Throughput                             12440.0   311523.8    250.4
Process Creation                            126.0     5989.3      475.3
Shell Scripts (8 concurrent)                6.0       115.0       191.7
System Call Overhead                        15000.0   421795.9    281.2
 
=========
     FINAL SCORE                                                  218.3
------------------------------------------------------------------------
--
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies


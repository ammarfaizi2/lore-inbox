Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261358AbTCTKGd>; Thu, 20 Mar 2003 05:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261359AbTCTKGd>; Thu, 20 Mar 2003 05:06:33 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:21470 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261358AbTCTKGb>; Thu, 20 Mar 2003 05:06:31 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.65
Date: Thu, 20 Mar 2003 15:40:58 +0530
Message-ID: <01d501c2eec9$009b4c50$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 20 Mar 2003 10:10:58.0232 (UTC) FILETIME=[00660B80:01C2EEC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no much difference when compared with the result of
kernel-2.5.64.

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
					kernel-2.5.65
------------------------------------------------------------------------
--
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux sowmya 2.5.65 #7 SMP Tue Mar 18 13:45:54 IST 2003 i686
i686 i386 GNU/Linux
Start Benchmark Run: Tue Mar 18 16:32:09 IST 2003
1 interactive users.
4:32pm  up  2:39,  1 user,  load average: 0.00, 0.00, 0.00
lrwxrwxrwx    1 root     root            4 Feb  4 15:21 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda3              9835584   3129792   6206172  34% /home


Dhrystone 2 using register variables    1822419.0 lps(10.2
secs,10samples)
Double-Precision Whetstone              482.9 MWIPS  (10.0
secs,10samples)
System Call Overhead                    389520.0 lps (10.2
secs,10samples)
Pipe Throughput                         320557.6 lps (10.2
secs,10samples)
Pipe-based Context Switching            134889.2 lps (10.2
secs,10samples)
Process Creation                        6071.0   lps (45.0 secs,
3samples)
Execl Throughput                        1219.9   lps (29.6 secs,
3samples)
File Read 1024 bufsize 2000 maxblocks   232030.0 KBps(30.0 secs,
3samples)
File Write 1024 bufsize 2000 maxblocks  143377.0 KBps(30.0 secs,
3samples)
File Copy 1024 bufsize 2000 maxblocks   79669.0  KBps(30.0 secs,
3samples)
File Read 256 bufsize 500 maxblocks     101353.0 KBps(30.0 secs,
3samples)
File Write 256 bufsize 500 maxblocks    78678.0  KBps(30.0 secs,
3samples)
File Copy 256 bufsize 500 maxblocks     39212.0  KBps(30.0 secs,
3samples)
File Read 4096 bufsize 8000 maxblocks   341380.0 KBps(30.0 secs,
3samples)
File Write 4096 bufsize 8000 maxblocks  176033.0 KBps(30.0 secs,
3samples)
File Copy 4096 bufsize 8000 maxblocks   104849.0 KBps(30.0 secs,
3samples)
Shell Scripts (1 concurrent)            837.1    lpm (67.0 secs,
3samples)
Shell Scripts (8 concurrent)            111.0    lpm (62.2 secs,
3samples)
Shell Scripts (16 concurrent)           55.0     lpm (62.2 secs,
3samples)
Arithmetic Test (type = short)          217553.9 lps (10.2 secs,
3samples)
Arithmetic Test (type = int)            224250.7 lps (10.2 secs,
3samples)
Arithmetic Test (type = long)           224284.7 lps (10.2 secs,
3samples)
Arithmetic Test (type = float)          227467.4 lps (10.2 secs,
3samples)
Arithmetic Test (type = double)         227517.0 lps (10.2 secs,
3samples)
Arithoh                                 3990577.6 lps(10.2 secs,
3samples)
C Compiler Throughput                   364.1    lpm (63.7 secs,
3samples)
Dc: sqrt(2) to 99 decimal places        40652.9  lpm (46.0 secs,
3samples)
Recursion Test--Tower of Hanoi          32019.1  lps (29.6 secs,
3samples)

                     INDEX VALUES            
TEST                                      BASELINE     RESULT     INDEX

Dhrystone 2 using register variables      116700.0    1822419.0   156.2
Double-Precision Whetstone                55.0        482.9       87.8
Execl Throughput                          43.0        1219.9      283.7
File Copy 1024 bufsize 2000 maxblocks     3960.0      79669.0     201.2
File Copy 256 bufsize 500 maxblocks       1655.0      39212.0     236.9
File Copy 4096 bufsize 8000 maxblocks     5800.0      104849.0    180.8
Pipe Throughput                           12440.0     320557.6    257.7
Process Creation                          126.0       6071.0      481.8
Shell Scripts (8 concurrent)              6.0         111.0       185.0
System Call Overhead                      15000.0     389520.0    259.7
 
=========
     FINAL SCORE                                                  213.8
------------------------------------------------------------------------
--
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086


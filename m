Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbSLTDvy>; Thu, 19 Dec 2002 22:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267720AbSLTDvx>; Thu, 19 Dec 2002 22:51:53 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:58796 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267725AbSLTDvu>; Thu, 19 Dec 2002 22:51:50 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.52mm2 patch
Date: Fri, 20 Dec 2002 09:29:39 +0530
Organization: Wipro Technologies
Message-ID: <000801c2a7dc$38433ed0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
x-mimeole: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 20 Dec 2002 03:59:40.0725 (UTC) FILETIME=[38CABE50:01C2A7DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the unixbench result for kernel 2.5.52mm2 patch. Kernel
2.5.52mm2 patch when compared with kernel 2.5.52 showed drop in
performance in following tests:- 
========================================================================
====
                                          2.5.52-mm2     2.5.52
------------------------------------------------------------------------
---
File Copy 1024 bufsize 2000 maxblocks     66127.0       70152.0 
File Copy 256 bufsize 500 maxblocks       31927.0       35585.0
File Copy 4096 bufsize 8000 maxblocks     88357.0       89815.0 
========================================================================
===



------------------------------------------------------------------------
--
                            kernel 2.5.52-mm2
------------------------------------------------------------------------
---
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.52 #6 Thu Dec 19 11:35:51 IST 2002 i686
unknown Start Benchmark Run: Thu Dec 19 13:35:02 IST 2002 1 interactive
users. 1:35pm  up 4 min,  1 user,  load average: 0.03, 0.05, 0.01
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   3954172   3888200  51% /data

Dhrystone 2 using register variables    1804898.5lps (10.0 secs, 10
samples)
Double-Precision Whetstone              476.9 MWIPS  (10.0 secs, 10
samples)
System Call Overhead                    453721.4lps  (10.0 secs, 10
samples)
Pipe Throughput                         452309.6lps  (10.0 secs, 10
samples)
Pipe-based Context Switching            229778.5lps  (10.0 secs, 10
samples)
Process Creation                        4720.9lps    (30.0 secs,  3
samples)
Execl Throughput                        945.1 lps    (29.7 secs,  3
samples)
File Read 1024 bufsize 2000 maxblocks   244961.0KBps (30.0 secs,  3
samples)
File Write 1024 bufsize 2000 maxblocks  93000.0KBps  (30.0 secs,  3
samples)
File Copy 1024 bufsize 2000 maxblocks   66127.0KBps  (30.0 secs,  3
samples)
File Read 256 bufsize 500 maxblocks     114669.0KBps (30.0 secs,  3
samples)
File Write 256 bufsize 500 maxblocks    48744.0 KBps (30.0 secs,  3
samples)
File Copy 256 bufsize 500 maxblocks     31927.0 KBps (30.0 secs,  3
samples)
File Read 4096 bufsize 8000 maxblocks   337641.0KBps (30.0 secs,  3
samples)
File Write 4096 bufsize 8000 maxblocks  124089.0KBps (30.0 secs,  3
samples)
File Copy 4096 bufsize 8000 maxblocks   88357.0 KBps (30.0 secs,  3
samples)
Shell Scripts (1 concurrent)            864.1 lpm    (60.0 secs,  3
samples)
Shell Scripts (8 concurrent)            113.0 lpm    (60.0 secs,  3
samples)
Shell Scripts (16 concurrent)           57.0  lpm    (60.0 secs,  3
samples)
Arithmetic Test (type = short)          208121.1 lps (10.0 secs,  3
samples)
Arithmetic Test (type = int)            224953.0 lps (10.0 secs,  3
samples)
Arithmetic Test (type = long)           225021.0 lps (10.0 secs,  3
samples)
Arithmetic Test (type = float)          227323.4 lps (10.0 secs,  3
samples)
Arithmetic Test (type = double)         227399.2 lps (10.0 secs,  3
samples)
Arithoh                                 3997533.9lps (10.0 secs,  3
samples)
C Compiler Throughput                   409.0 lpm    (60.0 secs,  3
samples)
Dc: sqrt(2) to 99 decimal places        33603.1 lpm  (30.0 secs,  3
samples)
Recursion Test--Tower of Hanoi          28887.4 lps  (20.0 secs,  3
samples)


                     INDEX VALUES            
TEST                                      BASELINE     RESULT    INDEX

Dhrystone 2 using register variables      116700.0  1804898.5    154.7
Double-Precision Whetstone                55.0      476.9        86.7
Execl Throughput                          43.0      945.1        219.8
File Copy 1024 bufsize 2000 maxblocks     3960.0    66127.0      167.0
File Copy 256 bufsize 500 maxblocks       1655.0    31927.0      192.9
File Copy 4096 bufsize 8000 maxblocks     5800.0    88357.0      152.3
Pipe Throughput                           12440.0   452309.6     363.6
Process Creation                          126.0     4720.9       374.7
Shell Scripts (8 concurrent)              6.0       113.0        188.3
System Call Overhead                      15000.0   453721.4     302.5
 
=========
     FINAL SCORE                                                 201.8
------------------------------------------------------------------------
---
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086
sowmya.adiga@wipro.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbTAWGtv>; Thu, 23 Jan 2003 01:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTAWGtu>; Thu, 23 Jan 2003 01:49:50 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:23005 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S263544AbTAWGts>; Thu, 23 Jan 2003 01:49:48 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]Bonnie++ result for 2.4.19 and 2.5.59
Date: Thu, 23 Jan 2003 12:28:40 +0530
Message-ID: <004201c2c2ac$dc72f500$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 23 Jan 2003 06:58:40.0844 (UTC) FILETIME=[DC7258C0:01C2C2AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Here are the result of bonnie++ benchmark, a filesystem
benchmark
for kernel 2.4.19 and 2.5.59

Regards
Sowmya adiga
WIPRO TECHNOLOGIES
BANGALORE,INDIA

------------------------------------------------------------------------
----
2.4.19
========
Using uid:0, gid:0.
Writing with putc()...done
Writing intelligently...done
Rewriting...done
Reading with getc()...done
Reading intelligently...done
start 'em...done...done...done...
Create files in sequential order...done.
Stat files in sequential order...done.
Delete files in sequential order...done.
Create files in random order...done.
Stat files in random order...done.
Delete files in random order...done.
Version  1.03       ------Sequential Output------ --Sequential Input-
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
/sec %CP
access1        256M 10564  96 18951  24  6687   7 10030  88 15949   6
153.8   0
                    ------Sequential Create------ --------Random
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read---
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
/sec %CP
                 16   489  99 +++++ +++ +++++ +++   509  98 +++++ +++
1695  97
access1,256M,10564,96,18951,24,6687,7,10030,88,15949,6,153.8,0,16,489,99
,+++++,+++,+++++,+++,509,98,+++++,+++,1695,97
========================================================================
====

2.5.59
======
Using uid:0, gid:0.
Writing with putc()...done
Writing intelligently...done
Rewriting...done
Reading with getc()...done
Reading intelligently...done
start 'em...done...done...done...
Create files in sequential order...done.
Stat files in sequential order...done.
Delete files in sequential order...done.
Create files in random order...done.
Stat files in random order...done.
Delete files in random order...done.
Version  1.03       ------Sequential Output------ --Sequential Input-
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
/sec %CP
access1        256M 10739  97 18386  25  6526   7 10736  94 16701   6
74.2   0
                    ------Sequential Create------ --------Random
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read---
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
/sec %CP
                 16   499  99 +++++ +++ 19938  99   489  99 +++++ +++
1672  96
access1,256M,10739,97,18386,25,6526,7,10736,94,16701,6,74.2,0,16,499,99,
+++++,+++,19938,99,489,99,+++++,+++,1672,96
------------------------------------------------------------------------
----
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
----


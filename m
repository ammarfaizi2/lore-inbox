Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261278AbSJUIdN>; Mon, 21 Oct 2002 04:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261282AbSJUIdN>; Mon, 21 Oct 2002 04:33:13 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:11964 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261278AbSJUIdL>; Mon, 21 Oct 2002 04:33:11 -0400
Message-ID: <013901c278dd$43db3460$7609720a@M3104487>
Reply-To: "Siva Koti Reddy" <siva.kotireddy@wipro.com>
From: "Siva Koti Reddy" <siva.kotireddy@wipro.com>
To: "lkml" <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Cc: "Linux Coe" <lin_coe@wipro.com>
References: <3DB3B858.C7CD5DA1@digeo.com>
Subject: bonnie++ benchmark results for 2.4.19 and 2.5.43 kernels.
Date: Mon, 21 Oct 2002 14:08:43 +0530
Organization: wipro
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-a5be3852-ec5d-4b8a-90c2-c11d25d32d94"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-OriginalArrivalTime: 21 Oct 2002 08:39:03.0286 (UTC) FILETIME=[4F459160:01C278DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-a5be3852-ec5d-4b8a-90c2-c11d25d32d94
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Kernel 2.5.43
==============
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
Version 1.02c       ------Sequential Output------ --Sequential
Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per
Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec
%CP
siva           128M  5267  96  7851  13  4311   8  5004  94 10199  12  44.4
1
                    ------Sequential Create------ --------Random
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delet
e--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec
%CP
                 16   304  98 18869  98 12866  99   308  98 18951  98  1100
99
siva,128M,5267,96,7851,13,4311,8,5004,94,10199,12,44.4,1,16,304,98,18869,98,
12866,99,308,98,18951,98,1100,99




Kernel 2.4.19
==============
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
Version 1.02c       ------Sequential Output------ --Sequential
Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per
Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec
%CP
siva           128M  4565  79  9733   8  3709   5  3653  68  9391   6 102.1
1
                    ------Sequential Create------ --------Random
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delet
e--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec
%CP
                 16   280  83 +++++ +++ +++++ +++   281  83 +++++ +++  1047
83
siva,128M,4565,79,9733,8,3709,5,3653,68,9391,6,102.1,1,16,280,83,+++++,+++,+
++++,+++,281,83,+++++,+++,1047,83



Details of Test Machine
========================
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 400.921
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 mmx fxsr
bogomips	: 790.52




Rgds
Siva



------=_NextPartTM-000-a5be3852-ec5d-4b8a-90c2-c11d25d32d94
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-a5be3852-ec5d-4b8a-90c2-c11d25d32d94--

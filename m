Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSGNIVI>; Sun, 14 Jul 2002 04:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSGNIVH>; Sun, 14 Jul 2002 04:21:07 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:59386 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S315631AbSGNIVG>; Sun, 14 Jul 2002 04:21:06 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: Pentium IV cache line size
Date: Sun, 14 Jul 2002 13:57:26 +0530
Message-ID: <009c01c22b10$4934e6b0$290806c0@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-c71e103b-8966-4e29-a28e-8fde7e41d7ff"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-c71e103b-8966-4e29-a28e-8fde7e41d7ff
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello, All,

Dave Jones sent out a patch about Pentium IV cacheline sizes,
please refer to

http://marc.theaimsgroup.com/?l=linux-kernel&m=100297450316163&w=2

to which Manfred Spraul responded

http://marc.theaimsgroup.com/?l=linux-kernel&m=100299763026680&w=2

I think the patch is correct and should be applied.

>From Pentium IV, System Programming Guide, Section 9.1, Page 9-2,
Table 9-1. Order # 245472


L1 Data Cache - Pentium 4 and Intel Xeon processors: 8 KBytes, 4-way set
associative, 64-byte
cache line size.


L2 Unified Cache - Pentium 4 and Intel Xeon processors: 256 KBytes 8-way
set associative,
sectored, 64-byte cache line size.

The point is that according to the specs both L1 and L2 cacheline sizes
are 64-byte.

Comments,
Balbir


------=_NextPartTM-000-c71e103b-8966-4e29-a28e-8fde7e41d7ff
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************

Information contained in this E-MAIL being proprietary to Wipro Limited is 
'privileged' and 'confidential' and intended for use only by the individual
 or entity to which it is addressed. You are notified that any use, copying 
or dissemination of the information contained in the E-MAIL in any manner 
whatsoever is strictly prohibited.

***************************************************************************

------=_NextPartTM-000-c71e103b-8966-4e29-a28e-8fde7e41d7ff--

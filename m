Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTLTNdl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 08:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTLTNdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 08:33:41 -0500
Received: from bay8-dav10.bay8.hotmail.com ([64.4.26.114]:15365 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264259AbTLTNdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 08:33:38 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-ide@vger.kernel.org>
Subject: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Sat, 20 Dec 2003 14:33:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcPG/d9QdhBJd4RvS3eRe2JJn7SPLw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY8-DAV10i4H845RNA00008ade@hotmail.com>
X-OriginalArrivalTime: 20 Dec 2003 13:33:37.0965 (UTC) FILETIME=[DFC34DD0:01C3C6FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some major problem getting my FastTrak TX2000 card working with the
Linux 2.4.23 kernel using Debian 3.0 r2.
 
Everything seems to work just fne with the precompiled kernel shipped with
Debian (2.4.18-bf2.4) but when I try to use the newer kernel the boot
process halts and give me a kernel panic:
 
Kernel panic: VFS: Unable to mount root fs on 72:01.
 
I'm using the native ATARAID driver built in (not as a module).
 
I have sucessfully used the RAID card with two Maxtor drives for almost a
year (even with the 2.4.23 kernel). But I reinstalled the system yesterday
with brand new disks.
 
I think I have tried almost every way possible getting the board up, but no
luck! Have I missed something here?
 
I hope that someone can help me with this issue. Thanks in advance!
 
fstab:
/dev/ataraid/d0p1 / ext3 and so on...
/dev/ataraid/d0p2 none swap and so on..
 
lilo:
append="ide2=0xd000,0xb802,12 ide3=0xb400,0xb002,12"00
 
Hardware: 
 
Two WDC800JB-00DUA3 disks connected to a Promise FastTrak TX2000
ASUS P2B motherboard
Intel Pentium II
 
/Nicke
 
 

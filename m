Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314501AbSDXDYP>; Tue, 23 Apr 2002 23:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314498AbSDXDYP>; Tue, 23 Apr 2002 23:24:15 -0400
Received: from saltbush.adelaide.edu.au ([129.127.43.5]:8610 "EHLO
	saltbush.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S314501AbSDXDYO>; Tue, 23 Apr 2002 23:24:14 -0400
From: "Hong-Gunn Chew" <hgchewML@optusnet.com.au>
To: "'Linux kernel mailing list'" <linux-kernel@vger.kernel.org>
Subject: File corruption when running VMware.
Date: Wed, 24 Apr 2002 12:54:07 +0930
Message-ID: <000201c1eb3f$7e0a8450$241d7f81@hgclaptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a repeatable problem when running VMware workstation 3.00 and
3.01.  The cause is still unknown, and could be VMware itself, the
hardware or the kernel.

When running VMware, a file read from disk can be corrupted and will
stay corrupted in memory in the disk cache.  It can be reproduced by
checking the md5sum of a large file (>200MB), with different results
each time when VMware is running.
Further tests shows the corruption occurs only at the 3rd byte of a
16-byte block, and only the LSB is affected.
Load on the machine is minimal and VMware is at the BIOS setup screen.

Has anyone encountered this problem before?  I can provide any
additional information that might be useful.

Cheers,
Hong-Gunn

System configuration:
CPU:		P4 2.0A 2.0GHz
RAM:		4x256MB RDRAM PC800
MB:		ASUS P4-TE firmware:1005
		Intel i850
Disk:		IBM Deskstar 120GXP 80GB
Graphics:	ATI 7500 OEM

Distri:	RedHat 7.2
Kernel:	2.4.18
X:		Xfree 4.2
glibc:	2.2.4-19.3


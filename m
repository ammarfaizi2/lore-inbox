Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVHIXbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVHIXbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 19:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVHIXbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 19:31:41 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:62408 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750814AbVHIXbk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 19:31:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qNJA8kwahsJ50Q979RutKFa3YEK2v22K47vD69UqfgynwTEucDc6MnAFCyiNQwAWuf8Ct9G31WS5Qus8oVxR/eBv4VO6qhIFdAoDkznReHXxJ2UNgr2QiWQrGjzAoiASl4/01B2b02w/IIQlfcF2ET2V+Xtwn/tpmTA0jUEvtVs=
Message-ID: <7f45d939050809163136a234a@mail.gmail.com>
Date: Tue, 9 Aug 2005 16:31:39 -0700
From: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Trouble shooting a ten minute boot delay (SiI3112)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added a PCI SATA controller to my computer. Immediately after grub
loads the kernel there is a consistent ten minute delay before the
kernel displays its first message. I tested Linux 2.6.8 and 2.6.11
both from Debian, and 2.6.11 from Knoppix, all of which experience the
same delay.

The SATA controller is connected to two 200 GB Seagate SATA
ST3200826AS drives. I managed to install Debian on the system, though
the install was perilous, and once booted the system runs wonderfully!
Any suggestions on how I can trouble shoot the ten minute boot delay?
I don't reboot frequently, but it is irksome.

What's the appropriate mailing list for SATA questions, perhaps
linux-ide or linux-scsi?

Please cc me in your reply. Thanks!
Shaun

$ uname -a
Linux quince 2.6.11-1-k7 #1 Mon Jun 20 21:26:23 MDT 2005 i686 GNU/Linux
# lspci
0000:00:00.0 Host bridge: nVidia Corporation nForce CPU bridge (rev b2)
0000:00:00.1 RAM memory: nVidia Corporation nForce 220/420 Memory
Controller (rev b2)
0000:00:00.2 RAM memory: nVidia Corporation nForce 220/420 Memory
Controller (rev b2)
0000:00:00.3 RAM memory: nVidia Corporation: Unknown device 01aa (rev b2)
0000:00:01.0 ISA bridge: nVidia Corporation nForce ISA Bridge (rev c3)
0000:00:01.1 SMBus: nVidia Corporation nForce PCI System Management (rev c1)
0000:00:02.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3)
0000:00:03.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce Ethernet
Controller(rev c2)
0000:00:05.0 Multimedia audio controller: nVidia Corporation: Unknown
device 01b0 (rev c2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce
Audio (rev c2)
0000:00:08.0 PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge (rev c2)
0000:00:09.0 IDE interface: nVidia Corporation nForce IDE (rev c3)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce AGP to PCI Bridge (rev b2)
0000:01:06.0 Ethernet controller: Accton Technology Corporation
SMC2-1211TX (rev 10)
0000:01:07.0 Multimedia video controller: Internext Compression Inc
iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
0000:01:08.0 Unknown mass storage controller: Silicon Image, Inc.
(formerly CMDTechnology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA
Controller (rev 02)
0000:02:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550
AGP (rev01)

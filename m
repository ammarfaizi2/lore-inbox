Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268974AbTBWUIy>; Sun, 23 Feb 2003 15:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268975AbTBWUIy>; Sun, 23 Feb 2003 15:08:54 -0500
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:57218 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S268974AbTBWUIv>; Sun, 23 Feb 2003 15:08:51 -0500
Date: Sun, 23 Feb 2003 21:19:01 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.62-ac1
Message-ID: <20030223211901.A3928@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_2fHTh5uZTiUOsy"
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=_2fHTh5uZTiUOsy
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Alan Cox wrote:
> Linux 2.5.62-ac1
> 	Merge Linus 2.5.62
> o	UNEXPECTED_IO_APIC can be static		(Pavel Machek)
> o	Update IPMI driver to version 18		(Corey Minyard)
> o	Tons of spelling fixes				(Steven Cole)
snip
> o	SunRPC race fix					(Trond Myklebust)
> o	Refix addr/port naming confusion in IDE iops	(me)
> o	Forward port VIA APIC handling quirks		(me)
Hi Alan,

Should this one fix those problems with IO-APICs seen on most UP Via Boards?
For me it doesn't work. For now I have two options with 2.5:

1. Disbable IO-APICs completely, but then my machine only boots with acpi=off

or

2. Use IO-APICs, to get a bootable kernel with acpi enabled, but then all 
onboard devices won't work (via-rhine...) correctly.

Is there any chance to get acpi working without IO-APICs?

lspci (if it helps) output is attached.

Christian

--=_2fHTh5uZTiUOsy
Content-Type: text/plain
Content-Disposition: attachment; filename="lspci.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:0b.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
00:0e.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
00:0e.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA TNT2/TNT2 Pro] (rev 15)

--=_2fHTh5uZTiUOsy--


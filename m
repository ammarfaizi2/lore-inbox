Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262579AbTC1Ibr>; Fri, 28 Mar 2003 03:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262763AbTC1Ibq>; Fri, 28 Mar 2003 03:31:46 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262579AbTC1Ibn>;
	Fri, 28 Mar 2003 03:31:43 -0500
Date: Fri, 28 Mar 2003 00:41:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: phil@netroedge.com, frodol@dds.nl, mdsxyz123@yahoo.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: i2c-ali15x3 on hp omnibook xe3
Message-ID: <20030327234147.GA130@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Apparently bios failed to initialize ali properly; I tried to force
address manually, but I get:

i2c-ali15x3.o version 2.7.0 (20021208)
ali15x3 smbus 00:06.0: forcing ISA address 0x0200
ali15x3 smbus 00:06.0: force address failed - not supported?
ali15x3 smbus 00:06.0: ALI15X3 not detected, module not inserted.

Any ideas what more to try?

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1647 Northbridge
[MAGiK 1 / MobileMAGiK 1] (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] PCI to AGP Controller
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1
Controller (rev 03)
00:04.0 CardBus bridge: Texas Instruments PCI1420
00:04.1 CardBus bridge: Texas Instruments PCI1420
00:06.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA
Bridge [Aladdin IV]
00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1
(rev 12)
00:08.1 Communication controller: ESS Technology ESS Modem (rev 12)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
00:10.0 Ethernet controller: Accton Technology Corporation EN-1216
Ethernet Adapter (rev 11)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/XP
(rev 63)

[Oops, do we have right PCI device? Should not it be 00:07.0?!]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

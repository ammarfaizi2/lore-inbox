Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289346AbSBNBil>; Wed, 13 Feb 2002 20:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289317AbSBNBi1>; Wed, 13 Feb 2002 20:38:27 -0500
Received: from steam.colabnet.com ([198.165.224.35]:11781 "EHLO
	torsus.hive.colabnet.com") by vger.kernel.org with ESMTP
	id <S289340AbSBNBiC>; Wed, 13 Feb 2002 20:38:02 -0500
Subject: Re: Promise SuperTrak100 Oops/Kernel Panic
From: Rob Lake <rlake@colabnet.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3C6AF523.9070703@colabnet.com>
In-Reply-To: <3C6AF523.9070703@colabnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 13 Feb 2002 22:12:01 -0330
Message-Id: <1013650921.2150.5.camel@sphere878.hive.colabnet.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was suggested to try RedHat 2.4.9 trees or 2.4.18-rc1. Both attempts
leave the i2o_block module initializing (no oops/panic, just boredom).

2.4.18-rc1 says this in /var/log/messages:
Feb 13 21:52:08 sphere878 kernel: Linux I2O PCI support (c) 1999 Red Hat
Software.
Feb 13 21:52:08 sphere878 kernel: I2O Core - (C) Copyright 1999 Red Hat
Software
Feb 13 21:52:08 sphere878 kernel: i2o: Checking for PCI I2O
controllers...
Feb 13 21:52:08 sphere878 kernel: PCI: Found IRQ 10 for device 00:0b.1
Feb 13 21:52:08 sphere878 kernel: i2o: I2O controller on bus 0 at 89.
Feb 13 21:52:08 sphere878 kernel: i2o: PCI I2O controller at 0xE9800000
size=4194304
Feb 13 21:52:08 sphere878 kernel: I2O: Promise workarounds activated.
Feb 13 21:52:08 sphere878 kernel: i2o/iop0: Installed at IRQ10
Feb 13 21:52:08 sphere878 kernel: i2o: 1 I2O controller found and
installed.
Feb 13 21:52:08 sphere878 kernel: I2O: Event thread created as pid 1496
Feb 13 21:52:08 sphere878 kernel: Activating I2O controllers...
Feb 13 21:52:08 sphere878 kernel: This may take a few minutes if there
are many devices
Feb 13 21:52:10 sphere878 kernel: i2o/iop0: Reset rejected, trying to
clear
Feb 13 21:52:15 sphere878 kernel: i2o/iop0: LCT has 4 entries.
Feb 13 21:52:15 sphere878 kernel: I2O Block Storage OSM v0.9
Feb 13 21:52:15 sphere878 kernel:    (c) Copyright 1999-2001 Red Hat
Software.
Feb 13 21:52:15 sphere878 kernel: i2o_block: registered device at major
80
Feb 13 21:52:15 sphere878 kernel: i2o_block: Checking for Boot device...
Feb 13 21:52:15 sphere878 kernel: i2o_block: Checking for I2O Block
devices...
Feb 13 21:52:15 sphere878 kernel: i2ob: Installing tid 14 device at unit
0
Feb 13 21:52:15 sphere878 kernel: i2o/hda: Max segments 8, queue depth
4, byte limit 6144.
Feb 13 21:52:15 sphere878 kernel: i2o/hda: Disk Storage: 305274MB, 512
byte sectors.
Feb 13 21:52:15 sphere878 kernel: i2o/hda: Maximum sectors/read set to
32.
Feb 13 21:52:17 sphere878 kernel:  i2o/hda:r 3
Feb 13 21:52:17 sphere878 kernel: I2O: Spurious reply to handler 3
Feb 13 21:52:17 sphere878 last message repeated 454 times

Would a corrupt partition table do this to me?  Because it is corrupt. 
I'm trying this to fdisk it.

Thanks again, I appreciate any insight,
Rob




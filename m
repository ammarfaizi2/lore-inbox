Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbUJZUyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUJZUyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUJZUvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:51:45 -0400
Received: from mail.linicks.net ([217.204.244.146]:1028 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261456AbUJZUvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:51:00 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: IDE warning: "Wait for ready failed before probe!"
Date: Tue, 26 Oct 2004 21:50:55 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410262150.55832.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A couple of mails with Bartlomiej assured me that it isn't required on 
> modern(ish) machines that have PCI (in theory), so do not need that option.

> That will stop the probe, and the post from Alan re the Redhat thread
> suggests it is a debug warning anyway that maybe was never 
> removed.

*Reboot*

Also I forgot, Bartlomiej said machine would reboot faster.  *Wow* does it 
ever \o/

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x6000-0x6007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x6008-0x600f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: QUANTUM FIREBALL CR8.4A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 16514064 sectors (8455 MB) w/418KiB Cache, CHS=16383/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20

No probes on wonky legacy stuff, all works :) :).

I really think the kconfig help on the CONFIG_IDE_GENERIC needs updating 
instead of the 'if unsure say Y'.  I would submit a patch, but I don't really 
know what the hell I am talking about on this subject.

Thanks Bartlomiej :)

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

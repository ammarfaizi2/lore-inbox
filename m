Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270648AbTG3Wpd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272224AbTG3Wpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:45:33 -0400
Received: from smtp.terra.es ([213.4.129.129]:37754 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id S270648AbTG3Wpc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:45:32 -0400
Date: Thu, 31 Jul 2003 00:43:34 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: pavel@ucw.cz, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Warn about taskfile?
Message-Id: <20030731004334.2dd67bb1.diegocg@teleline.es>
In-Reply-To: <Pine.SOL.4.30.0307302336410.1566-100000@mion.elka.pw.edu.pl>
References: <20030730205935.GA238@elf.ucw.cz>
	<Pine.SOL.4.30.0307302336410.1566-100000@mion.elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 30 Jul 2003 23:45:01 +0200 (MET DST) Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> escribió:

> Did corruption go away after disabling taskfile?
> Taskfile was by default on for 2.5.72 and 2.5.73 and Andi's unexplained
> x86-64 + AMD8111 corruption was the only one reported to me / on lkml.
> 
> dmesg and hdparm /dev/scratchdisk for a start, please.

I must say it works without problems here.


Diego Calleja


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y060L0, ATA DISK drive
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive
hdd: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=119150/16/63, UDMA(100)
 hda: hda1 < hda5 hda6 hda7 > hda2 hda3

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbTAOTFt>; Wed, 15 Jan 2003 14:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbTAOTFt>; Wed, 15 Jan 2003 14:05:49 -0500
Received: from BSN-77-247-10.dsl.siol.net ([193.77.247.10]:2432 "EHLO
	klada.dyndns.org") by vger.kernel.org with ESMTP id <S266962AbTAOTFs>;
	Wed, 15 Jan 2003 14:05:48 -0500
Subject: How to fix: PCI: No IRQ known for interrupt pin A of device 00:11.1.
From: Simon Posnjak <simon@activetools.si>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Jan 2003 20:14:42 +0100
Message-Id: <1042658082.1406.8.camel@klada.dyndns.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At boot up I get:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD800JB-00CRA1, ATA DISK drive

I would like to fix the: PCI: No IRQ known for interrupt pin A of device
00:11.1. message. because I think that this is the route of all my
problems(disk not working at full speed, audio flickering,...).

I use RedHat's 2.4.18-19.8.0 kernel (This message is all so in
2.4.21pre3-ac4) on Kudzo 7x mboard with VIA KT400(vt8235).

Can some body pleas tell me what exactly is the problem and what should
I do to fix it.

	Regards Simon



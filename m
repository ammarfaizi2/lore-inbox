Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136137AbRD0Rhl>; Fri, 27 Apr 2001 13:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136138AbRD0Rhc>; Fri, 27 Apr 2001 13:37:32 -0400
Received: from [216.18.81.107] ([216.18.81.107]:6148 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S136137AbRD0RhX>; Fri, 27 Apr 2001 13:37:23 -0400
Date: Fri, 27 Apr 2001 13:37:28 -0400
From: William Park <parkw@better.net>
To: linux-kernel@vger.kernel.org
Subject: ide.2.2.19.04092001.patch + VIA82CXXX (Abit VP6)
Message-ID: <20010427133728.A280@better.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Abit VP6 (VIA 82c694x, 82c686b) running 2.2.19 and
ide.2.2.19.04092001.patch.  When I enable
    VIA82CXXX chipset support (EXPERIMENTAL) -- CONFIG_BLK_DEV_VIA82CXXX 
my machine hangs,
    Uniform Multi-Platform E-IDE driver Revision: 6.30
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    VP_IDE: IDE controller on PCI bus 00 dev 39
    VP_IDE: chipset revision 6
    VP_IDE: not 100% native mode: will probe irqs later
	ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
	ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:pio
    HPT370: IDE controller on PCI bus 00 dev 70
    HPT370: chipset revision 3
    HPT370: not 100% native mode: will probe irqs later
	ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:pio, hdf:pio
	ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:pio, hdh:pio
    hda: ST315320A, ATA DISK drive
    hdc: CD-ROM 24X/AKOx, ATAPI CDROM drive
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    ide1 at 0x170-0x177,0x376 on irq 15		<-- hangs here

Interestingly, I didn't have this problem with ide-2.2.18 patch.

--William Park, Open Geometry Consulting, Mississauga, Ontario, Canada.
  8 CPUs, Linux, python, LaTeX, vim, mutt

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSGUNOK>; Sun, 21 Jul 2002 09:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSGUNOK>; Sun, 21 Jul 2002 09:14:10 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:15490 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S314553AbSGUNOJ>; Sun, 21 Jul 2002 09:14:09 -0400
Date: Sun, 21 Jul 2002 16:16:58 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 buffer layer error at page-writeback.c:420
Message-ID: <20020721131658.GK1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
References: <20020721120837.GJ1548@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020721120837.GJ1548@niksula.cs.hut.fi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 03:08:37PM +0300, you [Ville Herva] wrote:
> I just booted 2.5.26 to textmode, logged in as root and left it there. After
> a while I got this. After that, floppy access etc fails.

Sorry, forgot to mention this is under vmware. It can of course have huge
influence, although 2.4 runs solid under it.

root = hdc = cdrom ext2,
/tmp = ramdisk

ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: Intel Corp. 82371AB PIIX4 IDE, PCI slot 00:07.1
ATA: chipset rev.: 1
ATA: non-legacy mode: IRQ probe delayed
PIIX: Intel Corp. 82371AB PIIX4 IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:DMA, hdd:pio
hda: VMware Virtual IDE Hard Drive, DISK drive
hdb: VMware Virtual IDE CDROM Drive, ATAPI CD/DVD-ROM drive
hdc: VMware Virtual IDE CDROM Drive, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 81648 sectors w/32KiB Cache, CHS=81/16/63, UDMA(33)
 hda: unknown partition table
hdb: ATAPI 1X CD-ROM drive, 32kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdc: ATAPI 1X CD-ROM drive, 32kB Cache, UDMA(33)


-- v --

v@iki.fi

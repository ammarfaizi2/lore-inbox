Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262113AbRETRex>; Sun, 20 May 2001 13:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262114AbRETRen>; Sun, 20 May 2001 13:34:43 -0400
Received: from 204-118-157-8.aculink.net ([204.118.157.8]:3845 "EHLO
	ganymede.aculink.net") by vger.kernel.org with ESMTP
	id <S262113AbRETReg>; Sun, 20 May 2001 13:34:36 -0400
Date: Sun, 20 May 2001 11:38:04 -0600
Message-Id: <200105201738.f4KHc4w21592@cdm01.deedsmiscentral.net>
X-no-archive: yes
From: SoloCDM <deedsmis@aculink.net>
Subject: Lost Interrupt
Reply-To: <deedsmis@aculink.net>, <linux-kernel@vger.kernel.org>
To: Linux-Kernel (Majordomo) <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The present system has operated without any changes to the hardware
with Win9.x, RH5.2, and LM7.0.  This problem only started when I
upgraded to LM8.0 and still no hardware changes have been made.

I use the 420Mb drive as a swap disk, connected along with the
CD-ROM to the secondary port.  I can't bring myself to throw the
420Mb drive out.

The following errors occur during boot-up:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0x6000-0x6007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x6008-0x600f, BIOS settings: hdc:pio, hdd:pio
ide6: Creative SB32 PnP IDE interface
hdb: WDC AC33100H, ATA DISK drive
hdc: Conner Peripherals 420MB - CFS420A, ATA DISK drive
hdc: IRQ probe failed (0xfffffff8)
hdd: CD-ROM 32X/AKU, ATAPI CD/DVD-ROM drive
hdd: IRQ probe failed (0xfffffff8)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16408224 sectors (8401 MB) w/256KiB Cache, CHS=1021/255/63,
UDMA(33)
hdb: 6185088 sectors (3167 MB) w/128KiB Cache, CHS=767/128/63, DMA
hdc: 832608 sectors (426 MB) w/64KiB Cache, CHS=826/16/63, DMA
hdd: lost interrupt
hdd: lost interrupt
hdd: lost interrupt
hdd: lost interrupt
hdd: lost interrupt
hdd: ATAPI 32X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
hda: hda1 hda2 < hda5 hda6 hda7 >
hdb: hdb1 hdb2
hdc:hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x50 { DriveReady SeekComplete }
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x50 { DriveReady SeekComplete }
hdc: lost interrupt
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x50 { DriveReady SeekComplete }
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x50 { DriveReady SeekComplete }
hdc: DMA disabled
hdd: DMA disabled
ide1: reset: success
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hdc1 hdc2 <hdc: lost interrupt
hdc: lost interrupt
hdc5 >
hdc: lost interrupt
hdc: lost interrupt

Why does this happen and how can it be resolved?

Note: When you reply to this message, please include the mailing
      list/newsgroup address and my email address in To:.

*********************************************************************
Signed,
SoloCDM

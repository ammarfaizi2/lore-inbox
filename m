Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262114AbSJKIlS>; Fri, 11 Oct 2002 04:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262151AbSJKIlS>; Fri, 11 Oct 2002 04:41:18 -0400
Received: from gzp11.gzp.hu ([212.40.96.53]:12562 "EHLO gzp11.gzp.hu")
	by vger.kernel.org with ESMTP id <S262114AbSJKIlS>;
	Fri, 11 Oct 2002 04:41:18 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: IDE PDC20268 in Linux 2.4.20-pre10
References: <Pine.LNX.4.44L.0210081626550.15300-100000@freak.distro.conectiva>
Organization: Who, me?
User-Agent: tin/1.5.15-20021008 ("Soil") (UNIX) (Linux/2.4.20-pre10 (i686))
Message-ID: <4cc4.3da69003.2d455@gzp1.gzp.hu>
Date: Fri, 11 Oct 2002 08:46:59 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti <marcelo@conectiva.com.br>:

| Here goes pre10.

When will the PDC20268 driver go with UDMA 100 in your tree?
Before or after 2.4.20?

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller on PCI bus 00 dev f9
ICH2: chipset revision 2
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:pio
PDC20268: IDE controller on PCI bus 02 dev 68
PCI: Found IRQ 9 for device 02:0d.0
PCI: Sharing IRQ 9 with 02:09.0
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode
Secondary MASTER Mode.
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
hda: IC35L060AVVA07-0, ATA DISK drive
hdc: IC35L060AVVA07-0, ATA DISK drive
hde: IC35L060AVVA07-0, ATA DISK drive
hdg: IC35L060AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb800-0xb807,0xb402 on irq 9
ide3 at 0xb000-0xb007,0xa802 on irq 9
blk: queue c034d544, I/O limit 4095Mb (mask 0xffffffff)
hda: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=7476/255/63, UDMA(100)
blk: queue c034d8a8, I/O limit 4095Mb (mask 0xffffffff)
hdc: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(100)
blk: queue c034dc0c, I/O limit 4095Mb (mask 0xffffffff)
hde: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(33)
blk: queue c034df70, I/O limit 4095Mb (mask 0xffffffff)
hdg: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(33)

Weird CHS on hda is due bogus BIOS?


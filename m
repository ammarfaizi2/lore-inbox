Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267825AbTBRM6v>; Tue, 18 Feb 2003 07:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267810AbTBRM5u>; Tue, 18 Feb 2003 07:57:50 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:28050 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S267805AbTBRM5c>;
	Tue, 18 Feb 2003 07:57:32 -0500
Date: Tue, 18 Feb 2003 14:07:48 +0100 (CET)
From: kernel@ddx.a2000.nu
To: linux-kernel@vger.kernel.org
Subject: no promise PDC2070/PDC20267 with 2.5.62 (works ok with 2.4.20)
Message-ID: <Pine.LNX.4.53.0302181334240.5743@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

intel se7500cw2 dual xeon mainbord (with dual 2GHz) with onboard ide and
onboard fasttrak100 (PDC20267) and pci tx4 (PDC2070) (and 3ware
7850/adaptec 2940uw)

kernel 2.5.62 boot dmesg output :

ICH3: IDE controller at PCI slot 00:1f.1
ICH3: chipset revision 2
ICH3: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0x7040-0x7047, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x7048-0x704f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD1800BB-00DAA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD1800BB-00DAA0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20270: IDE controller at PCI slot 03:01.0
PDC20270: chipset revision 2
PDC20270: not 100%% native mode: will probe irqs later
PDC20270: neither IDE port enabled (BIOS)
PDC20270: ROM enabled at 0x000dc000
PDC20270: neither IDE port enabled (BIOS)
PDC20267: IDE controller at PCI slot 05:06.0
PDC20267: chipset revision 2
PDC20267: not 100%% native mode: will probe irqs later
PDC20267: neither IDE port enabled (BIOS)


kernel 2.4.20 boot dmesg output :

ICH3: BIOS setup was incomplete.
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7040-0x7047, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x7048-0x704f, BIOS settings: hdc:pio, hdd:pio
PDC20270: IDE controller on PCI bus 03 dev 08
PDC20270: chipset revision 2
PDC20270: not 100% native mode: will probe irqs later
PDC20270: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide2: BM-DMA at 0x9040-0x9047, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9048-0x904f, BIOS settings: hdg:pio, hdh:pio
PDC20270: IDE controller on PCI bus 03 dev 10
PDC20270: chipset revision 2
PDC20270: not 100% native mode: will probe irqs later
PDC20270: ROM enabled at 0x000dc000
PDC20270: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide4: BM-DMA at 0x90c0-0x90c7, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x90c8-0x90cf, BIOS settings: hdk:pio, hdl:pio
PDC20267: IDE controller on PCI bus 05 dev 30
PCI: Found IRQ 11 for device 05:06.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide6: BM-DMA at 0xb800-0xb807, BIOS settings: hdm:pio, hdn:pio
    ide7: BM-DMA at 0xb808-0xb80f, BIOS settings: hdo:pio, hdp:pio
hda: WDC WD1800BB-00DAA0, ATA DISK drive
hdc: WDC WD1800BB-00DAA0, ATA DISK drive
hde: WDC WD1800BB-00DAA0, ATA DISK drive
hdi: WDC WD1800BB-00DAA0, ATA DISK drive
hdk: WDC WD1800BB-00DAA0, ATA DISK drive
hdm: WDC WD1800BB-00DAA0, ATA DISK drive
hdo: WDC WD1800BB-00DAA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9000-0x9007,0x9012 on irq 10
ide4 at 0x9080-0x9087,0x9092 on irq 10
ide5 at 0x90a0-0x90a7,0x90b2 on irq 10
ide6 at 0xb850-0xb857,0xb846 on irq 11
ide7 at 0xb848-0xb84f,0xb842 on irq 11

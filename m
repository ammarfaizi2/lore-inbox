Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbTKRBmu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 20:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTKRBmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 20:42:50 -0500
Received: from continuum.cm.nu ([216.113.193.225]:19588 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id S261996AbTKRBms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 20:42:48 -0500
Date: Mon, 17 Nov 2003 17:42:47 -0800
To: linux-kernel@vger.kernel.org
Subject: Question regarding IDE errors
Message-ID: <20031118014247.GA11198@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Archive: yes
User-Agent: Mutt/1.5.4i
From: Shane Wegner 
	<shane-keyword-kernel.a35a91-keyword-kernel.a35a91@cm.nu>
X-Delivery-Agent: TMDA/0.88 (Decidedly)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I received the following ide errors in the kernel log and
am hoping someone can advice as to whether this indicates a
hardware problem or a problem with a driver?

hde: dma_intr: status=0x51 { DriveReady SeekComplete Error
}
hde: dma_intr: error=0x40 { UncorrectableError },
LBAsect=155596111, high=9, low=4601167, sector=155596048
end_request: I/O error, dev 21:00 (hde), sector 155596048

I just purchased the hard drive a couple weeks back, a
Maxtor 250gb attached to a Promise pci ide controler.

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
SvrWks CSB5: IDE controller at PCI slot 00:0f.1
SvrWks CSB5: chipset revision 146
SvrWks CSB5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2470-0x2477, BIOS settings: hda:DMA,
hdb:pio
    ide1: BM-DMA at 0x2478-0x247f, BIOS settings: hdc:pio,
hdd:pio
PDC20269: IDE controller at PCI slot 01:09.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x2490-0x2497, BIOS settings: hde:pio,
hdf:pio
    ide3: BM-DMA at 0x2498-0x249f, BIOS settings: hdg:pio,
hdh:pio
hda: HL-DT-ST RW/DVD GCC-4480B, ATAPI CD/DVD-ROM drive
hde: Maxtor 4A250J0, ATA DISK drive
hdf: Maxtor 4A250J0, ATA DISK drive
blk: queue c039b298, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c039b3e0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x24b0-0x24b7,0x24aa on irq 22
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 490234752 sectors (251000 MB) w/2048KiB Cache,
CHS=30515/255/63, UDMA(133)
hdf: attached ide-disk driver.
hdf: host protected area => 1
hdf: 490234752 sectors (251000 MB) w/2048KiB Cache,
CHS=30515/255/63, UDMA(133)

Shane

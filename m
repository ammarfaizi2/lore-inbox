Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbUJWUsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbUJWUsV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUJWUsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:48:04 -0400
Received: from mail-gw1.york.ac.uk ([144.32.128.246]:8320 "EHLO
	mail-gw1.york.ac.uk") by vger.kernel.org with ESMTP id S261294AbUJWUrR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:47:17 -0400
Date: Sat, 23 Oct 2004 20:47:33 +0000
From: Alan Jenkins <aj504@york.ac.uk>
Subject: IDE warning: "Wait for ready failed before probe!"
To: linux-kernel@vger.kernel.org
X-Mailer: Balsa 2.2.5
Message-Id: <1098564453l.9607l.0l@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-York-MailScanner: Found to be clean
X-York-MailScanner-From: aj504@york.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no problems (I hope!), but the warnings I get when linux (2.6.9) 
tries to probe a non existant IDE device (controller/channel (?) not  
hard disk) are slightly over the top..

1. Are these warnings usual for a nonexistant IDE drive?
2. Could they be toned down?

Exclamation marks might be appropriate if after the SIS ide controller  
had been detected one of its channels (ide0/1) could not be probed, but  
unless my hardware is not reacting as expected they are just "noise".

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with  
idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD1200BB-00DWA0, ATA DISK drive
hdb: LITE-ON COMBO SOHC-5232K, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,  
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4



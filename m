Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTLAOUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 09:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTLAOUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 09:20:34 -0500
Received: from main.gmane.org ([80.91.224.249]:57567 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263435AbTLAOUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 09:20:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mikpolniak <mikpolniak@adelphia.net>
Subject: vt8235 ide0: Speed warnings UDMA 3/4/5 is not functional
Date: Mon, 01 Dec 2003 09:12:21 -0500
Message-ID: <pan.2003.12.01.14.12.20.713784@adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a new Shuttle MK40VN motherboard with VIA KM400 and VT8235. I have
tried kernel 2.6.0-test11 and 2.4.23 and only can get UDMA2 working on my
hard drive.

If i try hdparm -X69 -d 1 /dev/hda i get the speed warnings:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 p12 >
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as 
device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Linux video capture interface: v1.00
ide0: Speed warnings UDMA 3/4/5 is not functional.
ide0: Speed warnings UDMA 3/4/5 is not functional.
ide0: Speed warnings UDMA 3/4/5 is not functional.



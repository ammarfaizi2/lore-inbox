Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271513AbTGQRSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271514AbTGQRSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:18:52 -0400
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:57640 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S271513AbTGQRSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:18:50 -0400
Message-ID: <3F16DDF8.1030707@planet.nl>
Date: Thu, 17 Jul 2003 19:33:44 +0200
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030713
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Onstream DI-30 not responding 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I'm trying to use my Onstream DI-30 (IDE) tape device with Kernel 
2.6.0-test1. When trying to access the drive using the old 2.2 kernels 
and 2.4 these commands worked fine

bash-2.05# mt -f /dev/nht0 status
/dev/nht0: No such device
bash-2.05# mt -f /dev/ht0 status
/dev/ht0: No such device
bash-2.05# mt -f /dev/hdd status
/dev/hdd: No such device or address
bash-2.05# mt -f /dev/hdc status
/dev/hdc: No such device or address

While they now are showing ugly errors.

This is a part of the boot log

VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:DMA
hda: WDC WD205BA, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: OnStream DI-30, ATAPI TAPE drive


Thanks in advance for any tips on a solution for this problem.

Stef


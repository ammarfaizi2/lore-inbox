Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbTE2U5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTE2U5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:57:33 -0400
Received: from www.wwns.com ([209.149.59.66]:47573 "EHLO wwns.wwns.com")
	by vger.kernel.org with ESMTP id S262820AbTE2U53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:57:29 -0400
From: "David R. Wilson" <david@wwns.com>
Message-Id: <200305292117.h4TLHMj07604@wwns.wwns.com>
Subject: Re: Asrock K7S8X Motherboard kernel problem
To: linux-kernel@vger.kernel.org
Date: Thu, 29 May 2003 16:17:22 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem with booting disappeared when I changed to NOAPIC in the
.config file.

Thanks for the help fellows!

Dave


Forwarded message:
> 
> Did you get a solution for your Asrock MB problem? 
> If not I have some suggestions. I have another Asrock with an SiS746, 
> and had the same (?) or similar problem. 
> If you haven't tried it, I was successful with setting NOAPIC on the 
> command line. This on stock RedHat 2.4.18 out of RH8. On that one I also 
> had to set PCI=BIOS. 
> With later kernels I compiled, both 2.4 and 2.5, I've generally had to 
> set NOAPIC, but at least on 2.5 don't have to set PCI=BIOS. 
> Hope it helps. 
> wmb
> 
> 
> List:     linux-kernel
> Subject:  Asrock K7S8X Motherboard kernel problem
> From:     "David R. Wilson" <david () wwns ! com>
> Date:     2003-05-23 22:19:31
> [Download message RAW]
> 
> Hello,
> 
> I must be missing something, I have an Asrock K7S8X motherboard.
> According to the manual:
> SIS 746 chipset
> SIS 963L southbridge
> 
> and according to one of the motherboards:
> VIA VT8235 southbridge
> 
> Kernel 2.4.21-rc3
> 
> with the patch from Vojtech Pavlik for the SIS southbridge at:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0305.2/0052.html
> 
> The boot messages mention a missing floppy controller among other 
> problems:
> 
> Uniform Multi-Platform E-IDE driver Revision 7.00beta3-.2.4
> ide: Assuming 33 MHz system bus speed for PIO modes; overide with idebus=xx
> 
> SIS 5513: IDE controller at PCI slot 00:02.5
> SIS 5513: chipset revision 0
> SIS 5513: not 100% native mode: will probe irqs later
> 
> SIS 746 ATA 133 controller
> 	ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA hdb:DMA
> 	ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA hdd:DMA
> 
> hda: WDC WE800BB-00DKA0, ATA DISK drive
> blk: queue c03606a0, I/O limit 4095 Mb (mask 0xFFFFFFFF)
> hdc CW 078D ATAPI CD-R/RW, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7, 0x3f6 on irq 14
> ide1 at 0x170-0x177, 0x376 on irq 15
> hda: attached ide-disk driver.
> hda: lost interrupt
> 


-- 
David R. Wilson  WB4LHO
World Wide Network Services
Nashville, Tennessee USA	Need QSL cards?
david@wwns.com			http://store.wwns.com/lz1jz



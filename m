Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTIUTvJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 15:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbTIUTvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 15:51:08 -0400
Received: from main.gmane.org ([80.91.224.249]:19427 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262547AbTIUTvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 15:51:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Shash Chatterjee <sasvata@badfw.org>
Subject: RH-9 boot hangs from floppy bootdisk
Date: Sun, 21 Sep 2003 14:48:43 -0500
Message-ID: <bkkvb0$so3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just installed RH-9 from ISO images I downloaded yesterday.
This system used to run RH-7.3 until this morning. The RH install CD ran 
and installed just fine, and I created a boot disk on floppy.  I 
installed GRUB on the first partition of my RH drive, but not on the MBR.

I have 2 hard-drives, with Win-XP Pro on the first one (C:, /dev/hda) 
and RH (D:, /dev/hdb) on the second.  I also have a DVD-ROM (E:, 
/dev/hdc) and a CD-RW drive (F: /dev/hdd).

When booting from floppy, it loads the kernel/ramdisk from floppy, then 
recognizes the HW and then hangs with the following message (at the 
bottom).  Hitting any key causes a single "keyboard: unknown keysequence 
0e .." and then I have to hard-reset to recover.

Any help would be most appreciated.  Here's the console output:
.....
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode, will probe irqs later
	ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:dma, hdb:dma
	ide1: BM-DMA at oxf008-0xf00f, BIOS settings: hdc:dma, hdd:dma
HPT370: IDE controller at PCI slot 00:0e.1
HPT370: chipset revision 3
HPT370: not 100% native mode, will probe irqs later
	ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:pio, hdf:pio
	ide3: BM-DMA at oxb408-0xb40f, BIOS settings: hdg:pio, hdh:pio
hda: IC35L080AWA07-0, ATA disk drive
hdb: WDC WD200EB-00BHF0, ATA disk drive
blk: queue c03c9f40, I/O limit 4095Mb (mask 0cffffffff)
blk: queue c03c9084, I/O limit 4095Mb (mask 0cffffffff)
hdc: CREATIVEDVD1240E, ATAPI CD/DVD-ROM drive
hdd: YAMAHA CRW2200E, ATAPI CD/DVD-ROM drive
<hangs right here>

Thanks,
Shash



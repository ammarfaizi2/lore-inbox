Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTHaGFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 02:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTHaGFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 02:05:24 -0400
Received: from mx13.sac.fedex.com ([199.81.197.53]:38669 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S262254AbTHaGFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 02:05:17 -0400
Date: Sun, 31 Aug 2003 12:24:29 +0800 (SGT)
From: Jeff Chua <jeff89@silk.corp.fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] hda:end_request: I/O error, dev 03:00 (hda), sector 0
Message-ID: <Pine.LNX.4.42.0308311221430.17575-100000@silk.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/31/2003
 12:26:00 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/31/2003
 02:05:14 PM,
	Serialize complete at 08/31/2003 02:05:14 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What do I need to get rid of these errors ...

dmesg after boot up ...

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
PCI: Sharing IRQ 11 with 01:00.2
PCI: Sharing IRQ 11 with 01:02.0
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N040ATCS05-0, ATA DISK drive
blk: queue c02a99c0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Partition check:
 hda:end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
 unable to read partition table


Thanks,
Jeff
[ jchua@fedex.com ]



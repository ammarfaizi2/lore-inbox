Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265021AbTFWCOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 22:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbTFWCOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 22:14:38 -0400
Received: from mx11.sac.fedex.com ([199.81.193.118]:56072 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP id S265021AbTFWCOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 22:14:37 -0400
Date: Mon, 23 Jun 2003 10:26:38 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: end_request: I/O error, dev 03:00 (hda), sector 2
Message-ID: <Pine.LNX.4.56.0306231025380.305@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 06/23/2003
 10:28:37 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 06/23/2003
 10:28:40 AM,
	Serialize complete at 06/23/2003 10:28:40 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How can I fix this?

# dmesg
...
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N040ATCS05-0, ATA DISK drive
blk: queue c0291220, I/O limit 4095Mb (mask 0xffffffff)
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


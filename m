Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbTIGT2d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 15:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTIGT2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 15:28:32 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32179 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261375AbTIGT22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 15:28:28 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0test4 bk1 and
Date: Sun, 7 Sep 2003 21:29:18 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200309051559.18910.arekm@pld-linux.org> <20030905085419.6ea00d78.akpm@osdl.org> <200309072111.21900.arekm@pld-linux.org>
In-Reply-To: <200309072111.21900.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309072129.18157.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IDE chipset drivers don't work (safely) as modules.  Just don't do it.

On Sunday 07 of September 2003 21:11, Arkadiusz Miskiewicz wrote:

> - ide thing
> VP_IDE: IDE controller at PCI slot 0000:00:11.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci0000:00:11.1
>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
> ide0: I/O resource 0x3F6-0x3F6 not free.
> hda: ERROR, PORTS ALREADY IN USE
> register_blkdev: cannot get major 3 for ide0
> ide1: I/O resource 0x376-0x376 not free.
> hdc: ERROR, PORTS ALREADY IN USE
> register_blkdev: cannot get major 22 for ide1
> Module via82cxxx cannot be unloaded due to unsafe usage in
> include/linux/module.h:483


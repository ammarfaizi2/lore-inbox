Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTHOKWB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275892AbTHOKWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:22:01 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30472
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261180AbTHOKV7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:21:59 -0400
Date: Fri, 15 Aug 2003 03:09:56 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How do IDE chipset drivers work as modules ?
In-Reply-To: <Pine.WNT.4.56.0308142338470.3912@pervalidus>
Message-ID: <Pine.LNX.4.10.10308150309350.9444-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When you find out lemme know too.

Andre Hedrick
LAD Storage Consulting Group

On Thu, 14 Aug 2003, Frédéric L. W. Meunier wrote:

> With 2.6.0-test3. First time I try this. Does initrd make it
> work ?
> 
> I thought modprobe via82cxxx, but:
> 
> Aug 14 17:00:36 pervalidus kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
> Aug 14 17:00:36 pervalidus kernel: VP_IDE: chipset revision 6
> Aug 14 17:00:36 pervalidus kernel: VP_IDE: not 100%% native mode: will probe irqs later
> Aug 14 17:00:36 pervalidus kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Aug 14 17:00:36 pervalidus kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
> Aug 14 17:00:36 pervalidus kernel:     ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:pio
> Aug 14 17:00:36 pervalidus kernel:     ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:DMA, hdd:DMA
> Aug 14 17:00:36 pervalidus kernel: ide0: I/O resource 0x3F6-0x3F6 not free.
> Aug 14 17:00:36 pervalidus kernel: hda: ERROR, PORTS ALREADY IN USE
> Aug 14 17:00:36 pervalidus kernel: register_blkdev: cannot get major 3 for ide0
> Aug 14 17:00:36 pervalidus kernel: ide1: I/O resource 0x376-0x376 not free.
> Aug 14 17:00:36 pervalidus kernel: hdc: ERROR, PORTS ALREADY IN USE
> Aug 14 17:00:36 pervalidus kernel: hdd: ERROR, PORTS ALREADY IN USE
> Aug 14 17:00:36 pervalidus kernel: register_blkdev: cannot get major 22 for ide 1
> Aug 14 17:00:36 pervalidus kernel: Module via82cxxx cannot be unloaded due to unsafe usage in include/linux/module.h:483
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


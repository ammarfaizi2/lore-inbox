Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTE2QuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTE2QuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:50:20 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:22984 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262382AbTE2QuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:50:19 -0400
Date: Thu, 29 May 2003 19:03:18 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: kwijibo@zianet.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
Message-ID: <20030529170318.GA11364@louise.pinerecords.com>
References: <20030529114001.GD7217@louise.pinerecords.com> <1054216894.20167.76.camel@dhcp22.swansea.linux.org.uk> <3ED63BE7.8080604@zianet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED63BE7.8080604@zianet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [kwijibo@zianet.com]
> 
> SvrWks CSB5: IDE controller at PCI slot 00:0f.1
> SvrWks CSB5: chipset revision 147
> SvrWks CSB5: not 100% native mode: will probe irqs later
> SvrWks CSB5: simplex device: DMA forced
>    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:pio, hdb:pio
> SvrWks CSB5: simplex device: DMA forced
>    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:DMA
> hda: HL-DT-ST CD-ROM GCR-8480B, ATAPI CD/DVD-ROM drive
> hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> hda: set_drive_speed_status: error=0x04

This matches my dmesg line-by-line except for the CDROM model of course. ;)

SvrWks CSB5: IDE controller at PCI slot 00:0f.1
SvrWks CSB5: chipset revision 147
SvrWks CSB5: not 100% native mode: will probe irqs later
SvrWks CSB5: simplex device: DMA forced
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:pio, hdb:pio
SvrWks CSB5: simplex device: DMA forced
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:DMA
hda: LTN486S, ATAPI CD/DVD-ROM drive
hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hda: set_drive_speed_status: error=0x04

> Luckily I don't use IDE drives in this system but it did force me to do
> a network install since the CDROM is now unusable.

We're using IDE drives for backups -- mostly because it's not even
conceivable to get large SCSI disks for a decent price.

-- 
Tomas Szepe <szepe@pinerecords.com>

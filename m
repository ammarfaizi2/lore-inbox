Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbULZTGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbULZTGk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 14:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbULZTGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 14:06:40 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:47644 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261733AbULZTGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 14:06:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=L3p5ze5UGE9ejXSzlgQAvsJrqUHVnSLQzToh1PxEtLE+r+Z87kzorNdFmQcMEsEuTJHGt15BUXogwj2YZ/8O8XGMqLuQZlkn38zWs3KHflnfV/7Uqxn1JjFgjWdyQ/rQ/9P1VCSHp7SHIMsx/a+cAZTZhmiSh5jlObDNyNuRpiA=
Message-ID: <58cb370e04122611062edcb680@mail.gmail.com>
Date: Sun, 26 Dec 2004 20:06:36 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide0=ata66 obsolete, but replaced by what (2.6.10)?
In-Reply-To: <20041226185830.GA20147@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041226185830.GA20147@charite.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 26 Dec 2004 19:58:30 +0100, Ralf Hildebrandt
<Ralf.Hildebrandt@charite.de> wrote:
> Ever since a few kernels ago, my dmesg output says:
> 
> Kernel command line: BOOT_IMAGE=Linux ro root=303 noapic ide0=ata66 video=vesafb:mtrr,ywrap
> ide_setup: ide0=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
> 
> OK, but what is it replaced with?
> Because later on, dmesg also says:
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
> NFORCE3-150: chipset revision 165
> NFORCE3-150: not 100% native mode: will probe irqs later
> NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
> NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
>     ide0: BM-DMA at 0x2080-0x2087, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x2088-0x208f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: ST94019A, ATA DISK drive
> elevator: using anticipatory as default io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: SD-R6252, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 1024KiB
> hda: 78140160 sectors (40007 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
> hda: cache flushes supported
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
> 
> My question is now:
> 
> 1) What replaces the boot option "ide0=ata66"?

Nothing ;-), what do you need it for?

> or
> 2) How do I get the old bus speed back?

What bus speed are you talking about?

"idebus=" is still there but you don't need to use it for nVidia chipsets AFAIK.

Bartlomiej

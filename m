Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267298AbTABVpD>; Thu, 2 Jan 2003 16:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267295AbTABVnu>; Thu, 2 Jan 2003 16:43:50 -0500
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:28676 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S267279AbTABVmr> convert rfc822-to-8bit; Thu, 2 Jan 2003 16:42:47 -0500
Message-Id: <5.1.1.6.2.20030102224901.031010d8@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Thu, 02 Jan 2003 22:51:44 +0100
To: Kari Hameenaho <khaho@koti.soon.fi>, linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: Re: Highpoint HPT370 not working in 2.4.18+ versions
In-Reply-To: <20030102010942.357248fc.khaho@koti.soon.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Solved (1st part). Thanks Kari!

Now i get a Oups just botting (just after detecting all the HDs).

I will take a look with this new problem.

Seeya and thanks again (i was silly with this problem ... really silly).

At 01:09 02/01/2003 +0200, Kari Hameenaho wrote:
>system_lists@nullzone.org wrote:
>
> >* BOOTing using 2.4.20 (or 2.4.21-pre2)
> >--------------------
> >...
> >Linux agpgart interface v0.99 (c) Jeff Hartmann
> >agpgart: Maximum main memory to use for agp memory: 96M
> >agpgart: Detected Via Apollo Pro chipset
> >agpgart: AGP aperture is 64M @ 0xd8000000
> >Highpoint HPT370 Softwareraid driver for linux version ...
> >NET4: Linux TCP/IP 1.0 for NET4.0
> >IP Protocols: ICMP, UDP, TCP
> >...
> >
> >You can notice how the driver for HPT is loaded but nothing is found.
> >OF COURSE hde hdf etc is NOT found .. (at the begining of the boot).
>
>Maybe you have selected only RAID part of HPT370 in your kernel config,
>not the driver part at all.
>
>RAID part in menuconfig (this seems to be on):
><*> Support for IDE Raid controllers (EXPERIMENTAL)
>   ...
>   <*>    Highpoint 370 software RAID (EXPERIMENTAL)
>
>But you also need the driver, as in menuconfig (this seems to be off):
>[*]     HPT366/368/370 chipset support
>
>Maybe the RAID part should not be selectable without the driver,
>but when making own kernels you should know about many options
>anyway.
>
>---
>Kari Hämeenaho
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/





Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293164AbSB1FGf>; Thu, 28 Feb 2002 00:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293169AbSB1FFc>; Thu, 28 Feb 2002 00:05:32 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7434 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293164AbSB1FEy>; Thu, 28 Feb 2002 00:04:54 -0500
Date: Wed, 27 Feb 2002 20:51:44 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Tim Moore <timothymoore@bigfoot.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: disk transfer speed problem
In-Reply-To: <3C7D90BC.394C1E2A@bigfoot.com>
Message-ID: <Pine.LNX.4.10.10202272049180.22351-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is more useful is the cat /proc/ide/ide0/config !!!

>From that I can tell you what is going on completely about the system.

Oh and for those not reading this email, it is a side note on why the ide
proc-pci interface had best be left alone and in tact. 

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


On Wed, 27 Feb 2002, Tim Moore wrote:

> >  #dmesg|grep UDMA
> > hda: 14668290 sectors (7510 MB) w/418KiB Cache, CHS=913/255/63, UDMA(66)
> > (this is the boot disk)
> > 
> > hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63,
> > UDMA(100
> > hdd: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63,
> > UDMA(100)
> 
> Please post dmesg, /proc/pci and chipset info from /proc/ide.  Also,
> what is result from 'hdparm -tT /dev/hda'?
> 
> rgds,
> tim.
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261706AbSJCPaq>; Thu, 3 Oct 2002 11:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbSJCPaq>; Thu, 3 Oct 2002 11:30:46 -0400
Received: from ns.censoft.com ([208.219.23.2]:53223 "EHLO ns.censoft.com")
	by vger.kernel.org with ESMTP id <S261706AbSJCPan>;
	Thu, 3 Oct 2002 11:30:43 -0400
Date: Thu, 3 Oct 2002 09:33:16 -0600
From: Jordan Crouse <jordanc@censoft.com>
To: Dexter Filmore <Dexter.Filmore@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE subsystem issues with 2.4.18/19
Message-Id: <20021003093316.59d65c3b.jordanc@censoft.com>
In-Reply-To: <20021004140144.418a8569.Dexter.Filmore@gmx.de>
References: <20021004140144.418a8569.Dexter.Filmore@gmx.de>
Organization: Century Software
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same problem on the same motherboard with a 
Goldstar LG DVD/CD-RW drive.  The Goldstar FAQ
(http://www.lgeservice.com/faqcdrw-1.html) mentions something about a 
problem with DMA on the VIA motherboard.

So on a whim, I tried a different CD-ROM, and it works perfectly.  Now I am using a ASUS CD-ROM for ripping audio, and my Goldstar for everything else, which seems to be a decent solution. 

So it would appear to be an interaction problem between certain CD drives and the VIA firmware, but I am not sure if a firmware update even exists, and if it does, I don't know if it will help or not (www.via.com.tw seems to be down right now).  I'm actually very happy with my current setup, and so I haven't been motivated to try anything new.

So, draw strength from the fact that you are not alone, but I can't offer you much more help than to tell you to swap out hardware.  Sorry.

Jordan

On Fri, 4 Oct 2002 14:01:44 +0200
Dexter Filmore <Dexter.Filmore@gmx.de> wrote:

> Got a motherboard with VIA VT8233 Southbridge (a MSI K7T266 Pro2), Slackware
> 8.1 with a standard kernel (tried .18 as well as .19) patched with SGI XFS
> support, two atapi drives attached with /dev/hdc is Pioneer115 DVD and
> /dev/hdd is a Traxdata 24x-writer, both running in scsi emulation.
> Got VIA-support compiled in.
> 
> Everythings runs fine: reading DVD, reading CD, writing CD. 
> *Apart from*: CD ripping. When trying to read audio CDs, the system locks up,
> can't reproduce the exact error msgs right now, need a running system atm. If
> you like, I'll post them later on.
> 
> Tried cdparanoia 9.8-III, cdda2wav - nothing works.
> 
> I contacted Vojtech Pavlik, the author of the via82xxx.c code who advised me
> to ask Alan Cox or Andre Hedrick about this, so I thought best write to this
> list.
> Are there any workarounds/patches/voodoo magic for this problem?
> 
> Dex
> 

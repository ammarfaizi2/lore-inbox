Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289142AbSAGIkM>; Mon, 7 Jan 2002 03:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289136AbSAGIjx>; Mon, 7 Jan 2002 03:39:53 -0500
Received: from dns1.rz.fh-heilbronn.de ([141.7.1.18]:32656 "EHLO
	dns1.rz.fh-heilbronn.de") by vger.kernel.org with ESMTP
	id <S289140AbSAGIju>; Mon, 7 Jan 2002 03:39:50 -0500
Date: Mon, 7 Jan 2002 09:39:47 +0100 (CET)
From: Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>
To: Andrew Morton <akpm@zip.com.au>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
In-Reply-To: <3C395A2C.B7A24844@zip.com.au>
Message-ID: <Pine.LNX.4.33.0201070933590.4076-100000@lola.stud.fh-heilbronn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Andrew Morton wrote:

> Matti Aarnio wrote:
> >
> >   I have partial evidence that EXT3 may be part of the problem,
> >   as another machine with RAID-1 disks with EXT2 filesystems
> >   is not hanging up when running RedHat 2.4.16-0.9custom kernel.
> >   That another machine has, however, IDE disks.
>
> I'd be surprised if an ext3 bug could cause a freeze as solid
> as this one.  ext3's write submission patterns are somewhat different
> from other filesystems, and we've exposed a few problem in underlying
> layers in the past because of this.  But who knows...
>
> Have you enabled the NMI watchdog?  nmi_watchdog=1 on the LILO
> commandline?
>
> Also, I'd be inclined to enable all the kernel debug options,
> including SLAB debug.
Heavy traffic on ext3 seems to cause short system freezes.

Seems only to happen on 2 or more processor boxes.

I'm not deep into kernel nor ext3, but how is the journal flushed if
full?

Greetings Oli

+++the jungle near manaos - the amazonas full of piranhas - the birds of++
+++paradies - disapear into the green desert - for years an years we're+++
+++hungry and desperate - for the only thing worth living - the E><CESS+++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



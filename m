Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310304AbSCKSEW>; Mon, 11 Mar 2002 13:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310185AbSCKSEQ>; Mon, 11 Mar 2002 13:04:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7299 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S310184AbSCKSDv>; Mon, 11 Mar 2002 13:03:51 -0500
Date: Mon, 11 Mar 2002 13:06:21 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gunther Mayer <gunther.mayer@gmx.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE on linux-2.4.18
In-Reply-To: <3C8CF054.91290065@gmx.net>
Message-ID: <Pine.LNX.3.95.1020311130532.3167A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Gunther Mayer wrote:

> "Richard B. Johnson" wrote:
> 
> > On Mon, 11 Mar 2002, Alan Cox wrote:
> >
> > > > hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=1024/255/63, UDMA(33)
> > > > Partition check:
> > > >  hda: hda1 hda2 < hda5 hda6 >
> > > > hd: unable to get major 3 for hard disk
> > >
> > > ^^^^^^^^^^^^^^^^^^
> > >
> > > Case dismissed ;)
> >
> > I haven't a clue what you are saying. Every IDE option that is allowed
> > is enabled in .config. The IDE drive(s) are found, but you imply, no
> > state, that I did something wrong. You state that I haven't enabled
> > something? I enabled everything that 'make config` allowed me to
> > enable. Now what is it?
> 
> You enabled too much(see hd.c):
> 
>     dep_bool '  Use old disk-only driver on primary interface'
> CONFIG_BLK_DEV_HD_IDE
> 
> will hog "major 3" (which is needed by IDE driver later).
> 

Okay. Thanks. I will try without CONFIG_BLK_DEV_HD_IDE

> 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

	Bill Gates? Who?


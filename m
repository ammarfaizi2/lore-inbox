Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264985AbSKAMwT>; Fri, 1 Nov 2002 07:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSKAMwT>; Fri, 1 Nov 2002 07:52:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25853 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264985AbSKAMwS>; Fri, 1 Nov 2002 07:52:18 -0500
Date: Fri, 1 Nov 2002 13:58:41 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Greg Kroah-Hartman <greg@kroah.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
In-Reply-To: <Pine.NEB.4.44.0211011222110.2875-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.NEB.4.44.0211011357330.2875-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

please ignore this mail, I found the patch that was already sent to l-k...

cu
Adrian


On Fri, 1 Nov 2002, Adrian Bunk wrote:

> On Wed, 30 Oct 2002, Linus Torvalds wrote:
>
> >...
> > Summary of changes from v2.5.44 to v2.5.45
> > ============================================
> >...
> > Greg Kroah-Hartman <greg@kroah.com>:
> >...
> >   o USB: drivers/net/irda fixups due to USB structure changes
> >...
>
> <--  snip  -->
>
> ...
>   gcc -Wp,-MD,drivers/net/irda/.irda-usb.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=irda_usb   -c -o drivers/net/irda/irda-usb.o
> drivers/net/irda/irda-usb.c
> drivers/net/irda/irda-usb.c: In function `irda_usb_probe':
> drivers/net/irda/irda-usb.c:1490: structure has no member named `bInterfaceNumber'
> make[3]: *** [drivers/net/irda/irda-usb.o] Error 1
>
> <--  snip  -->
>
> cu
> Adrian


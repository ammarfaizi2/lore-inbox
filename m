Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265239AbSJRQuZ>; Fri, 18 Oct 2002 12:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265215AbSJRQti>; Fri, 18 Oct 2002 12:49:38 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:18060 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265209AbSJRQsm>; Fri, 18 Oct 2002 12:48:42 -0400
Date: Fri, 18 Oct 2002 09:48:09 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHS] fbdev updates.
In-Reply-To: <Pine.GSO.4.21.0210151036400.25245-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.33.0210180948070.10832-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Done.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

On Tue, 15 Oct 2002, Geert Uytterhoeven wrote:

> On Mon, 14 Oct 2002, James Simmons wrote:
> > > On Sun, 13 Oct 2002, James Simmons wrote:
> > > > This is nearly the last of the fbdev api changes (90% of them). Alot of
> > > > driver fixes as well. The console related stuff in each fbdev driver
> > > > is nearly gone!!! Please do a pull. Thank you.
> > > >
> > > > bk://fbdev.bkbits.net/fbdev-2.5
> > >
> > > Please add the output of diffstat, so we know which files you changed.
> >
> > Better yet here is the BK patch via email.
> > @@ -220,12 +218,7 @@
> >     bool '  Advanced low level driver options' CONFIG_FBCON_ADVANCED
> >     if [ "$CONFIG_FBCON_ADVANCED" = "y" ]; then
> >        tristate '    Monochrome support' CONFIG_FBCON_MFB
>
> CONFIG_FBCON_MFB can be deleted, because of this change to the Makefile:
>
> > -obj-$(CONFIG_FBCON_MFB)           += fbcon-mfb.o
>
> >  #      tristate '    Atari interleaved bitplanes (16 planes) support' CONFIG_FBCON_IPLAN2P16
>
> FBCON_IPLAN2P16 can be deleted, since it doesn't exist.
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
>
>


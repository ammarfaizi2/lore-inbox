Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVCMSy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVCMSy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 13:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVCMSy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 13:54:58 -0500
Received: from witte.sonytel.be ([80.88.33.193]:43976 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261421AbVCMSyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 13:54:55 -0500
Date: Sun, 13 Mar 2005 19:53:55 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pavel Machek <pavel@ucw.cz>
cc: James Simmons <jsimmons@pentafluge.infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer
 Splash
In-Reply-To: <20050313182032.GA1427@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0503131953090.3876@numbat.sonytel.be>
References: <20050308015731.GA26249@spock.one.pl> <200503091301.15832.adaplas@hotpop.com>
 <9e473391050308220218cc26a3@mail.gmail.com> <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
 <1110392212.3116.215.camel@localhost.localdomain>
 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
 <1110408049.9942.275.camel@localhost.localdomain>
 <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be> <20050310145419.GD632@openzaurus.ucw.cz>
 <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
 <20050313182032.GA1427@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2005, Pavel Machek wrote:
> > > > > Thats why moving the eye candy console into user space is such a good
> > > > > idea. You don't have to run it 8) It also means that the console
> > > > > development is accessible to all the crazy rasterman types.
> > > > 
> > > > Yep. The basic console we already have. Everyone who wants eye candy can switch
> > > > from basic console to user space console in early userspace.
> > > > 
> > > 
> > > Heh, I'm afraid it does not work like that. Anyone who wants eye-candy
> > > simply applies broken patch to their kernel... unless their distribution applied one
> > > already.
> > > 
> > > Situation where we have one working eye-candy patch would certainly
> > > be an improvement.
> > 
> > Why do we need patches in the kernel. Just set you config to 
> > CONFIG_DUMMY_CONSOLE, CONFIG_FB, CONFIG_INPUT and don't set fbcon or 
> > vgacon. Then have a userspace app using /dev/fb and /dev/input create a 
> > userland console. There is no need to do special hacks in the kernel.
> 
> Except that I'll not get usefull reports from Oopsen and panic's,
> right? Ideally I'd also like high-priority kernel messages to be
> displayed during boot.

Indeed. I thought the idea was to use the existing fbcon support to draw
emergency messages to the screen.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

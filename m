Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVCKSDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVCKSDb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVCKSDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:03:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34521 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261222AbVCKSD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:03:27 -0500
Date: Fri, 11 Mar 2005 18:03:20 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer
 Splash
In-Reply-To: <20050310145419.GD632@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
References: <20050308015731.GA26249@spock.one.pl> <200503091301.15832.adaplas@hotpop.com>
 <9e473391050308220218cc26a3@mail.gmail.com> <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
 <1110392212.3116.215.camel@localhost.localdomain>
 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
 <1110408049.9942.275.camel@localhost.localdomain>
 <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be> <20050310145419.GD632@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Thats why moving the eye candy console into user space is such a good
> > > idea. You don't have to run it 8) It also means that the console
> > > development is accessible to all the crazy rasterman types.
> > 
> > Yep. The basic console we already have. Everyone who wants eye candy can switch
> > from basic console to user space console in early userspace.
> > 
> 
> Heh, I'm afraid it does not work like that. Anyone who wants eye-candy
> simply applies broken patch to their kernel... unless their distribution applied one
> already.
> 
> Situation where we have one working eye-candy patch would certainly
> be an improvement.

Why do we need patches in the kernel. Just set you config to 
CONFIG_DUMMY_CONSOLE, CONFIG_FB, CONFIG_INPUT and don't set fbcon or 
vgacon. Then have a userspace app using /dev/fb and /dev/input create a 
userland console. There is no need to do special hacks in the kernel.


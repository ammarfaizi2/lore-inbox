Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVCOTD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVCOTD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVCOTBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:01:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39867 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261787AbVCOS62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:58:28 -0500
Date: Tue, 15 Mar 2005 18:58:08 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Jon Smirl <jonsmirl@gmail.com>
cc: linux-fbdev-devel@lists.sourceforge.net,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer
 Splash
In-Reply-To: <9e473391050311101356536667@mail.gmail.com>
Message-ID: <Pine.LNX.4.56.0503151855430.5506@pentafluge.infradead.org>
References: <20050308015731.GA26249@spock.one.pl>  <200503091301.15832.adaplas@hotpop.com>
  <9e473391050308220218cc26a3@mail.gmail.com>  <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
  <1110392212.3116.215.camel@localhost.localdomain> 
 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org> 
 <1110408049.9942.275.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>  <20050310145419.GD632@openzaurus.ucw.cz>
  <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
 <9e473391050311101356536667@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Why do we need patches in the kernel. Just set you config to
> > CONFIG_DUMMY_CONSOLE, CONFIG_FB, CONFIG_INPUT and don't set fbcon or
> > vgacon. Then have a userspace app using /dev/fb and /dev/input create a
> > userland console. There is no need to do special hacks in the kernel.
> 
> /dev/fb is not accelerated, if you want full acceleration use
> /dev/dri. Using /dev/dri you can write a fully composited console that
> displays dengavi in realtime. This is also a path to getting multiuser
> working without a lot of kernel patches.

Not every device has a 3D core!!! DRM is not the answer for the entire graphics
world. Its only for 3D functionality. If you want eye candy without 3D on small
devices use fbdev. 

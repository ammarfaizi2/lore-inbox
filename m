Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVCJJOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVCJJOi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 04:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVCJJOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 04:14:36 -0500
Received: from witte.sonytel.be ([80.88.33.193]:33159 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262486AbVCJJNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 04:13:24 -0500
Date: Thu, 10 Mar 2005 10:12:03 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: James Simmons <jsimmons@pentafluge.infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer
 Splash
In-Reply-To: <1110408049.9942.275.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>
References: <20050308015731.GA26249@spock.one.pl> <200503091301.15832.adaplas@hotpop.com>
 <9e473391050308220218cc26a3@mail.gmail.com> <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
 <1110392212.3116.215.camel@localhost.localdomain>
 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
 <1110408049.9942.275.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Alan Cox wrote:
> On Mer, 2005-03-09 at 20:45, James Simmons wrote:
> > Thank you. We need some kind of basic console in the kernel. I'm not the 
> > biggest fan of eye candy. So moving the console to userspace for eye candy 
> > is a dumb idea.
> 
> Thats why moving the eye candy console into user space is such a good
> idea. You don't have to run it 8) It also means that the console
> development is accessible to all the crazy rasterman types.

Yep. The basic console we already have. Everyone who wants eye candy can switch
from basic console to user space console in early userspace.

Gr{oetje,eeting}s,

						Geert

P.S. Many years ago, when I discussed integrating the so-called `abstract
     console driver', which allowed to have vgacon and fbcon in the kernel, I
     also pondered to make the console a simple tty in response to a `KISS'
     request. Now it's time to make that happen ;-)
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

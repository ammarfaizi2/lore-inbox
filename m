Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUCQKjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 05:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbUCQKjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 05:39:16 -0500
Received: from witte.sonytel.be ([80.88.33.193]:33935 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261361AbUCQKjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 05:39:09 -0500
Date: Wed, 17 Mar 2004 11:39:00 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ian Campbell <icampbell@arcom.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] PXA255 LCD Driver
In-Reply-To: <1079518182.13373.27.camel@icampbell-debian>
Message-ID: <Pine.GSO.4.58.0403171137410.21104@waterleaf.sonytel.be>
References: <1079518182.13373.27.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004, Ian Campbell wrote:
> Attached is a patch against the most recent BK tree which implements a
> driver for the on-chip LCD controller of the Xscale PXA255 processor. It
> is based on the SA1100 FB driver and has been hacked on by various
> people on the ARM mailing list.
>
> I would appreciate a review of the code, any comments etc, with the aim
> of getting the driver into good shape to be merged.

> +For example:
> +	modprobe pxafb options=xres:640,yres:480,bpp:8,passive

Not much comments, except: why don't you use the standard modedb mode parameter
style?

> I posted it to the fbdev list @ sf.net (from MAINTAINERS) but that list
> seems to be pretty quiet and www.linux-fbdev.org (also from MAINTAINERS)

It's not quiet, though.

> seems to be down -- is there a more appropriate place these days for
> framebuffer stuff?

linux-fbdev-devel was correct.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUCQLPp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 06:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUCQLPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 06:15:45 -0500
Received: from witte.sonytel.be ([80.88.33.193]:59821 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261366AbUCQLPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 06:15:44 -0500
Date: Wed, 17 Mar 2004 12:15:37 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ian Campbell <icampbell@arcom.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] PXA255 LCD Driver
In-Reply-To: <1079521633.13370.39.camel@icampbell-debian>
Message-ID: <Pine.GSO.4.58.0403171215050.21104@waterleaf.sonytel.be>
References: <1079518182.13373.27.camel@icampbell-debian>
 <Pine.GSO.4.58.0403171137410.21104@waterleaf.sonytel.be>
 <1079521633.13370.39.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Ian,

On Wed, 17 Mar 2004, Ian Campbell wrote:
> > > +For example:
> > > +	modprobe pxafb options=xres:640,yres:480,bpp:8,passive
> >
> > Not much comments, except: why don't you use the standard modedb mode parameter
> > style?
>
> I was trying too (I mostly copied the i810 driver). How wrong did I get
> it? I'm willing to rework it to make it the same as the standard.

Take a look at drivers/video/modedb.c and fb_find_mode().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

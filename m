Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289169AbSAQP2J>; Thu, 17 Jan 2002 10:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289139AbSAQP1w>; Thu, 17 Jan 2002 10:27:52 -0500
Received: from main.sonytel.be ([195.0.45.167]:40667 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S289168AbSAQP0q>;
	Thu, 17 Jan 2002 10:26:46 -0500
Date: Thu, 17 Jan 2002 14:57:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev currcon
In-Reply-To: <Pine.LNX.4.10.10201141618410.1714-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0201151006470.12074-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, James Simmons wrote:
> This patch only applies for the -dj tree since the new fbdev api is going
> in there for now. This patch makes every fbdev driver uses the currcon
> that I have placed in struct fb_info. Currently most drivers have currcon,
> not the one for the console system, global. This is a problem if you have
> more than one card. I have tested to see if this compiles on ix86 but
> this patch is extensive so I like people to apply this patch to test it
> out against the dj14 tree. The patch is to big to post so it is avalibale
> at the following link:
> 
> NOTE: The setcolreg patch has to be applied first.
> 
> http://www.transvirtual.com/~jsimmons/setcolreg.diff
> http://www.transvirtual.com/~jsimmons/fbcurrcon.diff

You forgot the part that adds currcon to <linux/fb.h>.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


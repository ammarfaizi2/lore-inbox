Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSL0XTY>; Fri, 27 Dec 2002 18:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSL0XTY>; Fri, 27 Dec 2002 18:19:24 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:33461 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261693AbSL0XTW>;
	Fri, 27 Dec 2002 18:19:22 -0500
Date: Sat, 28 Dec 2002 00:25:58 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Linux-fbdev-devel] [FB PATCH]
In-Reply-To: <20021227150934.A3005@twiddle.net>
Message-ID: <Pine.GSO.4.21.0212280025150.17067-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Dec 2002, Richard Henderson wrote:
> I got link errors due to a missing fb_blank function.  The best
> I can figure is that you were intending to call the fb_blank 
> fbops hook.  Certainly that seems to work.
> 
> I'm not sure how no one else ran into this. 

Strange, it's defined in drivers/video/fbmem.c in my copy of 2.5.53.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


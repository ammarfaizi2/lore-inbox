Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292337AbSCDMzi>; Mon, 4 Mar 2002 07:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292330AbSCDMz3>; Mon, 4 Mar 2002 07:55:29 -0500
Received: from mail.sonytel.be ([193.74.243.200]:150 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S292337AbSCDMzP>;
	Mon, 4 Mar 2002 07:55:15 -0500
Date: Mon, 4 Mar 2002 13:54:54 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrey Ulanov <drey@au.ru>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] intel740 frame-buffer device driver
In-Reply-To: <20020227004943.A2678@gleam.rt.mipt.ru>
Message-ID: <Pine.GSO.4.21.0203041353260.29240-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Andrey Ulanov wrote:
> i wrote intel740 frame-buffer driver. i tested it with my hardware 
> with kernels 2.4.8, 2.4.14, 2.4.17 and 2.5.5. 
> 
> you can download the patch
> http://i740fbdev.sourceforge.net/download/patch-2.5.5-i740fb-020225.diff.gz
> 
> if anybody tested it, please drop me a report

Since i740fb uses resource management, please move its initialization up in
drivers/video/fbmem.c.

BTW, I also noticed a typo (`retrun' instead of `return').

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


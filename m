Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLKIBT>; Mon, 11 Dec 2000 03:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129824AbQLKIBK>; Mon, 11 Dec 2000 03:01:10 -0500
Received: from mail.sonytel.be ([193.74.243.200]:46992 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S129415AbQLKIA4>;
	Mon, 11 Dec 2000 03:00:56 -0500
Date: Mon, 11 Dec 2000 08:30:06 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] [PATCH] aty128fb & >8bit
In-Reply-To: <20001210134847.F4810@opus.bloom.county>
Message-ID: <Pine.GSO.4.10.10012110829230.29067-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Tom Rini wrote:
> Hello.  I just noticed that in 2.2.18pre27 you can only use the aty128fb
> driver at 8 bit, because of some missing bits to drivers/video/Config.in.
> w/o this you can't use console at > 8 bit nor X.  I would consider this to
> be a good thing to squash for 2.2.18 final because 2.2.18 is the 1st release
> in a while that works well on PPC, and lots of PPCs have a rage128.

You mean the FBCON_CFBx options with x > 8? You're correct that you need them
for a text console, but you don't need them for X.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

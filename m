Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314115AbSDFKBX>; Sat, 6 Apr 2002 05:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314116AbSDFKBW>; Sat, 6 Apr 2002 05:01:22 -0500
Received: from mail.sonytel.be ([193.74.243.200]:5600 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S314115AbSDFKBV>;
	Sat, 6 Apr 2002 05:01:21 -0500
Date: Sat, 6 Apr 2002 12:01:14 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Peter Horton <pdh@berserk.demon.co.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] radeonfb 2.4.19-pre2
In-Reply-To: <20020405163811.GB1902@berserk.demon.co.uk>
Message-ID: <Pine.GSO.4.21.0204061200220.2210-100000@lisianthus.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Peter Horton wrote:
> On Fri, Apr 05, 2002 at 12:15:22PM +0200, Geert Uytterhoeven wrote:
> > If you use the palette in directcolor modes (instead of emulating truecolor
> > mode), the console palette can be changed without redrawing the screen, just
> > like in VGA text mode.
> 
> Doesn't this then limit you to 32/64 colours in 15/16 bit mode (the
> original code reject attempts to set palette entries above these indexes)

Yes, but that's not a problem for emulating a text console. And the logo code
will use the 16-color penguin in that case.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


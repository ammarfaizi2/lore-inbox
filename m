Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312446AbSDEKP6>; Fri, 5 Apr 2002 05:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312459AbSDEKPk>; Fri, 5 Apr 2002 05:15:40 -0500
Received: from mail.sonytel.be ([193.74.243.200]:14498 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S312446AbSDEKPg>;
	Fri, 5 Apr 2002 05:15:36 -0500
Date: Fri, 5 Apr 2002 12:15:22 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Peter Horton <pdh@berserk.demon.co.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: [PATCH] radeonfb 2.4.19-pre2
In-Reply-To: <20020404214358.GA1811@berserk.demon.co.uk>
Message-ID: <Pine.GSO.4.21.0204051214240.10408-100000@lisianthus.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Peter Horton wrote:
> * Hacked wildly at the colour support to get it to work. Removed use of
> the palette for 15/16 bit modes (I can't fathom why it was there in the
> first place). The palette is now initialised to an identity mapping for
> 15/16/32 bit modes. The consoles now work fine at all colour depths, and
> the Tux logo is displayed correctly at all depths too :-)

If you use the palette in directcolor modes (instead of emulating truecolor
mode), the console palette can be changed without redrawing the screen, just
like in VGA text mode.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


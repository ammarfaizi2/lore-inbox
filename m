Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262634AbRFLR1W>; Tue, 12 Jun 2001 13:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbRFLR1M>; Tue, 12 Jun 2001 13:27:12 -0400
Received: from hood.tvd.be ([195.162.196.21]:26520 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S262634AbRFLR1D>;
	Tue, 12 Jun 2001 13:27:03 -0400
Date: Tue, 12 Jun 2001 19:23:51 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sergey Tursanov <__gsr@mail.ru>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: PC keyboard rate/delay
In-Reply-To: <53176576.20010612212337@mail.ru>
Message-ID: <Pine.LNX.4.05.10106121920100.7169-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001, Sergey Tursanov wrote:
> AC> You must have been reading my mind. Yesterday I traced at least one X11
> AC> hang down to the kernel and X server both frobbing with the port at the same
> AC> time and crashing the microcontroller on my PC110.
> 
> I think it would be better to place all of kbd controller code
> into the kernel instead of using various userspace programs
> such as kbdrate. Otherwise why KDKBDREP was defined ?-)

Because (almost?) all m68k machines don't have PC style keyboard controllers,
so we _had_ to invent some other way to implement it in a portable (across all
m68k machines) way.

<wishful thinking>
Of course it would be nice if all architectures would want to use it.
</wishful thinking>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSADJMc>; Fri, 4 Jan 2002 04:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288561AbSADJLv>; Fri, 4 Jan 2002 04:11:51 -0500
Received: from mail.sonytel.be ([193.74.243.200]:9157 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S288557AbSADJKn>;
	Fri, 4 Jan 2002 04:10:43 -0500
Date: Fri, 4 Jan 2002 10:09:46 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Who uses hdx=bswap or hdx=swapdata?
In-Reply-To: <E16MGPf-0001I3-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0201041009000.12102-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Alan Cox wrote:
> > Is the hdx=bswap or hdx=swapdata option actually in use?
> > When is it needed?
> 
> Certain M68K machines
> 
> > The current implementation can cause data corruptions on SMP with PIO 
> > transfers:
> > 
> > Is it possible to remove the option entirely, or should it be fixed?
> 
> Show me an SMP Atari ST 8)

IIRC it's used to access non-Atari IDE disks on Atari (which has a byte-swapped
IDE interface) and vice-versa.

So yes, you can use it on SMP machines, to access disks that were used before
on Atari.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


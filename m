Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288595AbSADK55>; Fri, 4 Jan 2002 05:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288596AbSADK5s>; Fri, 4 Jan 2002 05:57:48 -0500
Received: from mail.sonytel.be ([193.74.243.200]:45789 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S288595AbSADK5i>;
	Fri, 4 Jan 2002 05:57:38 -0500
Date: Fri, 4 Jan 2002 11:56:46 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Who uses hdx=bswap or hdx=swapdata?
In-Reply-To: <E16MRjQ-0003Sb-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0201041131010.12102-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Alan Cox wrote:
> > IIRC it's used to access non-Atari IDE disks on Atari (which has a byte-swapped
> > IDE interface) and vice-versa.
> > 
> > So yes, you can use it on SMP machines, to access disks that were used before
> > on Atari.
> 
> For 2.5 would it perhaps be cleaner if we had a bswapping loop device. Sort
> of very bad crypto mode ?

Don't mention crypto, or Atari will come after us with the DMCA sword, claiming
they deliberately implemented access control? ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289029AbSAMLUh>; Sun, 13 Jan 2002 06:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289065AbSAMLU0>; Sun, 13 Jan 2002 06:20:26 -0500
Received: from mail.sonytel.be ([193.74.243.200]:39831 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S289029AbSAMLUS>;
	Sun, 13 Jan 2002 06:20:18 -0500
Date: Sun, 13 Jan 2002 12:19:27 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Who uses hdx=bswap or hdx=swapdata?
In-Reply-To: <3C40BB5E.8AB0A44F@colorfullife.com>
Message-ID: <Pine.GSO.4.21.0201131218290.1198-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2002, Manfred Spraul wrote:
> Alan Cox wrote:
> > > IIRC it's used to access non-Atari IDE disks on Atari (which has a byte-swapped
> > > IDE interface) and vice-versa.
> > >
> > > So yes, you can use it on SMP machines, to access disks that were used before
> > > on Atari.
> > 
> > For 2.5 would it perhaps be cleaner if we had a bswapping loop device. Sort
> > of very bad crypto mode ?
> 
> I tried to implement that, but hdx=bswap operates on drives, and loop on
> partitions. Do you have another idea? It probably has to wait until the
> partition code is further cleaned up.

And if you use e.g. /dev/hda as loop parameter instead of /dev/hdaX?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



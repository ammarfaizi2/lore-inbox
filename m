Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbSADRVd>; Fri, 4 Jan 2002 12:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288695AbSADRV1>; Fri, 4 Jan 2002 12:21:27 -0500
Received: from mail.sonytel.be ([193.74.243.200]:28836 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S280126AbSADRVP>;
	Fri, 4 Jan 2002 12:21:15 -0500
Date: Fri, 4 Jan 2002 18:20:11 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Who uses hdx=bswap or hdx=swapdata?
In-Reply-To: <Pine.LNX.4.33.0201041751360.5790-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.21.0201041818580.12102-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Michael Schmitz wrote:
> > > For 2.5 would it perhaps be cleaner if we had a bswapping loop device. Sort
> > > of very bad crypto mode ?
> >
> > Don't mention crypto, or Atari will come after us with the DMCA sword, claiming
> > they deliberately implemented access control? ;-)
> 
> Caution - I recall that on some m68k boxes we had to further byteswap
> specific parts of the identify data or they wouldn't make sense. The IDE
> driver will still have to be aware of these exceptions. I can't recall the
> particulars anymore - Geert?

That's the drive identification. It indeed shouldn't be swapped once again when
accessing a `non-native' IDE disk.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


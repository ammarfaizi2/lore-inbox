Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317614AbSFMOPJ>; Thu, 13 Jun 2002 10:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317617AbSFMOPI>; Thu, 13 Jun 2002 10:15:08 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:44992 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S317614AbSFMOPH>;
	Thu, 13 Jun 2002 10:15:07 -0400
Date: Thu, 13 Jun 2002 16:14:02 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Keith Owens <kaos@ocs.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: 2.5.21 no source for several objects
In-Reply-To: <Pine.LNX.4.44.0206130707100.17419-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0206131612310.19522-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2002, James Simmons wrote:
> > drivers/video/Makefile
> > obj-$(CONFIG_FBCON_IPLAN2P16)     += fbcon-iplan2p16.o
> 
> I never seen that come to be. Geert any ideas on this? Since we are
> switching to the new api then the iplan stuff will be replaced eventually.
> Do we just remove it in this case.

Support for 16 bpp interleaved bitplanes on Atari has never been implemented.
You can remove it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


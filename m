Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266123AbRGGLb7>; Sat, 7 Jul 2001 07:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266103AbRGGLbj>; Sat, 7 Jul 2001 07:31:39 -0400
Received: from aeon.tvd.be ([195.162.196.20]:49579 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S266104AbRGGLba>;
	Sat, 7 Jul 2001 07:31:30 -0400
Date: Sat, 7 Jul 2001 13:27:46 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Howells <dhowells@redhat.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Russell King <rmk@arm.linux.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Jes Sorensen <jes@sunsite.dk>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] I/O Access Abstractions 
In-Reply-To: <3993.994149529@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.05.10107071326440.3943-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2001, David Howells wrote:
>  * It should make drivers easier to write: they don't have to worry about
>    whether a resource refers to memory or to I/O or to something more exotic.
> 
>  * It makes some drivers more flexible. For example, the ne2k-pci driver has
>    to be set at _compile_ time to use _either_ I/O ports _or_ memory. It'd
>    make Linux installation more better if _both_ were supported.
> 
>  * It'd allow some drivers to be massively cleaned up (serial.c).

And the IDE driver.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


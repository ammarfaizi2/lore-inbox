Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266855AbUHOTpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266855AbUHOTpg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 15:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUHOTpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 15:45:35 -0400
Received: from witte.sonytel.be ([80.88.33.193]:42139 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266855AbUHOTpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 15:45:32 -0400
Date: Sun, 15 Aug 2004 21:37:30 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Adrian Bunk <bunk@fs.tum.de>, Arnd Bergmann <arnd@arndb.de>,
       Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com,
       "David S. Miller" <davem@redhat.com>, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, sparclinux@vger.kernel.org,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
Subject: Re: architectures with their own "config PCMCIA"
In-Reply-To: <Pine.LNX.4.61.0408151928490.12687@scrub.home>
Message-ID: <Pine.GSO.4.58.0408152136400.9281@waterleaf.sonytel.be>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org>
 <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de>
 <20040811201725.GJ26174@fs.tum.de> <20040811214032.GC7207@mars.ravnborg.org>
 <20040812001003.GV26174@fs.tum.de> <Pine.LNX.4.58.0408121056270.20634@scrub.home>
 <20040814204711.GD1387@fs.tum.de> <Pine.LNX.4.61.0408151928490.12687@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004, Roman Zippel wrote:
> On Sat, 14 Aug 2004, Adrian Bunk wrote:
> > > This is less a problem, as here it's clear that you want a boolean result,
> > > but something like "FOO=n" is really a string compare and FOO could be of
> > > any type (that 99% of all symbols are boolean/tristate symbols doesn't
> > > really help).
> >
> > Wouldn't it be better to require a string or hex to always be quoted
> > like "somestring"?
>
> What about normal numbers? I don't think requiring quotes everywhere for
> this is a good idea.

And numbers (both decimal and hex) can easily be distinguished from y, n, and m
anyway.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbTICMhZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTICMhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:37:25 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:46991 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262012AbTICMhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:37:24 -0400
Date: Wed, 3 Sep 2003 14:36:34 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Jamie Lokier <jamie@shareable.org>, Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <Pine.LNX.4.44.0309031407050.20748-100000@serv>
Message-ID: <Pine.GSO.4.21.0309031436020.6985-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Roman Zippel wrote:
> On Wed, 3 Sep 2003, Geert Uytterhoeven wrote:
> > > Does the 68020 even _have_ the equivalent of a store buffer?
> > 
> > Good question :-)
> > 
> > After I sent the previous mail, I realized the '030 has 256 bytes I cache and
> > 256 bytes D cache, while the '020 has 256 bytes I cache only.
> 
> BTW the 020/030 caches are VIVT (and also only writethrough), the 040/060 
> caches are PIPT.

That explains a bit. But the '060 stores are coherent, while the '040 stores
aren't.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265761AbSKFRWx>; Wed, 6 Nov 2002 12:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265762AbSKFRWx>; Wed, 6 Nov 2002 12:22:53 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:54001 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265761AbSKFRWw>;
	Wed, 6 Nov 2002 12:22:52 -0500
Date: Wed, 6 Nov 2002 18:29:11 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Miles Bader <miles@gnu.org>
cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: yet another update to the post-halloween doc
In-Reply-To: <87r8dylpv4.fsf@tc-1-100.kawasaki.gol.ne.jp>
Message-ID: <Pine.GSO.4.21.0211061826280.25960-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Nov 2002, Miles Bader wrote:
> Dave Jones <davej@codemonkey.org.uk> writes:
> > Ports.
> > ~~~~~~
> > - 2.5 features support for several new architectures.
> ...
> >   - uCLinux. 68k(w/o MMU) and v850 platforms.
> 
> A nit, I suppose, but the v850 is not a `platform' in the conventional
> sense of the term, it's a completely new architecture.  uCLinux, OTOH,
> is not an architecture, but a tweak to various parts of the kernel to
> remove the requirement for an MMU (yeah I know what you meant, but
> others may not).

Yep, and since there are (unfinished) ports to MMU-less variants of machines
that are already supported by normal Linux, some more uClinux support may
appear in `normal' arch subdirectories in the future.
E.g. MMU-less Atari and Amiga (and Mac, anyone working on that?) are better off
with the platform support in arch/m68k/ than the one in arch/m68knommu/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


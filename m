Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268678AbUIXLPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268678AbUIXLPl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 07:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268682AbUIXLPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 07:15:41 -0400
Received: from witte.sonytel.be ([80.88.33.193]:7870 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268678AbUIXLPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 07:15:39 -0400
Date: Fri, 24 Sep 2004 13:15:26 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Pawe?? Sikora <pluto@pld-linux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbol __udivsi3_i4
In-Reply-To: <20040924105207.GH22710@lug-owl.de>
Message-ID: <Pine.GSO.4.61.0409241314530.27692@waterleaf.sonytel.be>
References: <20040924021050.689.qmail@web53608.mail.yahoo.com>
 <200409240801.57848.pluto@pld-linux.org> <Pine.GSO.4.61.0409241031410.27692@waterleaf.sonytel.be>
 <20040924105207.GH22710@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Jan-Benedict Glaw wrote:
> On Fri, 2004-09-24 10:33:12 +0200, Geert Uytterhoeven <geert@linux-m68k.org>
> wrote in message <Pine.GSO.4.61.0409241031410.27692@waterleaf.sonytel.be>:
> > On Fri, 24 Sep 2004, [utf-8] Pawe? Sikora wrote:
> > > On Friday 24 of September 2004 04:10, Donald Duckie wrote:
> > > > can somebody please help me how to overcome this
> > > > problem:
> > > > unresolved symbol __udivsi3_i4
> > > # objdump -T /lib/libgcc_s.so.1|grep div
> > > 000024c0 g    DF .text  00000162  GLIBC_2.0   __divdi3
> > > 00002b80 g    DF .text  000001ed  GCC_3.0     __udivmoddi4
> > > 00002870 g    DF .text  00000120  GLIBC_2.0   __udivdi3
> > > 
> > > you can link module with libgcc.a or fix it.
> > 
> > Just add an implementation for __udivsi3_i4 to arch/sh/lib/. They already have
> > udivdi3.c over there.
> 
> Either that (which I don't like!), or have a try compiling the kernel

Why don't you like that? It's done that way on most architectures.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

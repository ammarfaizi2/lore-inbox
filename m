Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263964AbTFVIS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 04:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264023AbTFVIS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 04:18:28 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:59821 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263964AbTFVIS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 04:18:27 -0400
Date: Sun, 22 Jun 2003 10:32:08 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
cc: Andrew Morton <akpm@digeo.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>, cw@f00f.org,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Isapnp warning
In-Reply-To: <16117.12138.153293.938793@nanango.paulus.ozlabs.org>
Message-ID: <Pine.GSO.4.21.0306221029110.869-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Paul Mackerras wrote:
> Andrew Morton writes:
> > Compared to 2.95.3, gcc-3.3 takes 1.5x as long to compile, and produces a
> > kernel which is 200k larger.
> 
> I just tried it on PPC.  Compared to 2.95.4, gcc-3.3 took 36% longer
> to compile and produced a kernel which was 120k smaller.

I have the same experience w.r.t. kernel size on MIPS, using 2.95.4 from Debian
woody on the target, and 3.2.2 for cross-compiling.

Perhaps the code increase is for CISC only?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTICJ30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTICJ3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:29:25 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:6601 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261722AbTICJ0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:26:42 -0400
Date: Wed, 3 Sep 2003 11:26:03 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <20030903091356.GA20528@mail.jlokier.co.uk>
Message-ID: <Pine.GSO.4.21.0309031122460.6985-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Jamie Lokier wrote:
> Geert Uytterhoeven wrote:
> > So the store buffer is coherent on 68020 with external MMU, while it
> > isn't on 68040 with internal MMU...
> 
> Does the 68020 even _have_ the equivalent of a store buffer?

Good question :-)

After I sent the previous mail, I realized the '030 has 256 bytes I cache and
256 bytes D cache, while the '020 has 256 bytes I cache only.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


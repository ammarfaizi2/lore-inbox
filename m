Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbTIJQ7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbTIJQ7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:59:20 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:2439 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265256AbTIJQ7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:59:08 -0400
Date: Wed, 10 Sep 2003 18:58:25 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matthew Wilcox <willy@debian.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Marc Zyngier <maz@wild-wind.fr.eu.org>, Ralf Baechle <ralf@gnu.org>,
       Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] Move EISA_bus
In-Reply-To: <20030909222937.GH18654@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.21.0309101857560.1390-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Matthew Wilcox wrote:
> When I change the setting of CONFIG_EISA, everything rebuilds.  This is
> because EISA_bus is declared in <asm/processor.h> which is implicitly
> included by just about everything.  This is a silly place to declare it,
> so this patch moves it to include/linux/eisa.h.

BTW, can't the same be done with MCA_bus?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


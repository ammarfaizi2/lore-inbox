Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265016AbTGBOKS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 10:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265020AbTGBOKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 10:10:18 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:2546 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265016AbTGBOKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 10:10:13 -0400
Date: Wed, 2 Jul 2003 16:23:51 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Bernardo Innocenti <bernie@develer.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
In-Reply-To: <Pine.LNX.4.44.0307012203001.2047-100000@home.osdl.org>
Message-ID: <Pine.GSO.4.21.0307021623090.15047-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003, Linus Torvalds wrote:
> On Wed, 2 Jul 2003, Bernardo Innocenti wrote:
> > This code makes gcc select the "udivmodsi4" pattern on the m68k
> > backend
> 
> Who cares about m68k? Does it do the right thing on x86? gcc 3.2.2 does

Just for the record, I do ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



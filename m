Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbTELPBX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTELPBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:01:23 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:473 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262170AbTELPBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:01:21 -0400
Date: Mon, 12 May 2003 17:13:55 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new kconfig goodies
In-Reply-To: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
Message-ID: <Pine.GSO.4.21.0305121712310.11877-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003, Roman Zippel wrote:
> 3. Finally I added support for ranges, so that this becomes possible:
> 
> config LOG_BUF_SHIFT
> 	int "Kernel log buffer size" if DEBUG_KERNEL
> 	range 10 20
> 	...
> 
> Right now this is only used to check the direct user input, this means 
> directly editing .config will ignore the range (please don't rely on this
> feature :) ).

I hope `make oldconfig' also checks the range? Imagine ranges being changed in
the Kconfig file.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


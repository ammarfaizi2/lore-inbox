Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265257AbUFTKb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbUFTKb7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 06:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUFTKb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 06:31:59 -0400
Received: from witte.sonytel.be ([80.88.33.193]:19441 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265257AbUFTKb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 06:31:57 -0400
Date: Sun, 20 Jun 2004 12:31:55 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: page allocation failure. order:0, mode:0x20
In-Reply-To: <40D565FE.1050903@yahoo.com.au>
Message-ID: <Pine.GSO.4.58.0406201231280.23356@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0406201115470.23356@waterleaf.sonytel.be>
 <40D565FE.1050903@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, Nick Piggin wrote:
> Geert Uytterhoeven wrote:
> > While running 2.6.7 on my Amiga, I got:
> >
> > | cp: page allocation failure. order:0, mode:0x20
> > | Call Trace: [<000290a8>] __alloc_pages+0x230/0x250
> Not even atomic allocations memory are allowed to consume all memory.
> A small amount is reserved for memory freeing (which sometimes
> requires initial memory allocations).
>
> The message should be harmless.

Yep, the files I was copying got copied correctly.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbTDNJNl (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 05:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbTDNJNl (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 05:13:41 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:28369 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S262905AbTDNJNk (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 05:13:40 -0400
Date: Mon, 14 Apr 2003 11:24:33 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Paul Mackerras <paulus@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <1050311961.5575.47.camel@zion.wanadoo.fr>
Message-ID: <Pine.GSO.4.21.0304141122340.28305-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Apr 2003, Benjamin Herrenschmidt wrote:
> On Mon, 2003-04-14 at 10:39, Geert Uytterhoeven wrote:
> 
> > Indeed. Ataris and Q40/Q60s have byteswapped IDE busses, but they expect
> > on-disk data to be that way, for compatibility with e.g. TOS.
> 
> Some designers need to be shot...
> 
> What about optionally making fix_drive_id a platoform hook
> (like it was, but with a reasonable default) to avoid clobbering
> the common code with those #ifdefs ?

Yes, I already suggested that in my IDE patch for 2.4.x. But I was in a hurry,
since I wanted to get m68k IDE working in 2.4.21.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUFRNQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUFRNQH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 09:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265138AbUFRNQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 09:16:07 -0400
Received: from witte.sonytel.be ([80.88.33.193]:12977 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265053AbUFRNQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 09:16:04 -0400
Date: Fri, 18 Jun 2004 15:16:01 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Finn Thain <ft01@webmastery.com.au>, Andreas Schwab <schwab@suse.de>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: make checkstack on m68k
In-Reply-To: <20040618130242.GD18258@wohnheim.fh-wedel.de>
Message-ID: <Pine.GSO.4.58.0406181513470.11779@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be>
 <je3c4uqum0.fsf@sykes.suse.de> <Pine.LNX.4.58.0406180048180.13963@bonkers.disegno.com.au>
 <20040617182658.GB29029@wohnheim.fh-wedel.de> <Pine.GSO.4.58.0406172115050.1495@waterleaf.sonytel.be>
 <Pine.GSO.4.58.0406172130130.1495@waterleaf.sonytel.be>
 <20040618130242.GD18258@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, [iso-8859-1] Jörn Engel wrote:
> On Thu, 17 June 2004 21:36:11 +0200, Geert Uytterhoeven wrote:
> > *bummer*
> >
> > why doesn't checkstack.pl complain if I forget to specify `m68k'?!?
>
> It tries to guess the architecture on it's own.  Guessing is not
> working for m68k, aparently.
>
> What does "uname -m" tell you?

That I'm cross-compiling on an ia32 box ;-)

> [ Yes, this breaks for cross compilation.  If anyone really cares,
> please send patches. ]

Not needed, it was my own fault, running it by hand...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265590AbUFIGhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUFIGhX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 02:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265594AbUFIGhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 02:37:23 -0400
Received: from witte.sonytel.be ([80.88.33.193]:61635 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265590AbUFIGhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 02:37:22 -0400
Date: Wed, 9 Jun 2004 08:37:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: sk98lin (was: Re: Linux 2.6.7-rc2)
In-Reply-To: <ca4r6t$p16$1@gatekeeper.tmr.com>
Message-ID: <Pine.GSO.4.58.0406090833080.24779@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
 <1086187044.6179.8.camel@hostmaster.org> <200406041706.27716.vda@port.imtp.ilyichevsk.odessa.ua>
 <ca4r6t$p16$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2004, Bill Davidsen wrote:
> The solution may be an external table, program, or whatever, since the
> situation changes as drivers are modified to support new models,
> chipsets move to new vendors, etc. But it would be *really nice* to find
> the 3c940 with 3COM drivers, instead of grepping driver source and
> looking at spec sheets to find out that the driver is called something
> like sk98lin, it's in an unobvious place and has a name unrelated to 3COM.

Another problem with the sk98lin driver is that it hasn't yet been converted to
the new driver model. Even when booting Knoppix, you have to manually modprobe
sk98lin to use the 3c940. Took me a while to find out...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

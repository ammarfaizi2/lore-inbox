Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTIQJWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 05:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbTIQJWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 05:22:30 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:26063 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261825AbTIQJW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 05:22:29 -0400
Date: Wed, 17 Sep 2003 11:21:30 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pavel Machek <pavel@suse.cz>
cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
In-Reply-To: <20030916200655.GG602@elf.ucw.cz>
Message-ID: <Pine.GSO.4.21.0309171120290.3644-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Pavel Machek wrote:
> > With 2.4.22, my Sony Vaio PCG-Z600TEK (s/600/505/ in US/JP) shows a regression
> > w.r.t. power management:
> >   - It doesn't poweroff anymore (screen contents are still there after the
> >     powering down message)
> >   - It doesn't reboot anymore (screen goes black, though)
> >   - It accidentally suspended to RAM once while I was actively working on it (I
> >     never managed to get suspend working, except for this `accident'). I didn't
> >     see any messages about this in the kernel log.
> 
> It suspended to RAM... Did it also *resume* correctly?

Yes, since I could continue working without problems (except for lost Ethernet,
solved by ifdown -a/ifup -a).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


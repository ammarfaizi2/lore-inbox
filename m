Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751684AbWHTI6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbWHTI6b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 04:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWHTI6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 04:58:31 -0400
Received: from witte.sonytel.be ([80.88.33.193]:30960 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751683AbWHTI6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 04:58:31 -0400
Date: Sun, 20 Aug 2006 10:50:01 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Adrian Bunk <bunk@stusta.de>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] paravirt.h
In-Reply-To: <44E67B6E.10706@goop.org>
Message-ID: <Pine.LNX.4.62.0608201047520.4809@pademelon.sonytel.be>
References: <1155202505.18420.5.camel@localhost.localdomain> <44DB7596.6010503@goop.org>
 <20060819012133.GH7813@stusta.de> <44E67B6E.10706@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006, Jeremy Fitzhardinge wrote:
> Adrian Bunk wrote:
> > These are Linux specific operations.
> > 
> > Without an _GPL you are in the grey area where courts have to decide whether
> > a module using this would be a derived work according to copyright law in
> > $country_of_the_court and therefore has to be GPL.
> > 
> > With the _GPL, everything is clear without any lawyers involved.
> >   
> 
> Hardly.  The _GPL is a hint as to the intent of the author, but it is no more
> than a hint.
> 
> My intent here (and I think the intent of the other authors) is not to cause
> breakage of things which currently work, so the _GPL is not appropriate for
> that reason.  Paravirt_ops is a restatement of many interfaces which already
> exist in Linux in a non-_GPL form, so making the structure _GPL is effectively

My copy of linux-2.6.18-rc4/COPYING doesn't mention anything about these
`non-_GPL' interfaces. It does mention `normal system calls', but AFAIK symbols
exported to modules are not syscalls.

> relicensing them.

That's a pretty strong statement...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

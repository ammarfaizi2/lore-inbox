Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVBYUbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVBYUbV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 15:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVBYUbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 15:31:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:34437 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261309AbVBYUbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 15:31:18 -0500
Date: Fri, 25 Feb 2005 12:31:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: ARM undefined symbols.  Again.
In-Reply-To: <20050225202349.C27842@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0502251227480.9237@ppc970.osdl.org>
References: <20050124154326.A5541@flint.arm.linux.org.uk>
 <20050131161753.GA15674@mars.ravnborg.org> <20050207114359.A32277@flint.arm.linux.org.uk>
 <20050208194243.GA8505@mars.ravnborg.org> <20050208200501.B3544@flint.arm.linux.org.uk>
 <20050209104053.A31869@flint.arm.linux.org.uk> <20050213172940.A12469@flint.arm.linux.org.uk>
 <4210A345.6030304@grupopie.com> <20050225194823.A27842@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0502251158280.9237@ppc970.osdl.org> <20050225202349.C27842@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Feb 2005, Russell King wrote:
> 
> We can't say "you must use the current CVS binutils to build the
> kernel" because that's not a sane toolchain base to build products
> on.

Sure. But it's probably enough that just a couple of core developers would 
have a CVS version to make sure that when it occasionally happens, it gets 
noticed quickly enough.

In other words, I don't think you can say "get the CVS version" to most 
users, but I do not see for example you you or some of the people around 
you don't have at least one setup set up with that fixed version.

This has been going on for at least a year, probably longer. I could 
understand it if it was a "we found this old bug, and haven't had time to 
get around it", but what I don't understand is when there's been a tools 
bug that's been known about for a long time, and apparently nobody has 
ever even bothered to try the fixed versions.

> And yes, the toolchain peoples point of view is "fix the kernel".

For a known bug where just having _one_ active developer using a fixed 
tool would mean that this doesn't happen?

That makes no sense. Or, more likely, it means that the toolchain people 
are incompetent bastards who don't care about bugs and have no pride at 
all in what they do.

		Linus

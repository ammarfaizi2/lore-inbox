Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269685AbTGJXLS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269687AbTGJXLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:11:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30131 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269685AbTGJXLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:11:17 -0400
Date: Thu, 10 Jul 2003 16:25:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.75
In-Reply-To: <20030711000546.B20214@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307101617280.4971-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jul 2003, Russell King wrote:
> 
> Absolutely no surprise.  In any case, the long development cycle isn't
> what ARM stuff needs.

Well, nothing really _wants_ a long development cycle. I suspect any 
particular feature taken on its own always wants the shortest possible 
development cycle, and that what ends up happening is just that there are 
a lot of interdepencies and just plain "different" development-cycles.

Which is not a bad thing per se, and pretty clearly is unavoidable. So 
I'm not complaining. It's just a fact of life.

I think that the best way to "solve" the problem is to partially ignore 
it, and I don't think it's a bad thing that we have many different trees, 
and some of them are less strongly coupled to others - exactly to handle 
the inevitable case of release cycle lag.

For example, I absolutely detest the BSD "world" model, which actually 
makes these problems bigger by tying different projects together into one 
tree. I think it's much more important to try to have as much freedom as 
possible, including very much having separate timetables and development 
environments.

> Hasn't ever, I'm afraid.  I can't think of any stock kernel which has
> been usable, let alone been compilable for ARM.  Which, IMO, is a pretty
> sorry statement to make.

You see that as a sorry statement, but I don't think it's a failure. Why 
_should_ one tree have to try to make everybody happy? We want to try to 
make it easier to keep the couplings in place by striving for portable 
infrastructure etc, but we would only be hampered by a philosophy that 
says "everything has to work in tree X", since that just means that you 
can't afford to break things.

I'd much rather keep the freedom to break stuff, and have many separate
trees that break _different_ things, and let them all co-exist in a 
friendly rivalry.

And my tree is just one tree in that forest.

So it's not a bug - it's a FEATURE!

			Linus


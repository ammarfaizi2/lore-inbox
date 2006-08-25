Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWHYJH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWHYJH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWHYJH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:07:29 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:12816 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751375AbWHYJH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:07:28 -0400
Date: Fri, 25 Aug 2006 10:07:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Juha Yrjola <juha.yrjola@solidboot.com>
Cc: Daniel Drake <dan@reactivated.net>, Pierre Ossman <drzeus-list@drzeus.cx>,
       Matt Reimer <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2GB MMC/SD cards
Message-ID: <20060825090717.GA2287@flint.arm.linux.org.uk>
Mail-Followup-To: Juha Yrjola <juha.yrjola@solidboot.com>,
	Daniel Drake <dan@reactivated.net>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Matt Reimer <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org
References: <20060603141548.GA31182@flint.arm.linux.org.uk> <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com> <4481FB80.40709@drzeus.cx> <4484B5AE.8060404@drzeus.cx> <44869794.9080906@drzeus.cx> <20060607165837.GE13165@flint.arm.linux.org.uk> <448738CD.8030907@drzeus.cx> <4488AC57.7050201@drzeus.cx> <44DEFBA1.6060500@reactivated.net> <44EB2083.8080902@solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EB2083.8080902@solidboot.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 06:19:31PM +0300, Juha Yrjola wrote:
> Daniel Drake wrote:
> >Hi Pierre,
> >
> >Pierre Ossman wrote:
> >>Suggested patch included.
> >
> >What's the status on this patch? A Gentoo user at 
> >http://bugs.gentoo.org/142172 reports that it is required for him to be 
> >able to access his card, so it definitely works in some form.
> 
> I have to pitch in here.  This patch is required for some cards to 
> operate reliably on the Nokia 770, and we've done quite a bit of 
> interoperability testing already.
> 
> Pierre, could you submit it to RMK's patch tracking system?

Absolutely not.

MMC is a little up in the air at the moment while I decide whether I want
to continue the cherade of being the maintainer of it.  It is a cherade
because the person doing 99% of the work is Pierre, and for some strange
reason, he's the one who gets all the bug reports.

This makes it extremely difficult for me to ascertain whether any patch is
correct or not - all I have to go by is the documentation, and as far as
I can see, the majority of the documentation I have says this patch is
wrong.

So I'm considering handing maintainership over to Pierre.  If I don't
have the support of the community, which is being voiced pretty loudly
by its actions, this move makes sense.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

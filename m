Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVCCIUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVCCIUv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 03:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVCCIUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 03:20:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:58288 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261584AbVCCIU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 03:20:28 -0500
Date: Thu, 3 Mar 2005 00:19:58 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303081958.GA29524@kroah.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 05:15:36PM -0800, Linus Torvalds wrote:
> The thing is, I _do_ believe the current setup is working reasonably well.  
> But I also do know that some people (a fairly small group, but anyway)  
> seem to want an extra level of stability - although those people seem to
> not talk so much about "it works" kind of stability, but literally a "we
> can't keep up" kind of stability (ie at least a noticeable percentage of
> that group is not complaining about crashes, they are complaining about
> speed of development).
> 
> And I suspect that _anything_ I do won't make those people happy.

That single sentence sums it up perfectly.  When I have given talks
about how our current development cycle works, and what's happening with
it, people just feel odd seeing all of this change happen and get upset
at it.  Perhaps it's because they never paid attention before, or that
they are new to Linux and like to believe that old-style development
models were somehow "better", and that they know we are doing something
wrong.

But when pressed about the issue of speed of development, rate of
change, feature increase, driver updates, and so on, no one else has any
clue of what to do.  They respond with, "but only put bugfixes into a
stable release."  My comeback is explaining how we handle lots of
different types of bugfixes, by api changes, real fixes, and driver
updates for new hardware.  Sometimes these cause other bugs to happen,
or just get shaken out where they were previously hiding (acpi is a
great example of this issue.)  In the end, they usually fall back on
muttering, "well, I'm just glad that I'm not a kernel developer..." and
back away.

Like I previously said, I think we're doing a great job.  The current
-mm staging area could use some more testers to help weed out the real
issues, and we could do "real" releases a bit faster than every 2 months
or so.  But other than that, we have adapted over the years to handle
this extremely high rate of change in a pretty sane manner.

So don't spend too much time worring that we need to make those types of
people happy.  As Jeff said, no other OS is accepting changes at such a
high rate.  But then again, no other OS supports more devices, on more
different processors.  So we must be doing something right :)

thanks,

greg k-h

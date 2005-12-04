Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVLDX0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVLDX0O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 18:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVLDX0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 18:26:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:54478 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932228AbVLDXZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 18:25:48 -0500
Date: Sun, 4 Dec 2005 15:12:48 -0800
From: Greg KH <greg@kroah.com>
To: "M." <vo.sinh@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204231248.GE8914@kroah.com>
References: <20051203211209.GA4937@kroah.com> <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com> <1133645895.22170.33.camel@laptopd505.fenrus.org> <f0cc38560512031353q27ee0a2dh70e283f53671b70f@mail.gmail.com> <1133682973.5188.3.camel@laptopd505.fenrus.org> <f0cc38560512040657i58cc08efqa8596c357fcea82e@mail.gmail.com> <1133709038.5188.49.camel@laptopd505.fenrus.org> <f0cc38560512040724re5114c2y76bb34d63c9c5ae0@mail.gmail.com> <20051204224707.GB8914@kroah.com> <f0cc38560512041503y7abd1f12rbce8bdac0ebdf30d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0cc38560512041503y7abd1f12rbce8bdac0ebdf30d@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 12:03:20AM +0100, M. wrote:
> > The way the kernel is developed is _so_ different from any traditional
> > software development process is defined.  So for people to try to put
> > traditional requirements on the kernel (6 month cycles, etc.) is just
> > not realistic.
> 
> Mhhh BSDs and MacOSX kernel are developed without taking "the unknown" into
> account: planned releases and bla blah and they dont miss features. Yeah
> linux is faster, but there could be a middle point between strict release
> cycles and "ok let's put it in cause it's going to make something run
> faster"

MacOSX is developed this way?  I think you will find a lot of Apple
engineers disagree with you...

And BSD is also quite different than Linux in many different ways, the
development community being one of these differences.  And that one
difference makes a lot of difference.

> > And please for everyone wanting to go with a stable series like is being
> > proposed, go read the thread a while ago on this list that caused the
> > creation of the -stable tree.  In it lots of people who know what they
> > are talking about discuss the difficulties of doing a "bug fix only"
> > tree, and other such things.  Out of that discussion came the very
> > restrictive guidelines that are described in
> > Documentation/stable_kernel_rules.txt.  To try to do more than what is
> > defined there, without lots of money and man-power behind you, is a
> > quick trip to madness...
> 
> 
> The proposal was in fact to come out with a 2.6.X release every 6 months
> trying to align every distro on it and to "get" their man-power and money as
> a side effect. Maybe i'm not sufficiently good with english to let you all
> understand clearly but the proposal was to do 2/3/4 releases the
> normal/current style, even adding new and previously unknown
> features/patches/whatever and to do the last release before the next
> 2.6.Xwith only bugfix and stabilization in mind; If you think over it
> it's the
> same approach of every release:
> 
> - patches get in until -rc;
> - 2 weeks bugfix only;
> - release;
> 
> but applied to a 6months timeline.

That will not work.  Again, go back and read that thread.  We seeing
this shorter development cycle get backed up even when it streaches to 2
months.  For it to go to 6 months would be madness.

If you don't understand why I say this, please go look at the different
developer trees that start accumilating patches during this "bugfix
only" timeframe.

> It's not a -stable/strict/specifics-based tree but a way to align
> everyone to the same kernel version and to get stabilization and
> maintenance as a side effect.

And you believe that the enterprise distros will some how flock to this
kernel release instead?  Why would they?  What would it gain them?

thanks,

greg k-h

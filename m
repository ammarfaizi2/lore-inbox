Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVLDWra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVLDWra (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 17:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVLDWr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 17:47:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:63422 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932360AbVLDWr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 17:47:29 -0500
Date: Sun, 4 Dec 2005 14:47:07 -0800
From: Greg KH <greg@kroah.com>
To: "M." <vo.sinh@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204224707.GB8914@kroah.com>
References: <20051203201945.GA4182@kroah.com> <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com> <20051203211209.GA4937@kroah.com> <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com> <1133645895.22170.33.camel@laptopd505.fenrus.org> <f0cc38560512031353q27ee0a2dh70e283f53671b70f@mail.gmail.com> <1133682973.5188.3.camel@laptopd505.fenrus.org> <f0cc38560512040657i58cc08efqa8596c357fcea82e@mail.gmail.com> <1133709038.5188.49.camel@laptopd505.fenrus.org> <f0cc38560512040724re5114c2y76bb34d63c9c5ae0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0cc38560512040724re5114c2y76bb34d63c9c5ae0@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 04:24:36PM +0100, M. wrote:
> On 12/4/05, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Sun, 2005-12-04 at 15:57 +0100, M. wrote:
> > > if distros would align on those 6months versions those less
> > > experienced users would get 5 years support on those kernels.
> >
> > no distro gives 5 years of support for a kernel done every 6 months;
> > they start such projects more like every 18 to 24 months (SuSE used to
> > do it a bit more frequently but it seems they also slowed this down).
> 
> 
> yeah but I would mean if there's a 6months release cycle like GNOME & co.
> there would be more opportunities in different distros using the same kernel
> like those distros do with GNOME & co. If they use the same 'current'
> 6months kernel available in the 18/24 time window this will lead to unified
> base kernel for every distro and those distro could mantain it for years

The kernel is unlike GNOME in so many different ways, there's just no
way to compare their development cycles.

People remember, the kernel evolves organically.  We don't know what's
going to be in the next 2 kernel releases just because we don't know
what's going to show up, and what hardware is going to be released, and
what kind of problems people are going to have, and what kind of
proposed patches are going to work out.

The way the kernel is developed is _so_ different from any traditional
software development process is defined.  So for people to try to put
traditional requirements on the kernel (6 month cycles, etc.) is just
not realistic.

And please for everyone wanting to go with a stable series like is being
proposed, go read the thread a while ago on this list that caused the
creation of the -stable tree.  In it lots of people who know what they
are talking about discuss the difficulties of doing a "bug fix only"
tree, and other such things.  Out of that discussion came the very
restrictive guidelines that are described in
Documentation/stable_kernel_rules.txt.  To try to do more than what is
defined there, without lots of money and man-power behind you, is a
quick trip to madness...

Best of luck to you all,

greg k-h

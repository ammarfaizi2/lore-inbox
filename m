Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVCCBTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVCCBTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVCCBQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:16:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:23947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261372AbVCCBOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:14:41 -0500
Date: Wed, 2 Mar 2005 17:15:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <20050303002047.GA10434@kroah.com>
Message-ID: <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
 <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com>
 <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Mar 2005, Greg KH wrote:
> 
> I think this statement proves that the current development situation is
> working quite well.  The nasty breakage and details got worked out in
> the -mm tree, and then flowed into your tree when they seemed sane.

Actually, the breakage I was talking about got fixed in _my_ tree.

I'd love for the -mm tree to get more testing, but it doesn't. 

> So, any driver stuff is just fine?  Great, I don't have an issue with
> your proposal then, as it wouldn't affect me that much :)

I don't know about "any", but yeah.

> I do understand what you are trying to achieve here, people don't really
> test the -rc releases as much as a "real" 2.6.11 release.  Getting a
> week of testing and bugfix only type patches to then release a 2.6.12
> makes a lot of sense.  For example, see all of the bug reports that came
> out of the woodwork today on lkml from the 2.6.11 release...

A large part of it is psychological. On the other hand, it may be that
Neil is right and it would just mean that people wouldn't even test the
odd releases (..because they want to wait a couple of weeks for the even
one), so it may not actually end up helping much.

The thing is, I _do_ believe the current setup is working reasonably well.  
But I also do know that some people (a fairly small group, but anyway)  
seem to want an extra level of stability - although those people seem to
not talk so much about "it works" kind of stability, but literally a "we
can't keep up" kind of stability (ie at least a noticeable percentage of
that group is not complaining about crashes, they are complaining about
speed of development).

And I suspect that _anything_ I do won't make those people happy.

		Linus

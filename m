Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWIULHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWIULHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 07:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWIULHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 07:07:41 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:55979 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750808AbWIULHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 07:07:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19 -mm merge plans
Date: Thu, 21 Sep 2006 13:10:43 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
References: <20060920135438.d7dd362b.akpm@osdl.org> <45123307.8090809@garzik.org> <20060920234828.a86e095a.akpm@osdl.org>
In-Reply-To: <20060920234828.a86e095a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609211310.43634.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 21 September 2006 08:48, Andrew Morton wrote:
> On Thu, 21 Sep 2006 02:36:55 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> > Andrew Morton wrote:
> > > If you think that shortening the release cycle will cause people to be more
> > > disciplined in their changes, to spend less time going berzerk and to spend
> > > more time working with our users and testers on known bugs then I'm all
> > > ears.
> > 
> > Honestly, I do think it would be positive.  It would shorten the 
> > feedback loop, and get more changes out to testers.
> > 
> > It would also decrease the pressure of the 60+ trees trying to get 
> > everything in, because they know the next release is 3-4 months away. 
> > It would be _much_ easier to say "break the generic device stuff in 
> > 2.6.20 not 2.6.19, please" if we knew 2.6.20 wasn't going to be a 2007 
> > release.
> > 
> 
> Well, it might be worth trying.  But there's a practical problem: how do we
> get there when there's so much work pending?  If we skip some people's
> trees then they'll get sore, and it's not obvious that it'll help much, as
> the various trees are fairly unrelated (ie: parallelisable).
> 
> I guess the most practical way is to incrementally shorten the cycles.
> 
> 
> <rerererepeating self>
> 
> I do think that any process change we make should send the signal "slow
> down, be more careful, test and review it more carefully".  Or at least,
> "try to make sure it compiles".
> 
> A compulsory Reviewed-by: would wedge things up nicely ;)

Well, I think this need not help.  Like when some USB-related changes that
had been reviewed and even tested happened to break ohci-hcd because they
had only been tested on uhci ...

IMHO every change should appear in at least three consecutive -mm kernels
without causing any problems before it's allowed to go to the mainline.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

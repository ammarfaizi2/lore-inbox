Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWIVSxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWIVSxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWIVSxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:53:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63247 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932104AbWIVSxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:53:14 -0400
Date: Fri, 22 Sep 2006 13:16:36 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: release cycle (Re: 2.6.19 -mm merge plans)
Message-ID: <20060922131635.GE4055@ucw.cz>
References: <20060920135438.d7dd362b.akpm@osdl.org> <45121382.1090403@garzik.org> <20060920220744.0427539d.akpm@osdl.org> <45123307.8090809@garzik.org> <20060920234828.a86e095a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920234828.a86e095a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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
> 
> Well, it might be worth trying.  But there's a practical problem: how do we
> get there when there's so much work pending?  If we skip some people's
> trees then they'll get sore, and it's not obvious that it'll help much, as
> the various trees are fairly unrelated (ie: parallelisable).

Well, slightly evil way would be 'if we find vfs changes in your ocfs
tree, well, you wait for one more release' :-).

				Pavel

-- 
Thanks for all the (sleeping) penguins.

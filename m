Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbTIEKc1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 06:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbTIEKcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 06:32:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48290 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262443AbTIEKcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 06:32:08 -0400
Date: Fri, 5 Sep 2003 12:32:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: Brian Litzinger <brian@top.worldcontrol.com>,
       Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: revert to 2.6.0-test3 state
Message-ID: <20030905103207.GC16859@atrey.karlin.mff.cuni.cz>
References: <20030904115824.GD24015@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0309040820520.940-100000@localhost.localdomain> <20030905041316.GA1886@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905041316.GA1886@top.worldcontrol.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, you have to understand that I don't want to call software_suspend() at 
> > all. You've made the choice not to accept the swsusp changes, so we're 
> > forking the code. We will have competing implementations of 
> > suspend-to-disk in the kernel. 
> 
> And the fork happened in 2.6.0-test4?
> 
> Some how I thought the 6, being even, meant stable.
> 
> I am at a complete loss how these test3 to test4 major changes
> that broke everything meet with the often repeated definitions
> of how kernel development is to be accomplished.
> 
> Perhaps I missed something, development kernels include all
> odd numbers and 6?

Patrick decided 6 is odd for him and Linus failed to stop that :-(. We
are working on fixing it up now. Hopefully in -test6 or so time it
works at least as good as it did in -test3, then there's some chance
for improvement (some of his patches actually look pretty good).
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.

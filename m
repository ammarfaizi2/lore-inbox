Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933835AbWKWQEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933835AbWKWQEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933846AbWKWQEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:04:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44562 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S933835AbWKWQEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:04:04 -0500
Date: Thu, 23 Nov 2006 13:39:05 +0000
From: Pavel Machek <pavel@suse.cz>
To: Mike Galbraith <efault@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061123133904.GD5561@ucw.cz>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org> <1163958727.5977.15.camel@Homer.simpson.net> <200611191958.15152.rjw@sisk.pl> <1163966016.5744.8.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163966016.5744.8.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Sane people use suspend-to-ram, and that's when you need the suspend and 
> > > > resume debugging.
> > > 
> > > Here I am wishing I had the _opportunity_ to be sane.  With my ATI X850
> > > AGP card, I have no choices except swsusp or reboot.
> > 
> > Have you tried s2ram (http://en.opensuse.org/S2ram)?
> 
> Cool.  That shows potential.  On an 2.6.19-rc6-rt4 kernel, it looked
> like it _might_ have eventually gotten past boot.  At one line of kernel
> output every ~10 seconds though, I gave up.  Virgin 2.6.19-rc6 went
> panic with a black screen... have options, will tinker.

Try that -rt kernel, but turn off dyntick/hires timers. Also try
hitting keyboard while resuming.

-- 
Thanks for all the (sleeping) penguins.

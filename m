Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWCWQVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWCWQVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWCWQVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:21:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24584 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161002AbWCWQVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:21:02 -0500
Date: Tue, 21 Mar 2006 15:31:57 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu, trini@kernel.crashing.org
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Message-ID: <20060321153157.GA2500@ucw.cz>
References: <20060318142827.419018000@localhost.localdomain> <20060318142830.607556000@localhost.localdomain> <20060318120728.63cbad54.akpm@osdl.org> <9a8748490603181223i32391d96nf794e93aa734f785@mail.gmail.com> <1142713820.17279.140.camel@localhost.localdomain> <20060318130446.18f4ae40.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318130446.18f4ae40.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  > I don't like potential userspace breakage any more than the next guy,
> >  > but if the breakage only affects buggy applications then I think it's
> >  > more acceptable.
> > 
> >  Yes, it only breaks buggy applications.
> 
> But we live in the real world.  There could be four-year-old applications
> which passed all their Linux QA and which work perfectly well.
> 
> Then the kernel guys make some correctness change and that application
> totally fails on new kernels.  Your choice is a) don't use new kernels or
> b) hold off the new kernel until your provider (if the company or internal
> group still exists) has put out a new version of the application and then
> you wear the (considerable) cost of upgrading what was a perfectly-running
> application.
> 
> And whose fault was it?  Ours.  Because older kernels had the wrong
> checking (thus causing that app's QA to pass) and because later kernels
> changed the rules.

Can we do printk now and fix it after a while in feature-removal?
Or maybe we shoul create new bug-removal file :-).
						Pavel

-- 
Thanks, Sharp!

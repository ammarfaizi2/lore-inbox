Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWJHTOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWJHTOF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWJHTOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:14:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30395 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751337AbWJHTOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:14:02 -0400
Date: Sun, 8 Oct 2006 21:13:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bryce Harrington <bryce@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, vatsa@in.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, shaohua.li@intel.com,
       hotplug_sig@osdl.org, lhcs-devel@lists.sourceforge.net
Subject: Re: Status on CPU hotplug issues
Message-ID: <20061008191350.GB3788@elf.ucw.cz>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org> <20061006231012.GH22139@osdl.org> <20061006162924.344090f8.akpm@osdl.org> <20061007102419.GB30034@elf.ucw.cz> <20061007202521.GA24743@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007202521.GA24743@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > How well tested is this?  From my reading, this will cause
> > > > > enable_nonboot_cpus() to panic.  Is that intended?
> > > > 
> > > > I wanted to give you an update on results of cpu testing I've done on
> > > > recent kernels and several architectures.  Since -rc1 is out, I wanted
> > > > to give added visibility to the few issues that remain.
> > > > 
> > > > The full results are available here:
> > > > 
> > > >     http://crucible.osdl.org/runs/hotplug_report.html
> > > > 
> > > > This is actually a report for cpu hotplug tests generated hourly,
> > > > however we run it against all of the kernel -git snapshots posted to
> > > > kernel.org.  Whereever you see a blank square, it indicates the kernel
> > > > either failed to build or boot.
> > 
> > So... patch-2.6.18-git4 failed to boot on all architectures? I'm
> > seeing very little green fields there... actually I only see two green
> > fields in whole table.
> 
> No, it failed to build due to a patching issue that has since been fixed
> (I can rerun those older runs if there is interest.)

Reruning few of them and deleting rest from table would be nice.

> > > iirc Pavel did some testing a month or two ago and was seeing userspace
> > > misbehaviour?
> > 
> > Pavel did some testing (like two threads trying to plug/unplug cpus at
> > the same time), and seen machines dying real fast; but that was fixed,
> > IIRC, and I did not really torture it after that.
> 
> If this test is available, I could include it in my test runs if you
> think it would be worth tracking.

Is shell script acceptable form of a test?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

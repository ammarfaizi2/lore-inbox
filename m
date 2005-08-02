Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVHBOY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVHBOY3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVHBOXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:23:17 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:63407 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261546AbVHBOUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:20:35 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1122991531.5490.27.camel@mindpipe>
References: <20050730160345.GA3584@elte.hu> <1122756435.29704.2.camel@twins>
	 <20050730205259.GA24542@elte.hu> <1122785233.10275.3.camel@mindpipe>
	 <20050731063852.GA611@elte.hu>  <1122871521.15825.13.camel@mindpipe>
	 <1122991018.1590.2.camel@localhost.localdomain>
	 <1122991531.5490.27.camel@mindpipe>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 02 Aug 2005 10:20:26 -0400
Message-Id: <1122992426.1590.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 10:05 -0400, Lee Revell wrote:
> On Tue, 2005-08-02 at 09:56 -0400, Steven Rostedt wrote:
> > On Mon, 2005-08-01 at 00:45 -0400, Lee Revell wrote:
> > > On Sun, 2005-07-31 at 08:38 +0200, Ingo Molnar wrote:
> > > > ok - i've uploaded the -52-04 patch, does that fix it for you?
> > > 
> > > Has anyone found their PS2 keyboard rather sluggish with this kernel?
> > > I'm not sure whether it's an -RT problem, I'll have to try rc4.
> > 
> > I've just noticed this now. While I have lots of ssh sessions running,
> > my keyboard does get really sluggish. This hasn't happened before. I'm
> > currently running 2.6.13-rc3 with no RT.  So this may definitely be a
> > mainline issue.
> 
> I'm on a slower machine, and I seem to get this behavior regardless of
> load.  Probably just running X+Gnome on this box is enough.
> 
> Are you in any position to do a binary search?  It would be really bad
> to release 2.6.13 with this problem...

Unfortunately no. I'm trying to finish a milestone that was due last
Friday, debug a problem that was found on my last milestone, and add a
feature to Ingo's RT patch. So I can't get to this till at earliest next
week.

Also, I don't know if this is a kernel issue or a debian issue since I
updated my kernel at the same time I did a debian upgrade, and I'm using
debian unstable. Since debian unstable is going through some major
changes, this could be caused by that.  I may be able to try some other
machines to see if they are affected, but that might take some time
before I can get to it.

The machine that I noticed this on is a SMP AMD 2.1GHz with a gig of
ram. So the keyboard shouldn't be affected by the screen display. But I
have had X problems with the latest release of debian unstable.

-- Steve



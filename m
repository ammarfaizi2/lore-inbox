Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbVIFB2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVIFB2G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 21:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVIFB2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 21:28:06 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:47889 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S965064AbVIFB2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 21:28:05 -0400
Date: Tue, 6 Sep 2005 03:28:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [GIT PATCHES] kbuild updates
Message-ID: <20050906012828.GB7562@mars.ravnborg.org>
References: <20050905174150.GA17923@mars.ravnborg.org> <200509052035.14156.s0348365@sms.ed.ac.uk> <20050905201345.GA26106@mars.ravnborg.org> <200509052232.04135.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509052232.04135.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > How is this different from the preempt module vermagic?
> > >
> > > ~$ modinfo agpgart | grep vermagic
> > > vermagic:       2.6.13 preempt gcc-4.0
> >
> > My bad. Adding PREEMT to UTS_VERSION makes it visible in uname -a.
> >
> 
> I see. I can understand adding an extraversion for SMP and experimental 
> patches (like Ingo's RT work), but why is it useful to differentiate (by 
> name) between preempt and non-preempt kernels? Do distributors wish to 
> package both in parallel?

PREEMPT is in UTS_VERSION for the same reason as being present in
vermagic. It is one of these options being so fundamentally that we like
to both test for it and to know it when runinng uname.

	Sam

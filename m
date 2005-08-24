Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVHXWkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVHXWkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 18:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVHXWkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 18:40:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7082 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932342AbVHXWkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 18:40:42 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       George Anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508242142420.3743@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>
	 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508162337130.3728@scrub.home>
	 <1124241449.8630.137.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508182213100.3728@scrub.home>
	 <1124505151.22195.78.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508202204240.3728@scrub.home>
	 <1124737075.22195.114.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508230134210.3728@scrub.home>
	 <1124830262.20464.26.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508232321530.3728@scrub.home>
	 <1124838847.20617.11.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508240134050.3743@scrub.home>
	 <1124906422.20820.16.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508242043220.3728@scrub.home>
	 <1124910953.20820.34.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508242142420.3743@scrub.home>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 15:40:30 -0700
Message-Id: <1124923231.20820.87.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 21:49 +0200, Roman Zippel wrote:
> On Wed, 24 Aug 2005, john stultz wrote:
> 
> > from your example:
> > >		// at init: system_update = update_cycles * mult;
> > > 		system_time += system_update;
> > 
> > and:
> > > 	error = system_time - (xtime.tv_nsec << shift);
> > 
> > This doesn't seem to make sense with the above.  Could you clarify?
> 
> The example here doesn't keep the complete system time, just enough to 
> compute the difference.

Hey Roman, 

Ok, well, I'm still at a loss for understanding how this avoids my
concern about time inconsistencies. However, I don't want to burn any
more of your patience explaining it, so in the hopes making some
productive outcome, I'm going to take a step back, pull the most trivial
and uncontroversial cleanups and fixes in my patches and try to send
them to Andrew one by one.

Hopefully that will give me a chance to spend some time and understand
your suggestions (or maybe allow someone else to express your
suggestions differently) and think of alternate solutions without
feeling like I'm constantly running into walls.

Again, I really do appreciate the time you've spent giving me feedback.

thanks
-john


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbVHXTuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbVHXTuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbVHXTuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:50:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:53434 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751494AbVHXTt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:49:59 -0400
Date: Wed, 24 Aug 2005 21:49:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       George Anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <1124910953.20820.34.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0508242142420.3743@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com> 
 <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home>
  <1124151001.8630.87.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508162337130.3728@scrub.home>
  <1124241449.8630.137.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0508182213100.3728@scrub.home>  <1124505151.22195.78.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508202204240.3728@scrub.home>  <1124737075.22195.114.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508230134210.3728@scrub.home>  <1124830262.20464.26.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508232321530.3728@scrub.home>  <1124838847.20617.11.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508240134050.3743@scrub.home>  <1124906422.20820.16.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508242043220.3728@scrub.home> <1124910953.20820.34.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 Aug 2005, john stultz wrote:

> from your example:
> >		// at init: system_update = update_cycles * mult;
> > 		system_time += system_update;
> 
> and:
> > 	error = system_time - (xtime.tv_nsec << shift);
> 
> This doesn't seem to make sense with the above.  Could you clarify?

The example here doesn't keep the complete system time, just enough to 
compute the difference.

bye, Roman

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030505AbVIOVsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbVIOVsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbVIOVsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:48:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:42948 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030505AbVIOVsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:48:08 -0400
Date: Thu, 15 Sep 2005 14:48:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Porter <mporter@kernel.crashing.org>, kumar.gala@freescale.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][MM] rapidio: message interface updates
Message-ID: <20050915144805.C27452@cox.net>
References: <20050907081312.B1925@cox.net> <5322C997-A1FD-47BB-B92B-17CBA627EC53@freescale.com> <20050915082451.A26921@cox.net> <20050915122301.41da6fb3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050915122301.41da6fb3.akpm@osdl.org>; from akpm@osdl.org on Thu, Sep 15, 2005 at 12:23:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 12:23:01PM -0700, Andrew Morton wrote:
> Matt Porter <mporter@kernel.crashing.org> wrote:
> >
> > On Thu, Sep 15, 2005 at 10:05:43AM -0500, Kumar Gala wrote:
> > > I'm guessing we are looking at a 2.6.15 timeframe now for getting the  
> > > RapidIO subsystem in?  Are there any other changes beyond what is  
> > > setting in -mm that need to be done?
> > 
> > Well, at least 2.6.15, 2.6.14 cutoff has passed.
> 
> Merging rapidio has negligible chance of breaking any existing kernel code,
> but I suppose that to be good little kernel citizens we should await 2.6.15
> if that's OK.

That's fine with me.
 
> > We are waiting on
> > a review of of the rionet updates I reposted a week ago. I've held
> > off on going too far with MMIO and 8548 support since the last rionet
> > changes required changes to the messaging support.
> 
> Jeff added the rionet driver to his tree and I dropped it from -mm, so
> we're ready to go on that front.

Ok, I did see that. Guess that was an ack then. :)

-Matt

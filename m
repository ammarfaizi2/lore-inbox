Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVASW0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVASW0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVASWWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:22:47 -0500
Received: from gprs215-130.eurotel.cz ([160.218.215.130]:61910 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261942AbVASWUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:20:41 -0500
Date: Wed, 19 Jan 2005 23:20:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119222021.GC17325@elf.ucw.cz>
References: <20050119000556.GB14749@atomide.com> <20050119113642.GA1358@elf.ucw.cz> <20050119171106.GA14545@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119171106.GA14545@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > As this patch is related to the VST/High-Res timers, there
> > > are probably various things that can be merged. I have not
> > > yet looked at what all could be merged.
> > > 
> > > I'd appreciate some comments and testing!
> > 
> > Good news is that it does seem to reduce number of interrupts. Bad
> > news is that time now runs faster (like "sleep 10" finishes in ~5
> > seconds) and that I could not measure any difference in power
> > consumption.
> 
> Thanks for trying it out. I have quite accurate time here on my
> systems, and sleep works as it should. I wonder what's happening on
> your system? If you have a chance, could you please post the results
> from following simple tests?

Correction: with patch was not 2.6.11-rc1, but 2.6.11-rc1-bk.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

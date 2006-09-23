Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWIWLIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWIWLIB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 07:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWIWLIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 07:08:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60624 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750728AbWIWLIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 07:08:00 -0400
Date: Sat, 23 Sep 2006 13:07:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060923110749.GC20778@elf.ucw.cz>
References: <20060920135438.d7dd362b.akpm@osdl.org> <20060921131433.GA4182@elte.hu> <20060922130648.GD4055@ucw.cz> <20060922190106.GA32638@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922190106.GA32638@elte.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > would be nice to merge the -hrt queue that goes right ontop this 
> > > queue. Even if HIGH_RES_TIMERS is "default n" in the beginning. That 
> > > gives us high-res timers and dynticks which are both very important 
> > > features to certain classes of users/devices.
> > 
> > dynticks give benefit of 0.3W, or 20minutes (IIRC) from 8hours on 
> > thinkpad x60... and they were around for way too long. (When baseline 
> > is hz=250, it is 0.5W from hz=1000 baseline). It would be cool to 
> > finally merge them.
> 
> note that this is a new implementation of dynticks though, not Con's 
> older stuff which you probably used, right? But it's fairly low-impact 

(Well, I cheated, and just measured difference between HZ=100 and
HZ=250/1000. Dynticks should be even slightly better than that.)
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

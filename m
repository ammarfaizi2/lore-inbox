Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSFVBXi>; Fri, 21 Jun 2002 21:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSFVBXh>; Fri, 21 Jun 2002 21:23:37 -0400
Received: from bitmover.com ([192.132.92.2]:4323 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316822AbSFVBXg>;
	Fri, 21 Jun 2002 21:23:36 -0400
Date: Fri, 21 Jun 2002 18:23:37 -0700
From: Larry McVoy <lm@bitmover.com>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
Message-ID: <20020621182337.T23670@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	Daniel Phillips <phillips@arcor.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E17LUyA-0001wU-00@starship> <200206220107.g5M17AXp028825@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200206220107.g5M17AXp028825@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Fri, Jun 21, 2002 at 09:07:10PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 09:07:10PM -0400, Horst von Brand wrote:
> Right. If they had designed it for 4/8 CPUs from the start, they would
> surely have gotten it dead wrong. Just to find out how wrong around now...

I couldn't disagree more.  The reason that all the SMP threaded OS's start
to suck is that managers say "Yeah, one CPU is good but how about 2?"  Then
a year goes by and then they say "Yeah, 2 CPUs are good but how about 4?".
Etc.  So the system is never designed, it is hacked.  It's no wonder they
suck.

My point has always been that if you were told up front that you needed to
hit 2 orders of magnitude more CPUs than you have today, the design you'd
end up with would be very different than the "just hack it some more to get
2x more CPUs".  

The interesting thing is to look at the ways you'd deal with a 1024 processors
and then work backwards to see how you scale it down to 1.  There is NO WAY
to scale a fine grain threaded system which works on a 1024 system down to
a 1 CPU system, those are profoundly different.  

I think you could take the OS cluster idea and scale it up as well as down.
Scaling down is really important, Linux works well in the embedded space,
that is probably the greatest financial success story that Linux has, let's
not screw it up.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

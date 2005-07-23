Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVGWD4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVGWD4u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 23:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVGWD4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 23:56:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61452 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262345AbVGWD4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 23:56:49 -0400
Date: Sat, 23 Jul 2005 05:56:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Blaisorblade <blaisorblade@yahoo.it>,
       LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
       torvalds@osdl.org
Subject: Re: Giving developers clue how many testers verified certain	kernel version
Message-ID: <20050723035643.GD3160@stusta.de>
References: <200507230244.11338.blaisorblade@yahoo.it> <42E1986B.8070202@linuxwireless.org> <1122088160.6510.7.camel@mindpipe> <42E1A832.7010604@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E1A832.7010604@linuxwireless.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 09:15:14PM -0500, Alejandro Bonilla wrote:
> Lee Revell wrote:
> 
> >On Fri, 2005-07-22 at 20:07 -0500, Alejandro Bonilla wrote:
> > 
> >>I will get flames for this, but my laptop boots faster and sometimes 
> >>responds faster in 2.4.27 than in 2.6.12. Sorry, but this is the fact 
> >>for me. IBM T42.
> >
> >Sorry dude, but there's just no way that any automated process can catch
> >these.
> >
> I'm not looking for an automated process for this. But for all in 
> general, when moving from 2.6.11 to 2.6.12 or from any version to 
> another. (At least in the same kernel branch)
>...

You send:
- a problem description X
- tell that the last working kernel was Y
- tell that it is broken in kernel Z

The probability of any kernel developer being interested in your problem 
increases:
- the better the description X is
- the nearer versions Y and Z are together
- the more recent version Y is

Ideally, you are able to say that patch A in the latest -mm kernel
broke it.

It's perfectly OK to send a description X that says:
- with version Y and the following workload B, everything is working
  perfectly
- with version Z and the same workload B, XMMS is stuttering

If any kernel developer is interested in your bug report, he will tell 
you which data might be interesting for debugging the problem.

The problem is that debugging a problem often requires knowledge about 
possible causes and changes between versions Y and Z in this area. Even 
a kernel developer who perfectly knows one part of the kernel might not 
be able to debug a problem in a completely different area of the kernel.

> .Alejandro

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


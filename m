Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272674AbRHaMSp>; Fri, 31 Aug 2001 08:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272676AbRHaMSe>; Fri, 31 Aug 2001 08:18:34 -0400
Received: from www.heureka.co.at ([195.64.11.111]:19720 "EHLO
	www.heureka.co.at") by vger.kernel.org with ESMTP
	id <S272674AbRHaMSS>; Fri, 31 Aug 2001 08:18:18 -0400
Date: Fri, 31 Aug 2001 14:18:04 +0200
From: David Schmitt <david@heureka.co.at>
To: linux-kernel@vger.kernel.org
Subject: Re: ISSUE: DFE530-TX REV-A3-1 times out on transmit
Message-ID: <20010831141803.A15177@www.heureka.co.at>
In-Reply-To: <20010829144834.A32319@www.heureka.co.at> <Pine.LNX.4.30.0108292012440.1604-100000@cola.teststation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0108292012440.1604-100000@cola.teststation.com>
User-Agent: Mutt/1.3.20i
Organization: Heureka - Der EDV-Dienstleister
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 08:45:34PM +0200, Urban Widmark wrote:
> On Wed, 29 Aug 2001, David Schmitt wrote:
> > under 'normal loads' (ie one tcp d/l at max, few other traffic) the
> > situation didn' get better, it hangs as often as with the original
> > via-rhine, at least it feels so. No hard figures here. But even
> > writing this mail (via ssh) here parallel to a download over the lan
> > (from the same server) triggers resets.
> 
> That is still pretty awful ... but it doesn't stop working?
> (you say hangs, but then resets)

sorry, sloppy language. hang == reset (in this case)

> > under heavy loads (ie with multiple flood pings) it resets often but I
> > couldn't push it over the edge anymore. I have it running now for
> > several minutes under multiple pingfloods and it always recovered
> > (from quite a amount of resets).
> 
> Ok, that means the "D-Link magic" does improve reset.

Yes. Until your patch 2.4.9 resetted three or four times sucessfully
and then the resets stopped working. With your patch it resets as
often but doesn't fail resetting anymore.

> It may be interesting to find out which parts that help. I simply added
> things that looked good ... Lacking information on what the bit-flipping
> is supposed to do, one way to try and do that is to remove code and see
> how much can be removed without breaking anything.
> (Sounds like a childrens game, except for programmers ...)

Hehe, bruteforcing it :-))

> I'll still try generating collisions and see what happens. If I can't
> reproduce this perhaps you would test a different patch to see which
> change that made a difference?

Sure, the machine is fast enough to handle another kernel recompile or
two :^))



Regards, David
-- 
Signaturen sind wie Frauen. Man findet selten eine Vernuenftige
	-- gesehen in at.linux

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272038AbRH2Spn>; Wed, 29 Aug 2001 14:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272043AbRH2Spd>; Wed, 29 Aug 2001 14:45:33 -0400
Received: from fungus.teststation.com ([212.32.186.211]:1297 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S272038AbRH2SpX>; Wed, 29 Aug 2001 14:45:23 -0400
Date: Wed, 29 Aug 2001 20:45:34 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: David Schmitt <david@heureka.co.at>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ISSUE: DFE530-TX REV-A3-1 times out on transmit
In-Reply-To: <20010829144834.A32319@www.heureka.co.at>
Message-ID: <Pine.LNX.4.30.0108292012440.1604-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2001, David Schmitt wrote:

> under 'normal loads' (ie one tcp d/l at max, few other traffic) the
> situation didn' get better, it hangs as often as with the original
> via-rhine, at least it feels so. No hard figures here. But even
> writing this mail (via ssh) here parallel to a download over the lan
> (from the same server) triggers resets.

That is still pretty awful ... but it doesn't stop working?
(you say hangs, but then resets)

> under heavy loads (ie with multiple flood pings) it resets often but I
> couldn't push it over the edge anymore. I have it running now for
> several minutes under multiple pingfloods and it always recovered
> (from quite a amount of resets).

Ok, that means the "D-Link magic" does improve reset.

It may be interesting to find out which parts that help. I simply added
things that looked good ... Lacking information on what the bit-flipping
is supposed to do, one way to try and do that is to remove code and see
how much can be removed without breaking anything.
(Sounds like a childrens game, except for programmers ...)

I'll still try generating collisions and see what happens. If I can't
reproduce this perhaps you would test a different patch to see which
change that made a difference?

/Urban


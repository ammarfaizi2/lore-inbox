Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272608AbTG1Gjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272668AbTG1Gjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:39:35 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:41476
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S272608AbTG1Gje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:39:34 -0400
Date: Sun, 27 Jul 2003 23:45:16 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Mike Galbraith <efault@gmx.de>
cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
In-Reply-To: <5.2.1.1.2.20030728065857.01bc9708@pop.gmx.net>
Message-ID: <Pine.LNX.4.10.10307272338160.30891-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jul 2003, Mike Galbraith wrote:

> At 09:18 PM 7/27/2003 +0200, Felipe Alfaro Solana wrote:
> >On Sun, 2003-07-27 at 15:40, Ingo Molnar wrote:
> > > my latest scheduler patchset can be found at:
> > >
> > >       redhat.com/~mingo/O(1)-scheduler/sched-2.6.0-test1-G6
> > >
> > > this version takes a shot at more scheduling fairness - i'd be interested
> > > how it works out for others.
> >
> >This -G6 patch is fantastic, even without nicing the X server. I didn't
> >even need to tweak any kernel scheduler knob to adjust for maximum
> >smoothness on my desktop. Response times are impressive, even under
> >heavy load. Great!
> 
> Can you try the following please?
> 
> This one I just noticed:
> 1.  start top.
> 2.  start dd if=/dev/zero | dd of=/dev/null
> 3.  wiggle a window very briefly.
> Here, X becomes extremely jerky, and I think this is due to two 
> things.  One, X uses it's sleep_avg very quickly, and expires.  Two, the 
> piped dd now is highly interactive due to the ns resolution clock (uhoh).

What kind of LAME test is this?  If "X becomes extremely jerky" ?

Sheesh, somebody come up with a build class solution.

CONFIG_SERVER
CONFIG_WORKSTATION
CONGIG_IAMAGEEKWHOPLAYSGAMES
CONFIG_GENERIC_LAMER

Determining quality of the scheduler based on how a mouse responds is ...

Sorry but this is just laughable, emperical subjective determination
based on a random hardware combinations for QA/QC for a test?

Don't bother replying cause last thing I want to know is why.

-a


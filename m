Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144496AbRA2AQI>; Sun, 28 Jan 2001 19:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144575AbRA2AP6>; Sun, 28 Jan 2001 19:15:58 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:8198 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S144496AbRA2APq>; Sun, 28 Jan 2001 19:15:46 -0500
Date: Mon, 29 Jan 2001 01:14:59 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: James Sutherland <jas88@cam.ac.uk>, jamal <hadi@cyberus.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
Message-ID: <20010129011459.B9408@pcep-jamie.cern.ch>
In-Reply-To: <Pine.GSO.4.30.0101280700580.24762-100000@shell.cyberus.ca> <Pine.SOL.4.21.0101281324210.26837-100000@yellow.csi.cam.ac.uk> <20010128144204.B13195@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010128144204.B13195@xi.linuxpower.cx>; from greg@linuxpower.cx on Sun, Jan 28, 2001 at 02:42:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:
> > > There is nothing silly with the decision, davem is simply a modern day
> > > internet hero.
> > 
> > No. If it were something essential, perhaps, but it's just a minor
> > performance tweak to cut packet loss over congested links. It's not
> > IPv6. It's not PMTU. It's not even very useful right now!
> 
> No. ECN is essential to the continued stability of the Internet. Without
> probabilistic queuing (i.e. RED) and ECN the Internet will continue to have
> retransmit synchronization and once congested stay congested until people get
> frustrated and give it up for a little bit.

There are other forms of probabilistic queuing, and RED+ECN may not be
one of the ones which scales as the net gets larger....  We're keen on
latency, burst avoidance and other quality guarantees these days.  ECN
is an improvement of just RED alone of course.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136937AbRA1IuC>; Sun, 28 Jan 2001 03:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136950AbRA1Itw>; Sun, 28 Jan 2001 03:49:52 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:25231 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S136937AbRA1Itr>; Sun, 28 Jan 2001 03:49:47 -0500
Date: Sun, 28 Jan 2001 08:48:59 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Gregory Maxwell <greg@linuxpower.cx>
cc: David Schwartz <davids@webmaster.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <20010127191159.B7467@xi.linuxpower.cx>
Message-ID: <Pine.SOL.4.21.0101280844150.14226-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001, Gregory Maxwell wrote:
> On Sat, Jan 27, 2001 at 11:09:27PM +0000, James Sutherland wrote:
> > On Sat, 27 Jan 2001, David Schwartz wrote:
> > 
> > > 
> > > > Firewalling should be implemented on the hosts, perhaps with centralized
> > > > policy management. In such a situation, there would be no reason to filter
> > > > on funny IP options.
> > > 
> > > 	That's madness. If you have to implement your firewalling on every host,
> > > what do you do when someone wants to run a new OS? Forbid it?
> > 
> > Of course. Then you find out about some new problem you want to block, so
> > you spend the next week reconfiguring a dozen different OS firewalling
> > systems. Hrm... I'll stick with a proper firewall, TYVM!
> 
> It's this kind of ignorance that makes the internet a less secure and stable
> place.
> 
> The network should not be a stateful device. If you need stateful
> firewalling the only place it should be implimented is on the end node. If
> management of that is a problem, then make an interface solve that problem
> insted of breaking the damn network.

I'm not suggesting making the network a stateful device. I'm suggesting
having a firewall. That should NOT be implemented on the end node. Apart
from anything else, the firewall shouldn't run any services: this is a bit
difficult on a server...

The network isn't broken. It works very nicely, TYVM. The firewall will
occasionally need reconfiguring (block out new types of attack, allow new
services, etc.) It's just much easier (and more secure) on a dedicated
firewall than running a load of filtering on every single server.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

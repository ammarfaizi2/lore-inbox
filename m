Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278046AbRJ0Ili>; Sat, 27 Oct 2001 04:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279795AbRJ0Il2>; Sat, 27 Oct 2001 04:41:28 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:5513 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S278046AbRJ0IlU>;
	Sat, 27 Oct 2001 04:41:20 -0400
Date: Sat, 27 Oct 2001 10:40:59 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Anuradha Ratnaweera <anuradha@gnu.org>
cc: "Jeffrey H. Ingber" <jhingber@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: Other computers HIGHLY degrading network performance (DoS?)
In-Reply-To: <20011027093729.B2651@bee.lk>
Message-ID: <Pine.LNX.4.21.0110271035440.3272-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2001, Anuradha Ratnaweera wrote:

> > > Just found out that this is _not_ a problem of the "download accelerator", but
> > > something to do with queuing algorithm of the router.  Even a normal wget
> > > process or a big mail has a big impart on the network.  Hopefully an iptables
> > > firewall would solve the problem.
> > 
> > I'd advice you to seriously look over your network, are you 100% sure you
> > don't have a duplex-issue anywhere?
> 
> I will double check.  I wonder if this is the cause, because the network is 100
> Mbps, but the router is switching only at 64kbps.

Our network almost died when someone changed the duplex in the switch
here...

> > I've been running linuxrouters for quite a while and right now I have a few
> > linuxrouters routing 100Mbit/s internetconnections. We have never had any
> > problems like the one you describe so my first guess would be that you have a
> > duplexproblem, probably between the linuxrouter and the switch it's connected
> > to on the inside, that's usually where it's located.
> 
> We have a hub, and not a switch.  Can this be the reason?  BTW, how come that a
> duplex issue can result in such huge degradations?

If you are trying to run full-duplex against the hub it till completely
kill the performance of the entire hub, been there, done that. When I did
that one I could only push 5-50kB/s through the hub.

> > I seriously doubt that this a problem with the networking in linux.
> 
> Not in linux, may be the way they have _used_ linux on the router ;-)

Hehe, I think you'll have to have quite weird QoS rules to manage to do
something like this :)

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279767AbRJ0DiZ>; Fri, 26 Oct 2001 23:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279774AbRJ0DiL>; Fri, 26 Oct 2001 23:38:11 -0400
Received: from queen.bee.lk ([203.143.12.182]:21121 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S279767AbRJ0DiA>;
	Fri, 26 Oct 2001 23:38:00 -0400
Date: Sat, 27 Oct 2001 09:37:29 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Anuradha Ratnaweera <anuradha@gnu.org>,
        "Jeffrey H. Ingber" <jhingber@ix.netcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Other computers HIGHLY degrading network performance (DoS?)
Message-ID: <20011027093729.B2651@bee.lk>
In-Reply-To: <20011026101313.A18310@bee.lk> <Pine.LNX.4.21.0110261555450.8307-100000@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0110261555450.8307-100000@tux.rsn.bth.se>; from gandalf@wlug.westbo.se on Fri, Oct 26, 2001 at 04:01:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 04:01:29PM +0200, Martin Josefsson wrote:
> On Fri, 26 Oct 2001, Anuradha Ratnaweera wrote:
> 
> > > One machine begins an intensive downloading job.  How can this degrade the
> > > network performance even for ICMP packets between another machine and the
> > > router?  Notice that this can't be collitions because the download goes at
> > > 64kbps and the local network is 100 Mbps.  Something funny is going on to
> > > stop other people's packets.
> > 
> > Just found out that this is _not_ a problem of the "download accelerator", but
> > something to do with queuing algorithm of the router.  Even a normal wget
> > process or a big mail has a big impart on the network.  Hopefully an iptables
> > firewall would solve the problem.
> 
> I'd advice you to seriously look over your network, are you 100% sure you
> don't have a duplex-issue anywhere?

I will double check.  I wonder if this is the cause, because the network is 100
Mbps, but the router is switching only at 64kbps.

> I've been running linuxrouters for quite a while and right now I have a few
> linuxrouters routing 100Mbit/s internetconnections. We have never had any
> problems like the one you describe so my first guess would be that you have a
> duplexproblem, probably between the linuxrouter and the switch it's connected
> to on the inside, that's usually where it's located.

We have a hub, and not a switch.  Can this be the reason?  BTW, how come that a
duplex issue can result in such huge degradations?

> I seriously doubt that this a problem with the networking in linux.

Not in linux, may be the way they have _used_ linux on the router ;-)

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.13)

[FORTRAN] will persist for some time -- probably for at least the next decade.
		-- T. Cheatham


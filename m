Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278492AbRJZOCF>; Fri, 26 Oct 2001 10:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278475AbRJZOB4>; Fri, 26 Oct 2001 10:01:56 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:45031 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S278464AbRJZOBp>;
	Fri, 26 Oct 2001 10:01:45 -0400
Date: Fri, 26 Oct 2001 16:01:29 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Anuradha Ratnaweera <anuradha@gnu.org>
cc: "Jeffrey H. Ingber" <jhingber@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: Other computers HIGHLY degrading network performance (DoS?)
In-Reply-To: <20011026101313.A18310@bee.lk>
Message-ID: <Pine.LNX.4.21.0110261555450.8307-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2001, Anuradha Ratnaweera wrote:

> > One machine begins an intensive downloading job.  How can this degrade the
> > network performance even for ICMP packets between another machine and the
> > router?  Notice that this can't be collitions because the download goes at
> > 64kbps and the local network is 100 Mbps.  Something funny is going on to
> > stop other people's packets.
> 
> Just found out that this is _not_ a problem of the "download accelerator", but
> something to do with queuing algorithm of the router.  Even a normal wget
> process or a big mail has a big impart on the network.  Hopefully an iptables
> firewall would solve the problem.

I'd advice you to seriously look over your network, are you 100% sure you
don't have a duplex-issue anywhere?

I've been running linuxrouters for quite a while and right now I have a few
linuxrouters routing 100Mbit/s internetconnections. We have never had any
problems like the one you describe so my first guess would be that you
have a duplexproblem, probably between the linuxrouter and the switch it's
connected to on the inside, that's usually where it's located. Or maybe
between some switches or something but do look into this. I seriously
doubt that this a problem with the networking in linux.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.


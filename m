Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130984AbRAISgn>; Tue, 9 Jan 2001 13:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130902AbRAISgY>; Tue, 9 Jan 2001 13:36:24 -0500
Received: from smtpgw.bnl.gov ([130.199.3.16]:2060 "EHLO smtpgw.sec.bnl.local")
	by vger.kernel.org with ESMTP id <S129792AbRAISgN>;
	Tue, 9 Jan 2001 13:36:13 -0500
Date: Tue, 9 Jan 2001 13:35:21 -0500
From: Tim Sailer <sailer@bnl.gov>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org, jfung@bnl.gov
Subject: Re: Network Performance?
Message-ID: <20010109133521.C32135@bnl.gov>
In-Reply-To: <20010109085555.A28548@bnl.gov> <Pine.LNX.4.21.0101091748270.952-100000@tux.rsn.hk-r.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0101091748270.952-100000@tux.rsn.hk-r.se>; from gandalf@wlug.westbo.se on Tue, Jan 09, 2001 at 05:52:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 05:52:34PM +0100, Martin Josefsson wrote:
> On Tue, 9 Jan 2001, Tim Sailer wrote:
> 
> > On Mon, Jan 08, 2001 at 07:07:18PM +0100, Erik Mouw wrote:
> > > I had similar problems two weeks ago. Turned out the connection between
> > > two switches: one of them was hard wired to 100Mbit/s full duplex, the
> > > other one to 100Mbit/s half duplex. Just to rule out the obvious...
> > 
> > We check that as the first thing. Both are set the same. No collisions
> > out of the ordinary.
> 
> Are you using netfilter? And if so, does netfilter support window-scaling

Nope. We have it stripped down bare at this point to try to pinpoint
the problem.

Tim

> without the tcp-window-tracking patch?
> 
> /Martin

-- 
Tim Sailer <sailer@bnl.gov> Cyber Security Operations
Brookhaven National Laboratory  (631) 344-3001
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131512AbRAIQw6>; Tue, 9 Jan 2001 11:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131224AbRAIQws>; Tue, 9 Jan 2001 11:52:48 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:36992 "EHLO tux.rsn.hk-r.se")
	by vger.kernel.org with ESMTP id <S130431AbRAIQwg>;
	Tue, 9 Jan 2001 11:52:36 -0500
Date: Tue, 9 Jan 2001 17:52:34 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Tim Sailer <sailer@bnl.gov>
cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org, jfung@bnl.gov
Subject: Re: Network Performance?
In-Reply-To: <20010109085555.A28548@bnl.gov>
Message-ID: <Pine.LNX.4.21.0101091748270.952-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Tim Sailer wrote:

> On Mon, Jan 08, 2001 at 07:07:18PM +0100, Erik Mouw wrote:
> > I had similar problems two weeks ago. Turned out the connection between
> > two switches: one of them was hard wired to 100Mbit/s full duplex, the
> > other one to 100Mbit/s half duplex. Just to rule out the obvious...
> 
> We check that as the first thing. Both are set the same. No collisions
> out of the ordinary.

Are you using netfilter? And if so, does netfilter support window-scaling
without the tcp-window-tracking patch?

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

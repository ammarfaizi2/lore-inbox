Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153981-13684>; Thu, 7 Jan 1999 15:20:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1459 "EHLO atrey.karlin.mff.cuni.cz" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <160317-13684>; Thu, 7 Jan 1999 05:46:06 -0500
Message-ID: <19990107140917.23736@atrey.karlin.mff.cuni.cz>
Date: Thu, 7 Jan 1999 14:09:17 +0100
From: Pavel Machek <pavel@atrey.karlin.mff.cuni.cz>
To: Kurt Garloff <K.Garloff@ping.de>
Cc: "B. James Phillippe" <bryan@terran.org>, Linux kernel list <linux-kernel@vger.rutgers.edu>
Subject: Re: [PATCH] HZ change for ix86
References: <19990105094830.A17862@kg1.ping.de> <Pine.LNX.4.04.9901052119090.19960-100000@earth.terran.org> <19990106102908.A27572@kg1.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84
In-Reply-To: <19990106102908.A27572@kg1.ping.de>; from Kurt Garloff on Wed, Jan 06, 1999 at 10:29:08AM +0100
Sender: owner-linux-kernel@vger.rutgers.edu

Hi!

> > I don't know anything about it (and my box is an Alpha for which HZ is
> > 1024), but, one ignorant proposal: would it perhaps be worthwhile to have
> > the HZ value higher for faster (x86) systems based on the target picked in
> > make config?  Say, your 400 for Pentium+ and 100 for 486 or lower..?
> 
> Yes, I think this would be a good idea.
> No time to code it into the CONFIG files, right now, though ...
> If Linus tells me: "Hey, do it, it will be integrated then!" I will have
> time, of course. 

You should _not_ need to increase HZ. But there've always been obscure
"feature" in scheduler, and increased HZ work around it.

								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

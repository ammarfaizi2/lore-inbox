Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154889-662>; Thu, 8 Oct 1998 21:55:55 -0400
Received: from caffeine.ix.net.nz ([203.97.100.28]:2005 "EHLO caffeine.ix.net.nz" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154999-662>; Thu, 8 Oct 1998 19:11:08 -0400
Date: Fri, 9 Oct 1998 14:59:08 +1300
From: Chris Wedgwood <chris@cybernet.co.nz>
To: Feuer <feuer@mail.his.com>
Cc: David Feuer <david@feuer.his.com>, linux-kernel@vger.rutgers.edu
Subject: Re: network nicety
Message-ID: <19981009145908.A7171@caffeine.ix.net.nz>
References: <19981008144015.B1053@caffeine.ix.net.nz> <Pine.BSI.4.05L.9810081225270.5574-100000@mail.his.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.94.5i
In-Reply-To: <Pine.BSI.4.05L.9810081225270.5574-100000@mail.his.com>; from Feuer on Thu, Oct 08, 1998 at 12:27:52PM -0400
X-No-Archive: Yes
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, Oct 08, 1998 at 12:27:52PM -0400, Feuer wrote:

> How about telling me how, where, etc.

It depends on exactly what you want to do... and what you want to
achieve.

If your on a dial-up to an ISP somewhere, and you want better telnet
throughput at the cost of ftp throughput, chances are - you can't do
much at all, because the changes need to be done at the ISP end.

For QoS stuff, CONFIG_NET_SCHED=Y, get Alexy's ip-route and other
stuff from ftp://ftp.inr.ac.ru/ip-routing/ (as mentioned in the docs
for CONFIG_NET_SCHED) and read up on the relevant papers...
http://www-nrg.ee.lbl.gov/floyd/ is probably one place to start,
especially for CBQ which is currently occupying much of my time.

Note, this is all very much more complicated than it first appears,
there is much science and math involved to truly understand much of
what goes on.

> You are calling spam blockers rude while you are sending spam? By
> the way, I don't want to see anything from you or anything related
> to you in my mailbox.  Any such action will be considered a
> denial-of-service attack on my system.

Don't be an obnoxious little prick. Where or when did I say I was
sending out spam?




-cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

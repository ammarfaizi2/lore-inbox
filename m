Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154565-8316>; Wed, 9 Sep 1998 17:12:47 -0400
Received: from caffeine.ix.net.nz ([203.97.100.28]:4647 "EHLO caffeine.ix.net.nz" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154524-8316>; Wed, 9 Sep 1998 15:58:01 -0400
Date: Thu, 10 Sep 1998 10:33:44 +1200
From: Chris Wedgwood <chris@cybernet.co.nz>
To: linux-kernel@vger.rutgers.edu
Subject: Re: Very poor TCP/SACK performance
Message-ID: <19980910103344.A16713@caffeine.ix.net.nz>
References: <Pine.LNX.4.02.9809062347430.3952-100000@jeffd.i2k.net> <19980908232117.A859@math.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.94.5i
In-Reply-To: <19980908232117.A859@math.fu-berlin.de>; from Felix von Leitner on Tue, Sep 08, 1998 at 11:21:17PM +0200
X-No-Archive: Yes
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, Sep 08, 1998 at 11:21:17PM +0200, Felix von Leitner wrote:

> Why is Linux using SACK, anyway? Stevens refers to it like "yeah,
> the BSD people implemented it once, but it didn't work so it was
> discarded and is now obsolete".

I think the context of Stevens probably refers to RFC1072, "TCP
Extensions for Long-Delay Paths", section 3.1. This is dated October
1988, some ten years old.

RFC2018 presumably obsoletes this part, and it looks to me like the
more modern SACK description doesn't fit with the earlier one. This
one is October 1996, not so old.

> And, you know, if Stevens says so, I'd be tempted to just accept
> this as God given and be done with it.  What was the reason to add
> SACK support to Linux?  Almost no system under the sun seems to
> support it, anyway. Right?

S. Floyd et al probably know more about SACK than Stevens and have
done recent (5 years or so) research in this area.

http://www-nrg.ee.lbl.gov/floyd/sacks.html has more details and
recent research efforts which tend to indicate SACK is a way cool
thing that will prevent hair loss reduce global warming.



-Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html

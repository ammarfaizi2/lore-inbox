Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153873-8316>; Thu, 10 Sep 1998 23:54:14 -0400
Received: from the-twist.crosslink.net ([206.246.124.74]:29261 "HELO the-twist.crosslink.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <154775-8316>; Thu, 10 Sep 1998 23:34:14 -0400
From: shields@crosslink.net (Michael Shields)
Message-Id: <g667evgon0.fsf@aluminum.crosslink.net>
Mail-Copies-To: never
To: Jamie Lokier <lkd@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: GPS Leap Second Scheduled!
References: <19980910073422.A13283@tantalophile.demon.co.uk>
Date: 11 Sep 1998 06:18:10 +0000
In-Reply-To: Jamie Lokier's message of "Thu, 10 Sep 1998 07:34:22 +0100"
X-Mailer: Gnus v5.6.42/Emacs 19.34
Sender: owner-linux-kernel@vger.rutgers.edu

In article <19980910073422.A13283@tantalophile.demon.co.uk>,
Jamie Lokier <lkd@tantalophile.demon.co.uk> wrote:
> On Wed, Sep 09, 1998 at 09:35:59AM -0700, David Lang wrote:
> > I am probably missing something, but can't you just ignore the leap second
> > until you discover that the time is 1 sec off and then use the normal NTP
> > procedure to get back to the exact time
> 
> Until the NTP procedure discovers and corrects this (a few minutes, plus
> correction time), anything that expects synchronised time between
> machines can go wrong.

NTP has the capability to know in advance that a leap second is
scheduled and act upon that at the correct time.

Check your logs the next time a leap second happens; xntpd does it.
-- 
Shields, CrossLink.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRG0VaG>; Fri, 27 Jul 2001 17:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264461AbRG0V34>; Fri, 27 Jul 2001 17:29:56 -0400
Received: from smtp1.bignet.net ([64.79.64.13]:54287 "EHLO smtp1.bignet.net")
	by vger.kernel.org with ESMTP id <S264244AbRG0V3q>;
	Fri, 27 Jul 2001 17:29:46 -0400
Date: Fri, 27 Jul 2001 17:27:34 -0400 (EDT)
From: "Joshua M. Thompson" <om@bignet.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Subtleties of the 0.0.0.0 netmask (inet_ifa_match)
In-Reply-To: <200107271906.XAA24733@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0107271724470.26725-100000@darkstar.bignet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > Can an IP address be on every subnet (i.e. is 10.1.1.1 prefix 0 on every
> > subnet)?
>
> Of course. Why not? This means that 10.1.1.1 is address of this
> interface and all the rest of internet is attached to this interface directly.

Which is actually used by some routing hardware. Ascend Pipelines have a
mode ("Proxy Mode=Always") in which the router answers any ARP request for
off-net IPs with its own MAC address. The idea then is to configure all
your machines to assume the entire Internet is on your local subnet and
the router will pick up the packets destined for the outside world
automatically. Kinda silly really but it does happen.

-- 
Head Developer           | "...and we have C(n) = (n (n + 1))/ 2. Easy as pie.
Big Net, Inc.            |  Actually easier, Pi = Sum 8 / ((4n + 1)(4n + 3))."
                         |                   - Donald E. KNUTH


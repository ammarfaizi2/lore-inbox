Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130079AbRBDWWU>; Sun, 4 Feb 2001 17:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131064AbRBDWWB>; Sun, 4 Feb 2001 17:22:01 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:15090 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S130079AbRBDWVw>; Sun, 4 Feb 2001 17:21:52 -0500
Date: Sun, 4 Feb 2001 22:21:39 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
To: Jamie Lokier <ln@tantalophile.demon.co.uk>
cc: Andi Kleen <ak@muc.de>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        John Fremlin <vii@altern.org>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>, <paulus@linuxcare.com>,
        <linux-ppp@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: Re: [PATCH] dynamic IP support for 2.4.0 (SIOCKILLADDR)
In-Reply-To: <20010129193136.A11035@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.30.0102042218590.3256-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Jamie Lokier wrote:

> Unfortunately getting the same IP is rare now, so I've been toying with
> running a PPP tunnel through a fixed host out on the net.  The tunnel
> would be dropped and recreated with each new connection.  My local link
> IP would change, but the tunnel IP would not so connections to other
> places, ssh etc. would all be from the tunnel IP.

ciped is great for this.  I use it to tunnel ssh from my home dialup
to work.  Very stable, and with cipe's shared keys, there's nothing
too taxing about setting it up.

I just have a call to /etc/init.d/ciped restart in my ppp up script.

freeswan was another way I looked at , but ip/sec was horrible at
the time and didn't (maybe still doesn't) deal with dynamic ip
assignment nicely.

Cheers,

Mark

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271677AbRIGKch>; Fri, 7 Sep 2001 06:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271682AbRIGKca>; Fri, 7 Sep 2001 06:32:30 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:41709 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S271677AbRIGKcP>;
	Fri, 7 Sep 2001 06:32:15 -0400
Date: Fri, 7 Sep 2001 12:31:17 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Kain <kain@kain.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: what ever happened to fastpath routing?
In-Reply-To: <20010907041723.A28390@noir.kain.org>
Message-ID: <Pine.LNX.4.21.0109071223270.15414-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2001, Kain wrote:

> Sorry if I posted this twice.. Email for me has been screwed for most of Sep. 6 and some of Sep. 7.
> 
> What ever happened to fastpath routing in the 2.4 Kernel?  I still see the API
> there, but the only driver I see implementing it is dummy :(

I don't know why the support for fastrouting was removed from the
tulip-driver (the only real driver I think ever had it).

If you are interested in a tulip-driver that has excellent performance
(even without fastrouting) and has support for fastrouting take a look at
this:

ftp://robur.slu.se/pub/Linux/net-development/tulip-ss010402-poll.tar.gz

this driver can route over 200k pps _without_ fastrouting on a pII 350.
(this is obvious with more than two interfaces or with traffic in both
directions)

This driver is both irq-driven and polling, it polls at high loads.

/Martin


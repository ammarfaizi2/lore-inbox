Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273857AbRJDLuT>; Thu, 4 Oct 2001 07:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273796AbRJDLuJ>; Thu, 4 Oct 2001 07:50:09 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:41657 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S273857AbRJDLtv>;
	Thu, 4 Oct 2001 07:49:51 -0400
Date: Thu, 4 Oct 2001 07:47:26 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ben Greear <greearb@candelatech.com>
cc: Simon Kirby <sim@netnation.com>, Ingo Molnar <mingo@elte.hu>,
        <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BBC05EC.AA9BFB4F@candelatech.com>
Message-ID: <Pine.GSO.4.30.0110040742191.9341-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Ben Greear wrote:

> The tulip driver only started working for my DLINK 4-port NIC after
> about 2.4.8, and last I checked the ZYNX 4-port still refuses to work,
> so I wouldn't consider it a paradigm of stability and grace quite yet.

The tests in www.cyberus.ca/~hadi/247-res/ were done with 4-port znyx
cards using 2.4.7.
What kind of problems are you having? Maybe i can help.

> Regardless of that, it is often impossible to trade NICS (think
> built-in 1U servers), and claiming to only work correctly on certain
> hardware (and potentially lock up hard on other hardware) is a pretty
> sorry state of affairs...

My point is that the API exists. Driver owners could use it; this
discussion seems to have at least helped to point in the existence of the
API. Alexey had the hardware flow control in there since 2.1.x .., us
that at least. In my opinion, Ingos patch is radical enough to be allowed
in when we are approaching stability. And it is a lazy way of solving the
problem

cheers,
jamal


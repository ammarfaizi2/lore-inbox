Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292422AbSCDP4k>; Mon, 4 Mar 2002 10:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292399AbSCDP4a>; Mon, 4 Mar 2002 10:56:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52748 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292390AbSCDP4W>;
	Mon, 4 Mar 2002 10:56:22 -0500
Message-ID: <3C83993A.94FE655E@mandrakesoft.com>
Date: Mon, 04 Mar 2002 10:56:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "David S. Miller" <davem@redhat.com>, linux-net@vger.kernel.org
Subject: Re: [BETA-0.94] Fifth test release of Tigon3 driver
In-Reply-To: <20020304.041252.13772021.davem@redhat.com> <20020304164453.A27587@stud.ntnu.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Langås wrote:
> 
> David S. Miller:
> > How does this thing perform for people?  In particular lmbench
> > 'bw_tcp' and 'lat_tcp' numbers over gigabit on beefy hardware are
> > considered very interesting...
> 
> Ok, here I am again; doing some benchmarking :)
> 
> (all this is done with same hardware as before, and your tg3 v0.94 driver in
> both ends):
> test8:/usr/src/LMbench/bin/i686-pc-linux-gnu# ./bw_tcp 129.241.56.160
> initial bandwidth measurement: move=10485760, usecs=117352: 89.35 MB/sec
> move=693633024, XFERSIZE=65536
> Socket bandwidth using 129.241.56.160: 104.73 MB/sec
> 
> test8:/usr/src/LMbench/bin/i686-pc-linux-gnu# ./lat_tcp 129.241.56.160
> TCP latency using 129.241.56.160: 100.0089 microseconds
> 
> Do you want any more benchmark; just say so :)

I am always interested in more benchmarks, never ask this question :):)

A comparison between bcm5700 and tg3 would be interesting, for each new
release, if you were willing to do that.

And, what MTU are you using?  You may have answered this earlier and I
forgot :)  If you -are- on a gigabit network, then you [currently] must
manually enable an MTU of 9000 (jumbo frames).

	Jeff



-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.

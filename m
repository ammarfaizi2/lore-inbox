Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136750AbRASCI7>; Thu, 18 Jan 2001 21:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136720AbRASCIi>; Thu, 18 Jan 2001 21:08:38 -0500
Received: from Cantor.suse.de ([194.112.123.193]:36370 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136222AbRASCI1>;
	Thu, 18 Jan 2001 21:08:27 -0500
Date: Fri, 19 Jan 2001 03:08:25 +0100
From: Andi Kleen <ak@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.1pre8 slowdown on dbench tests
Message-ID: <20010119030825.A8011@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0101181449240.4124-100000@freak.distro.conectiva> <20010119011629.C32087@athlon.random> <20010119024023.B18209@suse.de> <20010119024610.A7573@gruyere.muc.suse.de> <20010119024745.G18209@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010119024745.G18209@suse.de>; from axboe@suse.de on Fri, Jan 19, 2001 at 02:47:45AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 02:47:45AM +0100, Jens Axboe wrote:
> On Fri, Jan 19 2001, Andi Kleen wrote:
> > > Yes I agree, that values should probably be tweaked a bit. I'll
> > > try and squeeze some testing in to generate the best possible
> > > values.
> > 
> > Please also add a sysctl. I always feel uncomfortable with such hardcoded
> > heuristics. There tends to be always another workload where the heuristic
> > fails and manual tuning is useful. 
> 
> Sure, we can do that. But it should only really make a difference
> for low memory machines, otherwise the numbers wouldn't change
> so much. So the limits are not really that important, and only
> need to be in the ball park.

Shouldn't it more depend on the bandwidth/latency of the IO device? 



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

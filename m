Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264572AbRFTTI7>; Wed, 20 Jun 2001 15:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264573AbRFTTIt>; Wed, 20 Jun 2001 15:08:49 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:14351 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S264572AbRFTTIf>;
	Wed, 20 Jun 2001 15:08:35 -0400
Date: Wed, 20 Jun 2001 13:05:10 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bert hubert <ahu@ds9a.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010620130510.A31012@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15CR1f-0006Wh-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 08:18:59PM +0100, Alan Cox wrote:
> There I disagree. Threads introduce parallelism that the majority of user
> space programmers have trouble getting right (not that C is helpful here).

I think it depends on the application. In the RT space the concept
	Do this every millisecond starting now
	Do this every 500 us starting in 30 microseconds
is pretty clear and simple.

> A threaded program has a set of extremely complex hard to repeat timing based
> behaviour dependancies. An unthreaded app almost always does the same thing on
> the same input. From a verification and coverage point of view that is 
> incredibly important.

Depends on the design. I'm sure you've seen some impressively obscure examples of the
"do everything in an event loop" style of programming that is common in embedded.

To me this is like the arguments people used to have over recursion and the answer is
the same:

	Bad programmers can make any programming construct worse


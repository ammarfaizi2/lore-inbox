Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270818AbRHXDRd>; Thu, 23 Aug 2001 23:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270819AbRHXDRY>; Thu, 23 Aug 2001 23:17:24 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:17422 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S270818AbRHXDRP>;
	Thu, 23 Aug 2001 23:17:15 -0400
Date: Thu, 23 Aug 2001 21:13:17 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: kfree safe in interrupt context?
Message-ID: <20010823211316.A5916@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15YR0Y-0007fD-00@localhost>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2001 at 09:44:45PM +1000, Rusty Russell wrote:
> In message <20010817211406.A21326@hq2> you write:
> > Seems like calling kfree from interrupt context should
> > be ok, but is it? 
> > If it is safe, is this considered a good thing  or not?
> 
> Yes, and it logically has to be, as kmalloc(..., GFP_ATOMIC) is safe
> from interrupt context.
> 
> The network code does this all the time, for example.
> 
> Hope that helps,

It does, but Alan answered first and also much more
eloquently. -)






Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUHAC4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUHAC4R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 22:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUHAC4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 22:56:17 -0400
Received: from waste.org ([209.173.204.2]:36066 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264919AbUHAC4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 22:56:16 -0400
Date: Sat, 31 Jul 2004 21:55:38 -0500
From: Matt Mackall <mpm@selenic.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: jackit-devel <jackit-devel@lists.sourceforge.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Statistical methods for latency profiling
Message-ID: <20040801025538.GY5414@waste.org>
References: <1091251357.1677.116.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091251357.1677.116.camel@mindpipe>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 01:22:37AM -0400, Lee Revell wrote:
> Hey,
> 
> Recently Ingo Molnar asked in one of the voluntary-preempt threads for
> the minimum and average scheduling delay reported by jackd.  JACK does
> not currently maintain these statistics.
> 
> I realized that the distribution of maximum latencies reported on each
> process cycle is fairly normally distributed.

This is not at all what I would expect. Instead, I'd expect to see
something like a gamma distribution, where we have everything
clustered down close to zero, but with a very long tail in the
positive direction falling off exponentially and obviously a hard
limit on the other side..

-- 
Mathematics is the supreme nostalgia of our time.

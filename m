Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUHADXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUHADXp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 23:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUHADXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 23:23:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28094 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265060AbUHADXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 23:23:42 -0400
Subject: Re: [Jackit-devel] Re: Statistical methods for latency profiling
From: Lee Revell <rlrevell@joe-job.com>
To: Matt Mackall <mpm@selenic.com>
Cc: jackit-devel <jackit-devel@lists.sourceforge.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040801025538.GY5414@waste.org>
References: <1091251357.1677.116.camel@mindpipe>
	 <20040801025538.GY5414@waste.org>
Content-Type: text/plain
Message-Id: <1091330650.20819.163.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 23:24:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 22:55, Matt Mackall wrote:
> On Sat, Jul 31, 2004 at 01:22:37AM -0400, Lee Revell wrote:
> > Hey,
> > 
> > Recently Ingo Molnar asked in one of the voluntary-preempt threads for
> > the minimum and average scheduling delay reported by jackd.  JACK does
> > not currently maintain these statistics.
> > 
> > I realized that the distribution of maximum latencies reported on each
> > process cycle is fairly normally distributed.
> 
> This is not at all what I would expect. Instead, I'd expect to see
> something like a gamma distribution, where we have everything
> clustered down close to zero, but with a very long tail in the
> positive direction falling off exponentially and obviously a hard
> limit on the other side..

Right, it is a lot closer to a gamma distribution.  It's been years
since I have used any of this, and I took stat for psych majors, vs stat
for engineers.  I was a lot more interested in playing Doom at the
time...

This looks interesting:

http://www.itl.nist.gov/div898/handbook/eda/section3/ppccplot.htm
http://www.itl.nist.gov/div898/handbook/eda/section4/eda4291.htm

I will have some numbers soon.

Lee






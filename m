Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267793AbUHUUf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267793AbUHUUf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267797AbUHUUf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:35:56 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:53647 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267793AbUHUUfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:35:54 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.8.1-mm3
Date: Sat, 21 Aug 2004 16:35:45 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <200408211559.41655.jbarnes@engr.sgi.com> <20040821202435.GA1510@holomorphy.com>
In-Reply-To: <20040821202435.GA1510@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408211635.46227.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 21, 2004 4:24 pm, William Lee Irwin III wrote:
> Yet this criterion involves no performance metric; if it were a
> benchmark it would quantify performance in a meaningful, reproducible,
> and cross-system comparable way. AFAICT it's just being used as a
> stress test for the dcache RCU issue.

Sorry, I should have been clearer, I was only disagreeing with the last part: 
"There is also precisely zero relevance the benchmark has to anything real 
users would do."  Making kernbench run fast isn't a priority, but making sure 
it doesn't run slow and hurt other apps is important, so in that sense it's a 
useful benchmark, even if we're just using it as a load like you say above.

> On Sat, Aug 21, 2004 at 03:59:41PM -0400, Jesse Barnes wrote:
> > Yep, I'm very excited about this.  It makes working with such systems to
> > improve other things infinitely easier (i.e. possible).
>
> Stress test again...

Huh?  I guess booting on a machine this big is something of a stress test. :)

> On Sat, Aug 21, 2004 at 03:59:41PM -0400, Jesse Barnes wrote:
> > Well, this isn't a very good benchmark for discovering things that we
> > don't already know (e.g. dcache and RCU issues).  Now that things appear
> > to be working however, we can start doing more realistic benchmarks.
>
> I'll be happy to see those happen instead of kernel compiles. =)

Yep, me too (though kernbench *is* frighteningly easy to setup and run :).

> I can take it for a spin here to make sure it does the right thing.

Ok, thanks.

Jesse

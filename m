Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbTI1AoM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 20:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTI1AoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 20:44:12 -0400
Received: from tibor.swiftdsl.com.au ([202.154.92.226]:10379 "EHLO
	tibor.swiftdsl.com.au") by vger.kernel.org with ESMTP
	id S262286AbTI1AoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 20:44:10 -0400
Date: Sun, 28 Sep 2003 10:40:47 +1000 (EST)
From: Jason Lewis <jason@dickson.st>
X-X-Sender: jason@car.swiftel.com.au
To: Roger Luethi <rl@hellgate.ch>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.90-test5] kernel shits itself with 48mb ram under
 moderate load
In-Reply-To: <20030927172639.GA19176@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.53.0309281038430.1076@car.swiftel.com.au>
References: <Pine.LNX.4.53.0309280116450.336@car.swiftel.com.au>
 <20030927172639.GA19176@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

Thanks for your reply.

I realised my swap space was version 0, and 2.6 doesn't support it, so it
wasn't enabling swap.

Problem solved.

Thanks,

Jason

On Sat, 27 Sep 2003, Roger Luethi wrote:

> On Sun, 28 Sep 2003 01:26:34 +1000, Jason Lewis wrote:
> > I seem to be experiencing some problems with it. boot and load X ok, but
> > as soon as I try and do anything interesting in X, like run xchat, or
> > apt-get update, the system grings to a halt. the load goes through the
> > roof, and the hdd starts grinding away madly.
> >
> > But I can run my system quite succesfully under 2.4
> >
> > [...]
> >
> > Script started on Sun 28 Sep 2003 00:56:41 EST
> > procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> > [...]
> >  1  8      0   3360    836   6024    0    0 16404    16 3666  2158  1 13  0 86
> >  1 11      0   3504    828   5888    0    0 14956     4 6185  3344  0 11  0 89
> >  3  9      0   3392    816   6016    0    0  6864     0 3903  2088  0 11  0 89
> >  2 13      0   3464    820   5880    0    0 11148     0 3105  1960  0 12  0 87
> >  0 12      0   3424    816   6008    0    0 19712     0 5519  3184  0 12  0 87
>
>           ^^^^
> Looks like you don't have swap enabled. Are successful 2.4 runs with or
> without swap?
>
> Roger
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>

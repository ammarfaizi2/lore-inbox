Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261500AbSJJNYR>; Thu, 10 Oct 2002 09:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbSJJNYQ>; Thu, 10 Oct 2002 09:24:16 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58382 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261500AbSJJNYP>; Thu, 10 Oct 2002 09:24:15 -0400
Date: Thu, 10 Oct 2002 09:21:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Larry McVoy <lm@bitmover.com>
cc: "David S. Miller" <davem@redhat.com>, mau@oscar.prima.de,
       linux-kernel@vger.kernel.org
Subject: Re: LMbench results for 2.5.40
In-Reply-To: <20021008120700.C7160@work.bitmover.com>
Message-ID: <Pine.LNX.3.96.1021010091430.16520G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Larry McVoy wrote:

> On Tue, Oct 08, 2002 at 02:55:01PM -0400, Bill Davidsen wrote:

> > > FYI.  I don't like it either.
> > 
> > Thank you, that explains some things I've seen in my context switching
> > benchmark as well, which uses a bunch of different services to transfer
> > tiny data from on process to another.
> > 
> > Time for some statistical jiggery-pokery, dust off deviant mean or some
> > such.
> 
> I personally think that you should try a scatter plot and you should
> get something sort of like http://www.bitmover.com/disks/sek.gif which
> is read latency times scatter plotted nicely showing the effect of seeks
> and the effects of rotational delay.  The height of the band is what I'd
> expect to see in the context switch results - there should be an even
> distribution between the min and the max assuming that you can vary the
> pages which get allocated when you run the tests.
> 
> The average is a misleading number, you really want a min/max style number.
> I'd be quite interested if someone were to go off and do this.

Well, I have high and low, I currently report both avg and median values,
and both average and "deviant mean average" compared to the noload case.
The test is almost ready for public release, I just have to finish the
docs. I know, if it was hard to write it should be hard to understand...

*deviant mean average - the average of all data points within one S.D. of
the mean. Average of "the stuff in the middle of the performance range."

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


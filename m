Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbSIWOTk>; Mon, 23 Sep 2002 10:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbSIWOTk>; Mon, 23 Sep 2002 10:19:40 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:12945 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S261744AbSIWOTj>;
	Mon, 23 Sep 2002 10:19:39 -0400
Message-ID: <1032791089.3d8f2431231ac@kolivas.net>
Date: Tue, 24 Sep 2002 00:24:49 +1000
From: Con Kolivas <conman@kolivas.net>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
References: <Pine.LNX.3.95.1020923101125.3233A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020923101125.3233A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Richard B. Johnson" <root@chaos.analogic.com>:

> On Mon, 23 Sep 2002, Ryan Anderson wrote:
> 
> > On Mon, Sep 23, 2002 at 08:30:21PM +1000, Con Kolivas wrote:
> > > Quoting Ingo Molnar <mingo@elte.hu>:
> > > > On Mon, 23 Sep 2002, Con Kolivas wrote:
> > > > 
> > > > how many times are you running each test? You should run them at
> least
> > > > twice (ideally 3 times at least), to establish some sort of
> statistical
> > > > noise measure. Especially IO benchmarks tend to fluctuate very
> heavily
> > > > depending on various things - they are also very dependent on the
> initial
> > > > state - ie. how the pagecache happens to lay out, etc. Ie. a
> meaningful
> > > > measurement result would be something like:
> > > 
> > > Yes you make a very valid point and something I've been stewing over
> privately
> > > for some time. contest runs benchmarks in a fixed order with a "priming"
> compile
> > > to try and get pagecaches etc back to some sort of baseline (I've been
> trying
> > > hard to make the results accurate and repeatable). 
> > 
> > Well, run contest once, discard the results.  Run it 3 more times, and
> > you should have started the second, third and fourth runs with similar
> initial conditions.
> > 
> > Or you could run the contest 3 times, rebooting between each run....
> > (automating that is a little harder, of course.)
> > 
> > IANAS, however.
> > 
> 
> (1)	Obtain statistics from a number of runs.
> (2)	Throw away the smallest and largest.
> (3)	Average whatever remains.
> 
> This works for many "real-world" things because it removes noise-spikes
> that could unfairly poison the average.

That is the system I was considering. I just need to run enough benchmarks to
make this worthwhile though. That means about 5 for each it seems - which may
take me a while. A basic mean will suffice for a measure of central tendency. I
also need to quote some measure of variability. Standard deviation?

Con

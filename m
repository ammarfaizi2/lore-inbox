Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbTBKXCb>; Tue, 11 Feb 2003 18:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTBKXCb>; Tue, 11 Feb 2003 18:02:31 -0500
Received: from mailhost.iprg.nokia.com ([205.226.5.12]:35127 "EHLO
	mailhost.iprg.nokia.com") by vger.kernel.org with ESMTP
	id <S266795AbTBKXC3>; Tue, 11 Feb 2003 18:02:29 -0500
X-mProtect: <200302112312> Nokia Silicon Valley Messaging Protection
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
	2.4.20-ck3 / aa / rmap with contest]
From: Rod Van Meter <Rod.VanMeter@nokia.com>
Reply-To: Rod.VanMeter@nokia.com
To: ext Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@digeo.com>, Nick Piggin <piggin@cyberone.com.au>,
       andrea@suse.de, reiser@namesys.com, jakob@unthought.net,
       david.lang@digitalinsight.com, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <Pine.LNX.4.50L.0302101129530.12742-100000@imladris.surriel.com>
References: <3E47579A.4000700@cyberone.com.au>
	 <20030210080858.GM31401@dualathlon.random>
	 <20030210001921.3a0a5247.akpm@digeo.com>
	 <20030210085649.GO31401@dualathlon.random>
	 <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com>
	 <20030210101539.GS31401@dualathlon.random>
	 <3E4781A2.8070608@cyberone.com.au>
	 <20030210111017.GV31401@dualathlon.random>
	 <3E478C09.6060508@cyberone.com.au>
	 <20030210113923.GY31401@dualathlon.random>
	 <20030210034808.7441d611.akpm@digeo.com> <3E4792B7.5030108@cyberone.com.au>
	 <20030210041245.68665ff6.akpm@digeo.com>
	 <Pine.LNX.4.50L.0302101129530.12742-100000@imladris.surriel.com>
Content-Type: text/plain
Organization: Nokia Networks
Message-Id: <1044990800.13119.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Feb 2003 11:13:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-10 at 05:30, ext Rik van Riel wrote:
> On Mon, 10 Feb 2003, Andrew Morton wrote:
> 
> > Could be that sending out a request which is larger than a track is
> > saving a rev of the disk for some reason.
> 
> I guess disks are optimised for the benchmarks that are
> run by popular PC magazines ...

Yes, absolutely they are (I used to work for one such company that no
longer exists).  However, there's a catch -- the disk drive companies
are optimizing for the test as currently constituted, but the test keeps
changing.  So they're optimizing for version N-1 while the magazine is
publishing N.  Can't help it.  Ever heard of the Nyquist frequency?

> 
> After all, those benchmarks and the sales price are the
> main factors determining sales ;)
> 

Yup.  In general, it's capacity first, then reliability, then
performance.  No, wait, not quite; the FIRST criterion is the ability to
ship when you say you will.  If you make Dell late on shipping a bunch
of machines, you WILL feel the pain.

		--Rod



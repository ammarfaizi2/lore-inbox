Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261291AbSI3TFf>; Mon, 30 Sep 2002 15:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261207AbSI3TF3>; Mon, 30 Sep 2002 15:05:29 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56079 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261301AbSI3TE5>; Mon, 30 Sep 2002 15:04:57 -0400
Date: Mon, 30 Sep 2002 15:02:13 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Matthias Andree <matthias.andree@gmx.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <1033316647.13001.26.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1020930145154.20863G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Sep 2002, Alan Cox wrote:

> On Sun, 2002-09-29 at 16:26, Matthias Andree wrote:
> > I personally have the feeling that 2.2.x performed better than 2.4.x
> > does, but I cannot go figure because I'm using ReiserFS 3.6 file
> 
> On low end boxes the benchmarks I did show later 2.4-rmap beats 2.2. 2.0
> worked suprisingly well (better than pre-rmap 2.4) and as Stephen
> claimed the best code was about 2.1.100, 2.2 then dropped badly from
> that point.

I might have said 2.1.106 (I'm still running that on one box), but that's
the general sweet spot.
 
> Low memory is of course where rmap does best, so the 2.4-rmap v 2.4
> parts of such testing are not actually that useful

In the 2.4-ac vs. 2.4-aa tests I did in the spring, rmap was better on
small memory, -aa was better with large memory and heavy write load. I
expect ioscheduling to address this, and when I get a totally expendable
large machine I'll try 2.5 again.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSHGWci>; Wed, 7 Aug 2002 18:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315806AbSHGWci>; Wed, 7 Aug 2002 18:32:38 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:43024 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315779AbSHGWch>; Wed, 7 Aug 2002 18:32:37 -0400
Date: Wed, 7 Aug 2002 18:30:10 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Steven Cole <elenstev@mesatop.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>,
       Steven Cole <scole@lanl.gov>
Subject: Re: Linux v2.4.19-rc5
In-Reply-To: <1028688882.2376.105.camel@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1020807182523.14463A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Aug 2002, Steven Cole wrote:

> On Tue, 2002-08-06 at 19:09, Bill Davidsen wrote:

> > I assumed that the posted results were apples and apples. That may not be
> 
> Well, maybe Granny Smiths and Red Delicious. The problem with dbench is
> that it checks how well they roll and bounce.  But even that can be
> important sometimes. ;)
> 
> > the case. If this was one kernel tuned for dbench and one for something
> > else, then the information content is pretty low, to me at least. But if
> > it is both tuned or both stock, then I would hope 2.5 would be better. If
> > the text said that and I read past it, I apologise.
> 
> All kernels were stock as patched with no special changes to 
> /proc/sys/vm/bdflush for 2.4.x or to /proc/sys/vm/dirty* for 2.5.x.
> Sorry, I didn't explicitly state that in the initial report.

Actually that was what I was assuming when I noted that the 2.5 appeared
to be slower by a good bit for some high load values of dbench. In a
perfect world the kernel would hit the hardware spped, guess no one is
claiming that until 2.7 ;-)

The initial results from the io scheduler, as posted here, look as if
there will be a way to "take it up another notch" in the future.

Thanks much for the clarification, the data are useful even if they do
show room for improvement in the corner case.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSHGDP0>; Tue, 6 Aug 2002 23:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316728AbSHGDP0>; Tue, 6 Aug 2002 23:15:26 -0400
Received: from mesatop.com ([216.234.213.189]:19211 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S316715AbSHGDPZ>;
	Tue, 6 Aug 2002 23:15:25 -0400
Subject: Re: Linux v2.4.19-rc5
From: Steven Cole <elenstev@mesatop.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>,
       Steven Cole <scole@lanl.gov>
In-Reply-To: <Pine.LNX.3.96.1020806205643.9199C-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1020806205643.9199C-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 06 Aug 2002 20:54:39 -0600
Message-Id: <1028688882.2376.105.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 19:09, Bill Davidsen wrote:
> On Tue, 6 Aug 2002, Rik van Riel wrote:
> 
> > On Mon, 5 Aug 2002, Bill Davidsen wrote:
> > 
> > > > Here are some dbench numbers, from the "for what it's worth" department.
> > >
> > > Call me an optimist, but after all the reliability problems we had win the
> > > 2.5 series, I sort of hoped it would be better in performance, not
> > > increasingly worse. Am I misreading this? Can we fall back to the faster
> > > 2.4 code :-(
> > 
> > Dbench is at its best when half (or more) of the dbench processes
> > are stuck semi-infinitely in __get_request_wait and the others can
> > operate in RAM without ever touching the disk.
> > 
> > In effect, if you want the best dbench throughput you should make
> > the system completely unsuitable for real world applications ;)
> 
> I assumed that the posted results were apples and apples. That may not be

Well, maybe Granny Smiths and Red Delicious. The problem with dbench is
that it checks how well they roll and bounce.  But even that can be
important sometimes. ;)

> the case. If this was one kernel tuned for dbench and one for something
> else, then the information content is pretty low, to me at least. But if
> it is both tuned or both stock, then I would hope 2.5 would be better. If
> the text said that and I read past it, I apologise.

All kernels were stock as patched with no special changes to 
/proc/sys/vm/bdflush for 2.4.x or to /proc/sys/vm/dirty* for 2.5.x.
Sorry, I didn't explicitly state that in the initial report.

Steven


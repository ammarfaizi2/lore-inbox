Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135491AbRDZOdR>; Thu, 26 Apr 2001 10:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135497AbRDZOdH>; Thu, 26 Apr 2001 10:33:07 -0400
Received: from www.wen-online.de ([212.223.88.39]:5127 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135491AbRDZOc6>;
	Thu, 26 Apr 2001 10:32:58 -0400
Date: Thu, 26 Apr 2001 16:32:26 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Ingo Molnar <mingo@elte.hu>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.21.0104261125150.19012-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0104261630240.403-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Rik van Riel wrote:

> On Thu, 26 Apr 2001, Mike Galbraith wrote:
> > On Thu, 26 Apr 2001, Mike Galbraith wrote:
> >
> > > > limit the runtime of refill_inactive_scan(). This is similar to Rik's
> > > > reclaim-limit+aging-tuning patch to linux-mm yesterday. could you try
> > > > Rik's patch with your patch except this jiffies hack, does it still
> > > > achieve the same improvement?
> > >
> > > No.  It livelocked on me with almost all active pages exausted.
> >
> > Misspoke.. I didn't try the two mixed.  Rik's patch livelocked me.
>
> Interesting. The semantics of my patch are practically the same as
> those of the stock kernel ... can you get the stock kernel to
> livelock on you, too ?

Generally no.  Let kswapd continue to run?  Yes, but not always.

	-Mike


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263017AbREaFXh>; Thu, 31 May 2001 01:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263018AbREaFX1>; Thu, 31 May 2001 01:23:27 -0400
Received: from www.wen-online.de ([212.223.88.39]:29959 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263017AbREaFXO>;
	Thu, 31 May 2001 01:23:14 -0400
Date: Thu, 31 May 2001 07:20:21 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rik van Riel <riel@conectiva.com.br>,
        Jonathan Morton <chromi@cyberspace.org>,
        Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Plain 2.4.5 VM
In-Reply-To: <Pine.LNX.4.21.0105301612570.5231-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0105310715560.516-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Marcelo Tosatti wrote:

> On Wed, 30 May 2001, Mike Galbraith wrote:
>
> > On Wed, 30 May 2001, Rik van Riel wrote:
> >
> > > On Wed, 30 May 2001, Marcelo Tosatti wrote:
> > >
> > > > The problem is that we allow _every_ task to age pages on the system
> > > > at the same time --- this is one of the things which is fucking up.
> > >
> > > This should not have any effect on the ratio of cache
> > > reclaiming vs. swapout use, though...
> >
> > It shouldn't.. but when many tasks are aging, it does.
>
> What Rik means is that they are independant problems.

Ok.

>
> > Excluding these guys certainly seems to make a difference.
>
> Sure, those guys are going to "help" kswapd to unmap pte's and allocate
> swap space.
>
> Now even if only kswapd does this job (meaning a sane amount of cache
> reclaims/swapouts), you still have to deal with the reclaim/swapout
> tradeoff.
>
> See?

Yes.

	-Mike


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261546AbRERUZZ>; Fri, 18 May 2001 16:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbRERUZF>; Fri, 18 May 2001 16:25:05 -0400
Received: from www.wen-online.de ([212.223.88.39]:35333 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261546AbRERUY4>;
	Fri, 18 May 2001 16:24:56 -0400
Date: Fri, 18 May 2001 22:24:05 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: Linux 2.4.4-ac10
In-Reply-To: <20010518205843.T806@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.33.0105182218070.387-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2001, Ingo Oeser wrote:

> On Fri, May 18, 2001 at 03:23:03PM -0300, Rik van Riel wrote:
> > On Fri, 18 May 2001, Ingo Oeser wrote:
> >
> > > Rik: Would you take patches for such a tradeoff sysctl?
> >
> > "such a tradeoff" ?
> >
> > While this sounds reasonable, I have to point out that
> > up to now nobody has described exactly WHAT tradeoff
> > they'd like to make tunable and why...
>
> Amount of pages reclaimed from swapout_mm() versus amount of
> pages reclaimed from caches.

I don't know if this'll make sense, but I think this has to
be a ~fuzzy suggestion to the kernel.  There are so many
variables that you can't predict what the kernel will run
into.  For example, with my favorite test, sometimes tasks
do something nasty, like all deciding to do the same things
at once and thereby jerking a _knot_ in the vm's tail.

	-Mike


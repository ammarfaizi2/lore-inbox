Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135463AbRDZOIR>; Thu, 26 Apr 2001 10:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135456AbRDZOH6>; Thu, 26 Apr 2001 10:07:58 -0400
Received: from www.wen-online.de ([212.223.88.39]:13320 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135443AbRDZOHg>;
	Thu, 26 Apr 2001 10:07:36 -0400
Date: Thu, 26 Apr 2001 16:07:02 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.21.0104260526020.2416-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0104261601110.294-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Linus Torvalds wrote:

> On Thu, 26 Apr 2001, Mike Galbraith wrote:
> >
> > 2.4.4.pre7.virgin
> > real    11m33.589s
> > user    7m57.790s
> > sys     0m38.730s
> >
> > 2.4.4.pre7.sillyness
> > real    9m30.336s
> > user    7m55.270s
> > sys     0m38.510s
>
> Well, I actually like parts of this. The "always swap out current mm" one
> looks rather dangerous, and the lastscan jiffy thing is too ugly for
> words,

Compared to my tree of a couple days ago (8m53s) this is fine art ;-)

(snip nice list of things to think about)

> Comments?

If my parser ever comes out of down_trygrok().  I'll put this in
a terminal next to one from Ingo.

	-Mike


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274670AbRIUDVT>; Thu, 20 Sep 2001 23:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274748AbRIUDVJ>; Thu, 20 Sep 2001 23:21:09 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22534 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S274670AbRIUDU7>; Thu, 20 Sep 2001 23:20:59 -0400
Date: Thu, 20 Sep 2001 23:16:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010916204528.6fd48f5b.skraw@ithnet.com>
Message-ID: <Pine.LNX.3.96.1010920231251.26679B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001, Stephan von Krawczynski wrote:


> Thinking again about it, I guess I would prefer a FIFO-list of allocated pages.
> This would allow to "know" the age simply by its position in the list. You
> wouldn't need a timestamp then, and even better it works equally well for
> systems with high vm load and low, because you do not deal with absolute time
> comparisons, but relative.
> That sounds pretty good for me. 

The problem is that when many things effect the optimal ratio of text,
data, buffer and free space a solution which doesn't measure all the
important factors will produce sub-optimal results. Your proposal is
simple and elegant, but I think it's too simple to produce good results.
See my reply to Linus' comments.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


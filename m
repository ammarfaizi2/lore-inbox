Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSIIQI4>; Mon, 9 Sep 2002 12:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSIIQI4>; Mon, 9 Sep 2002 12:08:56 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:56253 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317468AbSIIQIz>;
	Mon, 9 Sep 2002 12:08:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: LMbench2.0 results
Date: Mon, 9 Sep 2002 18:16:11 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0209091035470.1857-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0209091035470.1857-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oRCu-0006pL-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 15:37, Rik van Riel wrote:
> On Sun, 8 Sep 2002, Daniel Phillips wrote:
> 
> > I suspect the overall performance loss on the laptop has more to do with
> > several months of focussing exclusively on the needs of 4-way and higher
> > smp machines.
> 
> Probably true, we're pulling off an indecent number of tricks
> for 4-way and 8-way SMP performance. This overhead shouldn't
> be too bad on UP and 2-way machines, but might easily be a
> percent or so.

Though to be fair, it's smart to concentrate on the high end with a
view to achieving world domination sooner.  And it's a stretch to call
the low end performance 'slow'.

An idea that's looking more and more attractive as time goes by is to
have a global config option that specifies that we want to choose the
simple way of doing things wherever possible, over the enterprise way.
We want this especially for embedded.  On low end processors, it's even
possible that the small way will be faster in some cases than the
enterprise way, due to cache effects.

-- 
Daniel

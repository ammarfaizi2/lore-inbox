Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSIIEYO>; Mon, 9 Sep 2002 00:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSIIEYO>; Mon, 9 Sep 2002 00:24:14 -0400
Received: from dsl-213-023-043-054.arcor-ip.net ([213.23.43.54]:8636 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315748AbSIIEYN>;
	Mon, 9 Sep 2002 00:24:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Subject: Re: LMbench2.0 results
Date: Sun, 8 Sep 2002 22:02:04 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20020907121854.10290.qmail@linuxmail.org> <3D7A2768.E5C85EB@digeo.com>
In-Reply-To: <3D7A2768.E5C85EB@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oGD3-0006lS-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 September 2002 18:20, Andrew Morton wrote:
> Paolo Ciarrocchi wrote:
> > 
> > Hi all,
> > I've just ran lmbench2.0 on my laptop.
> > Here the results (again, 2.5.33 seems to be "slow", I don't know why...)
> > 
> 
> The fork/exec/mmap slowdown is the rmap overhead.  I have some stuff
> which partialy improves it.

It only seems like a big deal if you get out your microscope and focus on
the fork times.  On the other hand, look at the sh times: the rmap setup
time gets lost in the noise.  The latter looks more like reality to me.

I suspect the overall performance loss on the laptop has more to do with
several months of focussing exclusively on the needs of 4-way and higher
smp machines.

-- 
Daniel

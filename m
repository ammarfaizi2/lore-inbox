Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281547AbRKZJu4>; Mon, 26 Nov 2001 04:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281554AbRKZJuq>; Mon, 26 Nov 2001 04:50:46 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:62864 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S281552AbRKZJua>; Mon, 26 Nov 2001 04:50:30 -0500
Subject: Re: Severe Linux 2.4 kernel memory leakage
From: Chris Chabot <chabotc@reviewboard.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111260740260.837-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0111260740260.837-100000@mikeg.weiden.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 26 Nov 2001 10:50:54 +0100
Message-Id: <1006768254.932.0.camel@gandalf.chabotc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After i recieved an email from Peter T. who had the same problem, but
_not_ under 2.4.9 i re-checked, and indeed, the problems dont appear in
kernel versions =< 2.4.9. So in either 2.4.10 or 2.4.11 the memory
leakage was 'introduced'.

My current preminition is that it could be the software raid layer thats
causing the leakage, but it also could be a combination of factors. (see
prev email to Peter T / lkml about the common factors in the 2
situations). On the other hand, i'm willing to try anything ;-)

	-- Chris

On Mon, 2001-11-26 at 07:49, Mike Galbraith wrote:
> On 25 Nov 2001, Chris Chabot wrote:
> 
> > Hi, I have a firewall / file server box which is displaying (severe)
> > memory leakage, presumably by the kernel.
> >
> > The box has ran Redhat 7.1 and 7.2, with plain vanilla linux kernels
> > 2.4.9 upto 2.4.15, in all situations the same problem appeared.
> 
> With 2.4.9 as well?  I have an IKD patch for 2.4.7 which I could
> update to 2.4.9 fairly quickly if you'd like to try memleak on the
> thing.  It might even go in fairly cleanly as is.
> 
> 	-Mike



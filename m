Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267608AbSISNG4>; Thu, 19 Sep 2002 09:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267930AbSISNG4>; Thu, 19 Sep 2002 09:06:56 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:5505 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S267608AbSISNGz>;
	Thu, 19 Sep 2002 09:06:55 -0400
Date: Thu, 19 Sep 2002 15:11:57 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020919131157.GA14938@win.tue.nl>
References: <20020918211547.GA14657@win.tue.nl> <Pine.LNX.4.44.0209190502120.5184-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209190502120.5184-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 05:05:17AM +0200, Ingo Molnar wrote:
> 
> On Wed, 18 Sep 2002, Andries Brouwer wrote:
> 
> > > It doesn't sound like you read the patch at all.
> > 
> > I looked at it and searched for base.c but didnt find it,
> > so concluded that the real problem was not addressed.
> 
> because, as mentioned before, that particular loop i fixed in 2.5.35.

In that case, sorry for complaining about that part - I was
looking at 2.5.33. But now that I look at patch-2.5.35
I don't see any improvement: for_each_task() is now called
for_each_process(), but otherwise base.c is just as quadratic
as it was.

So, why do you think this problem has been fixed?

Andries

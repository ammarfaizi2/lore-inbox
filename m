Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269759AbSISCxG>; Wed, 18 Sep 2002 22:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269762AbSISCxG>; Wed, 18 Sep 2002 22:53:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51404 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S269759AbSISCxG>;
	Wed, 18 Sep 2002 22:53:06 -0400
Date: Thu, 19 Sep 2002 05:05:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918211547.GA14657@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0209190502120.5184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Andries Brouwer wrote:

> > It doesn't sound like you read the patch at all.
> 
> I looked at it and searched for base.c but didnt find it,
> so concluded that the real problem was not addressed.

because, as mentioned before, that particular loop i fixed in 2.5.35.

> > That is actually one of the easiest ways to take out one of my machines
> > while it's running 10K or so tasks, mentioned a bit ago in this thread.
> 
> OK. So we now agree.
> 
> But it looks like your patch doesnt change this? Or did I overlook sth?

yes, you did overlook a number of things.

	Ingo


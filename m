Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132229AbRACPcx>; Wed, 3 Jan 2001 10:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132291AbRACPcn>; Wed, 3 Jan 2001 10:32:43 -0500
Received: from www.wen-online.de ([212.223.88.39]:31240 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S132229AbRACPcg>;
	Wed, 3 Jan 2001 10:32:36 -0500
Date: Wed, 3 Jan 2001 16:02:10 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: scheduling problem?
In-Reply-To: <3A533536.A1723DD6@innominate.de>
Message-ID: <Pine.Linu.4.10.10101031553440.421-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Daniel Phillips wrote:

> Mike Galbraith wrote:
> > 
> > On Wed, 3 Jan 2001, Daniel Phillips wrote:
> > 
> > > Could you try this patch just to see what happens?  It uses semaphores
> > > for the bdflush synchronization instead of banging directly on the task
> > > wait queues.  It's supposed to be a drop-in replacement for the bdflush
> > > wakeup/waitfor mechanism, but who knows, it may have subtly different
> > > behavious in your case.
> > 
> > Semaphore timed out during boot, leaving bdflush as zombie.
> 
> Hmm, how could that happen?  I'm booted and running with that patch
> right now and have beaten on it extensively - it sounds like something
> else is broken.  Or maybe we've already established that - let me read
> the thread again.
> 
> Which semaphore timed out, bdflush_request or bdflush_waiter?

I didn't watch closely (running virgin prerelease).  I can run it again
if you think it's important.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

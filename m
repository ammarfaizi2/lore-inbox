Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSIXGMJ>; Tue, 24 Sep 2002 02:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSIXGMJ>; Tue, 24 Sep 2002 02:12:09 -0400
Received: from dp.samba.org ([66.70.73.150]:12706 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261581AbSIXGMI>;
	Tue, 24 Sep 2002 02:12:08 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: jlnance@intrex.net, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1 
In-reply-to: Your message of "Tue, 24 Sep 2002 07:47:14 +0200."
             <Pine.LNX.4.44.0209240741270.8943-100000@localhost.localdomain> 
Date: Tue, 24 Sep 2002 16:15:37 +1000
Message-Id: <20020924061722.6EFF42C0A9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209240741270.8943-100000@localhost.localdomain> you 
write:
> > And, ironically, using the futex implementation developed on IBM time 8).
> 
> you are right, futexes are really important for all the userspace locking
> primitives and thread-joining. And like basically all core kernel code,
> futexes were a collaborative effort as well:
> 
>  *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
>  *  enough at me, Linus for the original (flawed) idea, Matthew
>  *  Kirkwood for proof-of-concept implementation.

And yourself, Robert Love, Paul Mackerras and Hubertus Franke all
contributed to futexes directly, too.  I wasn't complaining about
credit, I just found the IBM involvement worth noting (in case someone
thought we were onesided).

> there are so many prerequisites to this that it's impossible to list them
> all.

True here, but in general: almost all the order-of-magnitude
scalability jumps in 2.5 can be traced back to you or Andrew Morton.
I wouldn't want a casual reader to miss that fact 8)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

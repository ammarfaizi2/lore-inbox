Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292222AbSCMC5i>; Tue, 12 Mar 2002 21:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292229AbSCMC52>; Tue, 12 Mar 2002 21:57:28 -0500
Received: from [202.135.142.196] ([202.135.142.196]:29962 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S292222AbSCMC5Q>; Tue, 12 Mar 2002 21:57:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: frankeh@watson.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: Your message of "Tue, 12 Mar 2002 09:17:10 -0800."
             <Pine.LNX.4.33.0203120905280.19167-100000@penguin.transmeta.com> 
Date: Wed, 13 Mar 2002 13:57:21 +1100
Message-Id: <E16kyx7-0004CD-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0203120905280.19167-100000@penguin.transmeta.com> you
 write:
> 
> On Tue, 12 Mar 2002, Rusty Russell wrote:
> > > 
> > > You've convinced me.
> > 
> > Damn.  Because now I've been playing with a different approach.
> 
> I don't think your current patch is very useful.

I agree.  But your "Applied" EMail rushed me into posting it.

> It's obviously slower, and while it is an interesting approach for not 
> just lock generation but also for synchronization points, it doesn't seem 
> to actually _buy_ you anything. And since the cookie isn't guaranteed to 
> be unique, you can't actually use it as a synchronization point on its 
> own, but must always still have some shared memory location as a 
> confirmation for whatever the synchronization was.

My original cookie was 128 bits.  ie. unique.

> So: interesting approach, but in its current form pointless as far as I 
> can see.

Yeah, I'm not sure what it's useful for either.  But the code is out
there if someone gets inspired...

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbRE3LPJ>; Wed, 30 May 2001 07:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262734AbRE3LPA>; Wed, 30 May 2001 07:15:00 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:15797 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S262731AbRE3LOw>;
	Wed, 30 May 2001 07:14:52 -0400
Date: Wed, 30 May 2001 07:14:27 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
X-X-Sender: <fxian@tiger>
To: David Howells <dhowells@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.3-ac14 spinlock problem? 
In-Reply-To: <12317.991208196@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0105300713090.29751-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

Actually it happened only once. then I upgrade my kernel to 2.4.5. problem
disappeared. I just hope this maybe a known problem.

Thanks.

Alex


On Wed, 30 May 2001, David Howells wrote:

>
> > I was running something on my Dell dual p3 box (optiplex gx300). my kernel
> > is linux-2.4.3-ac14. I got the following message:
>
> How often did this message occur?
>
> > __rwsem_do_wake(): wait_list unexpectedly empty
> > [4191] c5966f60 = { 00000001 })
> > kenel BUG at rwsem.c:99!
> > invalid operand: 0000
> > CPU:            1
> > EIP:            0010:[<c0236b99>]
> > EFLAGS: 00010282
> > kenel BUG at /usr/src/2.4.3-ac14/include/asm/spinlock.h:104!
> >
> >
> > I upgrade the kernel to 2.4.5, no such problem any more.
>
> I suspect something else corrupted the rw-semaphore structure, but that's very
> hard to prove unless you catch it in the act. If it happens again with any
> frequency, you might want to try turning on rwsem debugging.
>
> David
>

-- 
        Feng Xian
   _o)     .~.      (o_
   /\\     /V\      //\
  _\_V    // \\     V_/_
         /(   )\
          ^^-^^
           ALEX


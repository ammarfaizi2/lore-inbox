Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSGXKra>; Wed, 24 Jul 2002 06:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316953AbSGXKra>; Wed, 24 Jul 2002 06:47:30 -0400
Received: from ns1.systime.ch ([194.147.113.1]:63498 "EHLO mail.systime.ch")
	by vger.kernel.org with ESMTP id <S316951AbSGXKr3>;
	Wed, 24 Jul 2002 06:47:29 -0400
From: "Martin Brulisauer" <martin@uceb.org>
To: Joshua MacDonald <jmacd@namesys.com>
Date: Wed, 24 Jul 2002 12:50:28 +0200
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement: generic_out_cast)
CC: neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Message-ID: <3D3EA294.30758.3567B82@localhost>
In-reply-to: <20020724095656.GB11106@reload.namesys.com>
References: <3D3E75E9.28151.2A7FBB2@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jul 2002, at 13:56, Joshua MacDonald wrote:
> The list code is trivial, but when you have 10 classes of list and no type
> safety between independent list classes or even between the list head and list
> item types, there is a strong possibility you will pass the wrong argument to
> some list routine because there is nothing to stop you.
So it is.

At kernel level nothing will stop me to halt() the cpu, if I realy want 
to. It is important to understand that tools (and all compilers are
just tools) will not enable me to write correct code. 
> 
> I can say a lot of good and bad things about C++, but at least it lets you do
> this kind of thing with type safety and without ugly macros.
> 
Yes. That's absolutely true for C++. But the kernel is implemented 
in C and C is "only" kind of a high-level-assembler language. It is
ment to be open - on purpose. There exist other languages that 
have these kinds of concepts you bring in (I would not use C++ as 
the best example - take OBERON/MODULA or EIFFEL). But these 
languages are not made to implement an operating system 
(remember the reason K&R have specified and implemented C?).

What I realy dislike is the approach to bring in any OO concepts 
into the C language the linux kernel bases on. Keep the code as 
simple and homogenous as possible (or try to rewrite it in OO).

The way I see this discussion is: Every software problem has it's 
proper language to be solved in. And for this, Linus decided it to be 
C.

Regards,
Martin


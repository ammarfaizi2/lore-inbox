Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbSLUSpm>; Sat, 21 Dec 2002 13:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSLUSpm>; Sat, 21 Dec 2002 13:45:42 -0500
Received: from mnh-1-12.mv.com ([207.22.10.44]:42500 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S263276AbSLUSpl>;
	Sat, 21 Dec 2002 13:45:41 -0500
Message-Id: <200212211857.NAA01955@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: John Reiser <jreiser@BitWagon.com>
Cc: linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Julian Seward <jseward@acm.org>
Subject: Re: Valgrind meets UML 
In-Reply-To: Your message of "Sat, 21 Dec 2002 08:15:27 PST."
             <3E04939F.1020404@BitWagon.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 21 Dec 2002 13:57:44 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is gibberish.  You have no idea what you're talking about.

jreiser@BitWagon.com said:
> But in the abstract, and more importantly in the mind of the
> maintainer of a lock-free SMP allocator 

"lock-free SMP"?  This is very nearly a self-contradiction.  If you'd bother
looking at the allocators, guess what you'll see?  You'll see locking.

> who is trying to allow
> simultaneous allocation and valgrind of the allocator, 

There is no "allowing" simultaneous allocation and valgrind of the allocator.

> then such atomicity problems are real.

Bullshit, there are no such atomicity problems.

> If nothing else, then such a maintainer will invent his own VALGRIND_*
> usage to express simultaneous {allocator, valgrind} state transitions
> precisely.

A maintainer will invent valgrind primitives to express concepts that valgrind
doesn't know about?  

> to express simultaneous {allocator, valgrind} state transitions
> precisely.

There are no simultaneous allocator and valgrind state transitions.

You really need to acquire a clue from somewhere.

				Jeff


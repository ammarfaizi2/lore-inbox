Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSFJGzI>; Mon, 10 Jun 2002 02:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSFJGzH>; Mon, 10 Jun 2002 02:55:07 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:42761 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S316681AbSFJGzG>; Mon, 10 Jun 2002 02:55:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futex Asynchronous Interface 
In-Reply-To: Your message of "Sun, 02 Jun 2002 00:10:19 GMT."
             <20020602001018.A35@toy.ucw.cz> 
Date: Mon, 10 Jun 2002 16:57:56 +1000
Message-Id: <E17HJ7o-00061I-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020602001018.A35@toy.ucw.cz> you write:
> Hi!
> 
> > Name: Waker can unpin page, rather than waiting process
> > Author: Rusty Russell
> > Status: Tested in 2.5.20
> > Depends: Futex/copy-from-user.patch.gz Futex/unpin-page-fix.patch.gz
> > Depends: Futex/waitq.patch.gz
> > 
> > D: This changes the implementation so that the waker actually unpins
> > D: the page.  This is preparation for the async interface, where the
> > D: process which registered interest is not in the kernel.
> 
> What is it? Nice header, did you generate it by hand?

It's a format I made up for all the patches on my web page.  Most
important is the Depends: line which my patch scripts can deal with
quite nicely: see my kernel.org page.

Down with Bit Keeper! Long live patch! 8)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

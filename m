Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312322AbSCYHHW>; Mon, 25 Mar 2002 02:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312325AbSCYHHM>; Mon, 25 Mar 2002 02:07:12 -0500
Received: from [202.135.142.194] ([202.135.142.194]:28177 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312322AbSCYHHE>; Mon, 25 Mar 2002 02:07:04 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [patch] smaller kernels 
In-Reply-To: Your message of "Sun, 24 Mar 2002 22:09:23 -0800."
             <3C9EBF13.4FEBB158@zip.com.au> 
Date: Mon, 25 Mar 2002 18:09:55 +1100
Message-Id: <E16pOc7-00043S-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C9EBF13.4FEBB158@zip.com.au> you write:
> Rusty Russell wrote:
> > 
> > On Tue, 19 Mar 2002 22:11:48 -0800
> > Andrew Morton <akpm@zip.com.au> wrote:
> > 
> > > This is the result of a search-and-destroy mission against
> > > oft-repeated strings in the kernel text.  These come about
> > > due to the toolchain's inability to common up strings between
> > > compilation units.
> > 
> > The name is horrible.  BUG() stands out: perhaps "BUG_LITE()"?
> 
> out_of_line_bug()? It's a bit ornate I guess, but it tells
> you what it does when you look at it.

I like BUG() because it stands out in a fast code scan.  And the
shouting prevents people from sprinkling them everywhere like a
drunken soldier (although there are still some people who seem to want
to BUG before ops which would oops anyway...)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbSKPGYf>; Sat, 16 Nov 2002 01:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267235AbSKPGYe>; Sat, 16 Nov 2002 01:24:34 -0500
Received: from dp.samba.org ([66.70.73.150]:2189 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267228AbSKPGYe>;
	Sat, 16 Nov 2002 01:24:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: in-kernel linking issues 
In-reply-to: Your message of "Fri, 15 Nov 2002 15:47:47 -0800."
             <20021115154747.B25789@twiddle.net> 
Date: Sat, 16 Nov 2002 17:19:49 +1100
Message-Id: <20021116063131.982452C0FC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021115154747.B25789@twiddle.net> you write:
> On Sat, Nov 16, 2002 at 09:45:21AM +1100, Rusty Russell wrote:
> > Hmm, OK, I guess this is where I say "patch welcome"?
> 
> I guess this is where I say "patch for what"?  Do I have some
> amount of buy-in for the shared library approach, or do I start
> adding lots of code to your .o linker?
> 
> I guess I could work up a proof-of-concept patch for the former
> and see what people think...

The former.  Just hack up a patch for x86 and alpha (skip dropping
init for now) and we can see what it looks like.  I can do ppc32, and
when I get back home, ppc64 and Itanium (which IMHO is the real test:
ia64 seems to have one of everything).

It will probably take a week, since I return to .au in two days, and
that always hurts.  Sorry 8(

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

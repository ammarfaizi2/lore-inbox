Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266923AbSK2BYJ>; Thu, 28 Nov 2002 20:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbSK2BXX>; Thu, 28 Nov 2002 20:23:23 -0500
Received: from dp.samba.org ([66.70.73.150]:27577 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266923AbSK2BWs>;
	Thu, 28 Nov 2002 20:22:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: Modules with list 
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz, zippel@linux-m68k.org,
       davem@redhat.com
In-reply-to: Your message of "Wed, 27 Nov 2002 16:25:50 -0800."
             <200211280025.QAA07845@baldur.yggdrasil.com> 
Date: Fri, 29 Nov 2002 10:53:32 +1100
Message-Id: <20021129013010.79DF72C33D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200211280025.QAA07845@baldur.yggdrasil.com> you write:
> Rusty Russel wrote:

That's Russell 8)

> >Sorry, that's why I said "*If O_NONBLOCK* is specified" (ie. still
> >drop it for the --wait case).
> 
> 	Oops!  Sorry for misreading your message.
> 
> 	Even though it was not responsive to what you described, I do
> hope you see my point about the problem with "rmmod --wait".

But's it's an absolute requirement, to make modules removable in some
circumstances, otherwise you end up being starved and the module
cannot be removed (security modules and netfilter modules strike me as
the obvious cases, but there are probably more).

Cheers!
Rusty.
PS.  You're right, net/ipv4/ doesn't use skb->destructor.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

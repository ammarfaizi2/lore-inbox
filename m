Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSHSAZV>; Sun, 18 Aug 2002 20:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSHSAZV>; Sun, 18 Aug 2002 20:25:21 -0400
Received: from dp.samba.org ([66.70.73.150]:47749 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316569AbSHSAZV>;
	Sun, 18 Aug 2002 20:25:21 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Rupert Eibauer <Rupert@ces.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Fwd: Re: Fwd: Linux Kernel: down_timeout 
In-reply-to: Your message of "Thu, 15 Aug 2002 11:57:17 +0200."
             <200208151157327.SM00152@there> 
Date: Sat, 17 Aug 2002 17:54:35 +1000
Message-Id: <20020818192948.78EA62C12F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200208151157327.SM00152@there> you write:
> I'm no kernel guru, but this looks really useful.  You
> should probably send it to the linux-kernel list and to
> Rusty Russel -- it would be a particularly useful extra
> feature for his futexes.

Hi Rupert,
	That's Russell (two l's) 8)

> > Does anybody of you know why it hasnt been implemented in
> > the kernel until now?

I think because it can be faked up with SIGALRM.  And if that's too
slow, you can use futexes which have this anyway.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

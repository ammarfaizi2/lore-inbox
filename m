Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266598AbRGLVEE>; Thu, 12 Jul 2001 17:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266595AbRGLVDy>; Thu, 12 Jul 2001 17:03:54 -0400
Received: from [194.213.32.142] ([194.213.32.142]:27140 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266587AbRGLVDp>;
	Thu, 12 Jul 2001 17:03:45 -0400
Message-ID: <20010712000448.A333@bug.ucw.cz>
Date: Thu, 12 Jul 2001 00:04:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rusty Russell <rusty@rustcorp.com.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: kaos@ocs.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5
In-Reply-To: <3B4718CC.483CE54E@mandrakesoft.com> <m15J9BM-000CGlC@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <m15J9BM-000CGlC@localhost>; from Rusty Russell on Sun, Jul 08, 2001 at 05:40:43PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > IMHO you should be free to bump the module reference count up and down
> > as you wish, and be able to read the module reference count.
> > 
> > If you make that assumption, then it becomes possible to use the module
> > ref count as an internal reference counter, for device opens or
> > something like that.
> 
> Surely the exception rather than the rule?
> 
> Sorry, complicating the code and making everyone pay the penalty so
> you can take a confusing short cut in your code is not something we're
> going to agree on.

Actually, having uniform interface between kernel and modules is very
nice... And one int per module does not surely hurt, does it? 

Perhaps #define NEED_USE_COUNT to do it on per-module basis?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org

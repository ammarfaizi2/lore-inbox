Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbRGINFE>; Mon, 9 Jul 2001 09:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267058AbRGINEy>; Mon, 9 Jul 2001 09:04:54 -0400
Received: from juicer34.bigpond.com ([139.134.6.86]:11727 "EHLO
	mailin9.bigpond.com") by vger.kernel.org with ESMTP
	id <S267057AbRGINEh>; Mon, 9 Jul 2001 09:04:37 -0400
Message-Id: <m15J9BM-000CGlC@localhost>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: kaos@ocs.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5 
In-Reply-To: Your message of "Sat, 07 Jul 2001 10:12:28 -0400."
             <3B4718CC.483CE54E@mandrakesoft.com> 
Date: Sun, 08 Jul 2001 17:40:43 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3B4718CC.483CE54E@mandrakesoft.com> you write:
> IMHO you should be free to bump the module reference count up and down
> as you wish, and be able to read the module reference count.
> 
> If you make that assumption, then it becomes possible to use the module
> ref count as an internal reference counter, for device opens or
> something like that.

Surely the exception rather than the rule?

Sorry, complicating the code and making everyone pay the penalty so
you can take a confusing short cut in your code is not something we're
going to agree on.

Modules are slower than built in; let's not "fix" this by making
builtin code slower. 8)

Rusty.
--
Premature optmztion is rt of all evl. --DK

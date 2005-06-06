Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVFFUOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVFFUOY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVFFULG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:11:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:10204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261658AbVFFUKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:10:11 -0400
Date: Mon, 6 Jun 2005 13:12:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
In-Reply-To: <20050606192654.GA3155@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0506061310500.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
 <20050606192654.GA3155@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Jun 2005, Pavel Machek wrote:

> > Pavel Machek:
> >   fix jumpy mouse cursor on console
> 
> This one was from Dmitry, and git logs know that:

No it doesn't. Somebody sent me a patch in the wrong format..

> author Pavel Machek <pavel@suse.cz> Fri, 27 May 2005 12:53:03 -0700
> committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat, 28 May 2005 11:14:01 -0700
> 
>     [PATCH] fix jumpy mouse cursor on console
> 
>     Do not send empty events to gpm.  (Keyboards are assumed to have scroll
>     wheel these days, that makes them part-mouse.  That means typing on
>     keyboard generates empty mouse events).
> 
>     From: Dmitry Torokhov <dtor_core@ameritech.net>
>     Signed-off-by: Pavel Machek <pavel@suse.cz>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> ...perhaps shortlog script needs some updating?

No, it isn't going to go through the body of the email.

The way that author attributions get done right is if the first line of 
the body of the email has a "From: xyzzy <abc@xyz.com>" in it.

		Linus

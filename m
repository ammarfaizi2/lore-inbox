Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVFFUSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVFFUSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVFFUQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:16:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7873 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261685AbVFFUPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:15:03 -0400
Date: Mon, 6 Jun 2005 22:14:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
Message-ID: <20050606201441.GG2230@elf.ucw.cz>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050606192654.GA3155@elf.ucw.cz> <Pine.LNX.4.58.0506061310500.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506061310500.1876@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >   fix jumpy mouse cursor on console
> > 
> > This one was from Dmitry, and git logs know that:
> 
> No it doesn't. Somebody sent me a patch in the wrong format..

Okay, that was probably me, but...

> > author Pavel Machek <pavel@suse.cz> Fri, 27 May 2005 12:53:03 -0700
> > committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat, 28 May 2005 11:14:01 -0700
> > 
> >     [PATCH] fix jumpy mouse cursor on console
> > 
> >     Do not send empty events to gpm.  (Keyboards are assumed to have scroll
> >     wheel these days, that makes them part-mouse.  That means typing on
> >     keyboard generates empty mouse events).
> > 
> >     From: Dmitry Torokhov <dtor_core@ameritech.net>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     Signed-off-by: Pavel Machek <pavel@suse.cz>
> >     Signed-off-by: Andrew Morton <akpm@osdl.org>
> >     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> > 
> > ...perhaps shortlog script needs some updating?
> 
> No, it isn't going to go through the body of the email.
> 
> The way that author attributions get done right is if the first line of 
> the body of the email has a "From: xyzzy <abc@xyz.com>" in it.

There is "From: Dmitry..." in the changelog. Do your script move first
"From:" into author header and delete it from changelog? That would
explain it...
								Pavel

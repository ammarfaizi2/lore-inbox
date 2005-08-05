Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262924AbVHEJeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbVHEJeV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVHEJeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:34:21 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:31362 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262924AbVHEJeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:34:20 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] remove i386 dynamic ticks ifdefs
Date: Fri, 5 Aug 2005 19:26:52 +1000
User-Agent: KMail/1.8.2
Cc: tony@atomide.com, linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200507291206.46261.kernel@kolivas.org> <20020101103339.GC467@openzaurus.ucw.cz>
In-Reply-To: <20020101103339.GC467@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508051926.52977.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2002 21:33, Pavel Machek wrote:
> Hi!
>
> > I assume you're maintaining the dyn tick patches for i386 posted on the
> > muru website as your email is listed there. I thought you might be
> > interested in this patch for dyn-ticks which removes most of the #ifdefs
> > out of common code paths as per linux kernel style and moves more code
> > into dyn-tick.c. Most of it is straight forward code reorganisation, but
> > to keep do_timer_interrupt inlined I'd have to move it's code around
> > somewhat. That may be a better option but I've tried to fiddle with the
> > mainline code as little as possible.
> >
> > Patch applies to 2.6.12 with patch-dynamic-tick-2.6.12-rc6-050610-1
> > applied
> >
> > cc'ed lkml just for public record of the patch.
>
> Please inline patches...

Not everyone uses console email clients :| It was an inlined attachment rather 
than an ordinary attachment but clearly that doesn't suit those with console 
clients. I'm sorry.

>
> You broke indentation in one of first hunks, and you probably
> want empty functions to be static inline, so that we do not eat
> function call overhead.

Will examine. Thanks very much for your code comments!

Cheers,
Con

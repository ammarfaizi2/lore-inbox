Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbSKNEC2>; Wed, 13 Nov 2002 23:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSKNEC2>; Wed, 13 Nov 2002 23:02:28 -0500
Received: from dp.samba.org ([66.70.73.150]:61905 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262779AbSKNEC1>;
	Wed, 13 Nov 2002 23:02:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, rusty@rustcorp.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: module mess in -CURRENT 
In-reply-to: Your message of "Wed, 13 Nov 2002 18:32:31 -0800."
             <Pine.LNX.4.44.0211131828480.6810-100000@home.transmeta.com> 
Date: Thu, 14 Nov 2002 16:07:42 +1100
Message-Id: <20021114040920.AFB7E2C0EC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211131828480.6810-100000@home.transmeta.com> you wri
te:
> 
> > The biggest need though is documentation so people can actually fix all
> > the drivers for this stuff.
> 
> I think Al convinced Rusty that most drivers don't need to worry and that
> Rusty was a bit over-eager (ie sound, much of char, all of block and fs
> should all be handled by upper layers without the races)

Not really.  The Kernel Summit and an audit of drivers convinced me
that changing every driver simply wasn't feasible.

*You* convinced me not to break any driver source code: every time you
dropped my patches I went back and implemented another compat macro 8)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

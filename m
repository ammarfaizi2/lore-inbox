Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVEKAYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVEKAYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVEKAYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:24:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:16000 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261842AbVEKAYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 20:24:09 -0400
Date: Tue, 10 May 2005 17:23:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace
 cleanup)
Message-Id: <20050510172332.45b6d5ee.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505110208080.2386@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0505110057500.2386@dragon.hyggekrogen.localhost>
	<20050510161657.3afb21ff.akpm@osdl.org>
	<20050510.161907.116353193.davem@davemloft.net>
	<20050510170246.5be58840.akpm@osdl.org>
	<Pine.LNX.4.62.0505110208080.2386@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> > 
> > Well I suppose I could live with a few REALLY REALLY BIG patches to do this
> > to lots of files, but if it's the old death-by-1000-cuts, I'm gonna call
> > uncle this time.
> > 
> These things annoy me, so if you are willing to accept a few patches (in 
> the 10-20 range) that clean most (I'm not going to say all) of this stuff 
> up, then I'm game. Give me a few days (more likely a week or two or 
> slightly more) and I'll get that done. Those patches *will* be big 
> though...

OK, a few 100k-400k patches would suit.

Make the patches against latest -linus tree.  I'll then apply them on top
of latest -mm, discard all the rejects and then rediff against -linus.

That way we end up with a patch which minimises the number of conflicts
with other people's ongoing work.


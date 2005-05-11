Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVEKADN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVEKADN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVEKADM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:03:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:59881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261852AbVEKACM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 20:02:12 -0400
Date: Tue, 10 May 2005 17:02:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace
 cleanup)
Message-Id: <20050510170246.5be58840.akpm@osdl.org>
In-Reply-To: <20050510.161907.116353193.davem@davemloft.net>
References: <Pine.LNX.4.62.0505110057500.2386@dragon.hyggekrogen.localhost>
	<20050510161657.3afb21ff.akpm@osdl.org>
	<20050510.161907.116353193.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> From: Andrew Morton <akpm@osdl.org>
> Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace cleanup)
> Date: Tue, 10 May 2005 16:16:57 -0700
> 
> > Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > >
> > > -	if (b == NULL || already_uses(a, b)) return 1;
> > > +	if (b == NULL || already_uses(a, b))
> > > +		return 1;
> > 
> > There are about 88 squillion of these in the kernel.  I think it would be a
> > mistake for me to start taking such patches, sorry.
> 
> I disagree.  Putting statements on the same line as
> the if statement hides bugs and makes the code harder
> to read.

We all know that, but this means that we spend the next two years fielding
an ongoing dribble of trivial patches which distract from real work.

> Fixing these makes the kernel eaiser to maintain
> and debug.

Well I suppose I could live with a few REALLY REALLY BIG patches to do this
to lots of files, but if it's the old death-by-1000-cuts, I'm gonna call
uncle this time.


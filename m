Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVEKAaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVEKAaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVEKAaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:30:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:21377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261853AbVEKA36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 20:29:58 -0400
Date: Tue, 10 May 2005 17:29:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace
 cleanup)
Message-Id: <20050510172913.2d47a4d4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505110217350.2386@dragon.hyggekrogen.localhost>
References: <20050510161657.3afb21ff.akpm@osdl.org>
	<20050510.161907.116353193.davem@davemloft.net>
	<20050510170246.5be58840.akpm@osdl.org>
	<20050510.170946.10291902.davem@davemloft.net>
	<Pine.LNX.4.62.0505110217350.2386@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> I'll need time to do this - no matter how you cut it there are a lot of 
>  files, and a lot of lines - so don't expect the patch bombing to start for 
>  the next few weeks.
>  And before I embark on this venture I'd like some feedback that when I do 
>  turn up with patches they'll have a resonable chance of getting merged - 
>  this is going to be a lot of boring work, and with no commitment to merge 
>  anything it's not something I want to waste days on...  Sounds fair?

ho hum.  Just send them over as you generate them.

>  Ohh, and I'd be submitting all the patches to you Andrew, not individual 
>  maintainers/authors..

That should be OK - you can test that the .o files have the same `size'
output before-and-after.

The changes shouldn't break any subsystem maintainers' trees, although they
will surely trip up individual developers who are working on stuff, so
please make some attempt to keep the relevant people in the loop.


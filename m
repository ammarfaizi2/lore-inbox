Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVEJX0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVEJX0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 19:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVEJX0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 19:26:47 -0400
Received: from mail.dif.dk ([193.138.115.101]:16522 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261806AbVEJX0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 19:26:45 -0400
Date: Wed, 11 May 2005 01:30:39 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace
 cleanup)
In-Reply-To: <20050510161657.3afb21ff.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505110126160.2386@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0505110057500.2386@dragon.hyggekrogen.localhost>
 <20050510161657.3afb21ff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > -	if (b == NULL || already_uses(a, b)) return 1;
> > +	if (b == NULL || already_uses(a, b))
> > +		return 1;
> 
> There are about 88 squillion of these in the kernel.  I think it would be a
> mistake for me to start taking such patches, sorry.
> 
Yes, there are a ton of these. There are also a ton of files that use 
spaces instead of tabs, and a ton of files that use spaces between 
function name and opening parenthesis - like  foo (arg);  or even 
 foo ( arg ) ;

Just because there are lost of them doesn't (in my oppinion) mean that 
they shouldn't be cleaned up. Reading code that doesn't adhere to 
CodingStyle is annoying at best, and hides bugs at worst.
There's no way I'm going to clean it all up - especially not if you don't 
want the patches, but I think it *ought* to be cleaned up, and if you 
should change your mind then I'm willing to clean up at least a fair bit 
of it.


-- 
Jesper



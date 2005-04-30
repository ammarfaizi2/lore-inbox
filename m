Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVD3Ws0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVD3Ws0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 18:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVD3Ws0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 18:48:26 -0400
Received: from mail.dif.dk ([193.138.115.101]:8867 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261264AbVD3WsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 18:48:21 -0400
Date: Sun, 1 May 2005 00:51:49 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Ed Tomlinson <tomlins@cam.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
In-Reply-To: <Pine.LNX.4.61.0504301634590.3559@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.62.0505010050040.2094@dragon.hyggekrogen.localhost>
References: <20050429231653.32d2f091.akpm@osdl.org> <200504300827.44359.tomlins@cam.org>
 <Pine.LNX.4.61.0504301634590.3559@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2005, Zwane Mwaikambo wrote:

> On Sat, 30 Apr 2005, Ed Tomlinson wrote:
> 
> > If we stick with git it might make sense not to include a linux-patch.  cogito
> > is quite fast to export using a commit id.  Suspect some bandwidth could be 
> > saved if you just stated the commit id that you based the mm patch on.
> > 
> > In case anyone is wondering how build this from a cogito/git db...  Find the
> > cogito announcement on lkml install and update cogito.  Then folliw the instructions
> > in the README and download the kernel's db.  Next search lkml to find the commit id 
> > of rc3 (a2755a80f40e5794ddc20e00f781af9d6320fafb) and verify you have it correct 
> > with:
> > 
> > cg-mkpatch a2755a80f40e5794ddc20e00f781af9d6320fafb
> > 
> > then export a tree with
> > 
> > cg-export ../12-3-1 a2755a80f40e5794ddc20e00f781af9d6320fafb
> > 
> > and cd over to the new dir and patch with mm and have fun.
> 
> That'd be a horribly convoluted procedure and make automation difficult,
> -mm shouldn't be that difficult to use. Also linus.patch used to be the 
> current -bk snapshot.

I agree. Getting a -mm kernel currently requires nothing more than patch - 
that's good. Introducing a git/cogito requirement will reduce the 
users/testers of -mm - not good.


-- 
Jesper Juhl



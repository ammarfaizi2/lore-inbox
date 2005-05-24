Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVEXHrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVEXHrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 03:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVEXHrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 03:47:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:48015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261416AbVEXHrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 03:47:45 -0400
Date: Tue, 24 May 2005 00:46:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates
In-Reply-To: <4292D7E1.80601@pobox.com>
Message-ID: <Pine.LNX.4.58.0505240042550.2307@ppc970.osdl.org>
References: <4292BA66.8070806@pobox.com> <Pine.LNX.4.58.0505232253160.2307@ppc970.osdl.org>
 <4292C8EF.3090307@pobox.com> <Pine.LNX.4.58.0505232343260.2307@ppc970.osdl.org>
 <4292D7E1.80601@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 May 2005, Jeff Garzik wrote:
> 
> Ok, I'll fix the commit message.
> 
> As for different trees, I'm afraid you've written something that is _too 
> useful_ to be used in that manner.

I really think you'll eventually confuse yourself terminally, but as long 
as the commit messages end up being meaningful, your "mush everything 
together" clearly is the thing that is going to perform best.

> Git has brought with it a _major_ increase in my productivity because I 
> can now easily share ~50 branches with 50 different kernel hackers, 
> without spending all day running rsync.

Hey, I'm happy it works for you, but are you sure those 50 other kernel 
hackers aren't confused?

IOW, your work model is pretty extreme, and I'm much more worried about 
mixing up trees by mistake than about the technical side of git per se. 
That's also why I think it's important that the commit logs are 
meaningful: they do end up containing the SHA1 key, so clearly "all the 
information" is there, but if something gets mixed up, I'd like some human 
to be able to eventualyl say "Aaahhh.. _that's_ where it got mixed up".

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWBMTYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWBMTYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWBMTYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:24:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932438AbWBMTYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:24:31 -0500
Date: Mon, 13 Feb 2006 11:21:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie,
       dri-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rc3: more regressions
In-Reply-To: <Pine.LNX.4.64.0602131115010.3691@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0602131117400.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
 <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
 <20060213174658.GC23048@redhat.com> <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org> <20060213183445.GA3588@stusta.de>
 <Pine.LNX.4.64.0602131043250.3691@g5.osdl.org> <20060213190907.GD3588@stusta.de>
 <Pine.LNX.4.64.0602131115010.3691@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Feb 2006, Linus Torvalds wrote:
> 
> So I decided to just remove it. Even if there is some other bug that could 
> make it work again, we can always just re-add it at that time. In the 
> meantime, this should fix both DaveJs and Mauros problems, and is clearly 
> no worse than 2.6.15 (which also didn't recognize the card), so...

Btw, on a totally unrelated tangent, I just wanted to say how much I 
appreciate people looking for regressions like this, and trying to track 
them. Andrew does it, but this is absolutely something that should be 
possible to get more people to do, and it would be a huge boon for kernel 
development if we had a more aggressive regression tracking system.

Right now it all very easily gets lost in the noise - either on the 
mailing list or even on bugzilla (where following up on regressions and 
trying to get details and prodding people to perhaps try to narrow things 
down a bit more often ends up falling on the floor, because it's a big 
job).

			Linus

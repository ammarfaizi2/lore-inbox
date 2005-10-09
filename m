Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVJIXKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVJIXKi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 19:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVJIXKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 19:10:38 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:34575 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S932301AbVJIXKh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 19:10:37 -0400
Date: Sun, 9 Oct 2005 18:41:22 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Uml left showstopper bugs for 2.6.14
Message-ID: <20051009224122.GA8282@ccure.user-mode-linux.org>
References: <200510092118.21032.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510092118.21032.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 09:18:20PM +0200, Blaisorblade wrote:
> 1) problems with UBD (i.e. _the_ uml block driver): this is pretty dangerous 
> and untrivial to fix, even if the code exists - so I and Jeff agreed to revert 
> the change altogether. Jeff will send the thing.

My current plan is to revert the ubd-aio patch.  I need to look at this and
run some testing on it.

> 3) SKAS0 is broken on amd64 hosts, when frame pointers are disabled. Jeff has 
> the fix, waiting end of testing.

This has been sent to Linus.

> 5) Compile-time regression with SKAS mode disabled, will fix later (I'm going 
> to have dinner now).

I looked at the patch and requested the sender forward it to Linus, with my
approval.  If he doesn't in the next day or so, then I'll send it in myself.

				Jeff

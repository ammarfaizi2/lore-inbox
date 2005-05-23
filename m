Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVEWO0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVEWO0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 10:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEWO0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 10:26:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:34485 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261727AbVEWO0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:26:02 -0400
Date: Mon, 23 May 2005 07:27:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Willy Tarreau <willy@w.ods.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi SuperIO
 chip
In-Reply-To: <20050523040905.GH18600@alpha.home.local>
Message-ID: <Pine.LNX.4.58.0505230723170.2307@ppc970.osdl.org>
References: <200505220008.j4M08uE9025378@hera.kernel.org>
 <1116763033.19183.14.camel@localhost.localdomain> <20050522135943.E12146@flint.arm.linux.org.uk>
 <20050522144123.F12146@flint.arm.linux.org.uk> <1116796612.5730.15.camel@localhost.localdomain>
 <Pine.LNX.4.58.0505221438260.2307@ppc970.osdl.org>
 <1116800555.5744.21.camel@localhost.localdomain> <Pine.LNX.4.58.0505221535370.2307@ppc970.osdl.org>
 <20050523040905.GH18600@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 May 2005, Willy Tarreau wrote:
> 
> Why not change this slightly to something like :
> 
>        DCO-1.1-Signed-off-by: Random J Developer <random@developer.org>
> 
> which would imply that this person has read (and agreed with) version 1.1 ?

This is one reason I wanted to avoid the 1.0->1.1 change.

I think that if somebody really cares about the version, the above is 
certainly acceptable.

In general, I'd personally not use it, and it seems pointless. If we make
some _real_ changes to the DCO that really matter rather than the 1.0->1.1
thing that I'd consider "obvious clarifications", we'll probably have to 
change the sign-off.

As it is, I think we should just make the change very public and let
people know about it, and go with it, because quite frankly, even if
somebody claims that they didn't know about the new version of the DCO,
he'd have to be crazy to claim that he didn't know Linux was public and 
that the resulting sign-off is public too, so I see it as a "comfort 
level" thing, not anything fundamental.

(And note that even the "comfort level" is not for the people doing the
sign-off, but for the person _receiving_ the sign-off).

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbUKAFtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUKAFtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 00:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbUKAFta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 00:49:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:47003 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261380AbUKAFt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 00:49:26 -0500
Date: Sun, 31 Oct 2004 21:49:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0410312024150.19538@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0410312148200.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com>
 <Pine.LNX.4.58.0410291209170.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410312024150.19538@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Oct 2004, linux-os wrote:
> 
> The attached file shows that the Intel Pentium 4 runs exactly as I
> described. Further, there is no difference in the CPU clocks used when
> adding a constant to the stack- pointer or using LEA.

Goodie. You found _one_ CPU that you think matters. On ethat doesn't even 
have the hardware that I've described. And you ignore all the other 
evidence. 

Good for you.

		Linus

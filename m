Return-Path: <linux-kernel-owner+willy=40w.ods.org-S318821AbUKBF2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S318821AbUKBF2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S318823AbUKBF2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 00:28:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:51675 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274793AbUKAW04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:26:56 -0500
Date: Mon, 1 Nov 2004 14:26:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0411011651580.26464@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0411011424110.28839@ppc970.osdl.org>
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
 <Pine.LNX.4.61.0411011219200.8483@twinlark.arctic.org>
 <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com>
 <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0411011651580.26464@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Nov 2004, linux-os wrote:
> 
> You just don't get it. I, too, can make a so-called bench-mark
> that will "prove" something that's so incredibly invalid that
> it shouldn't even deserve an answer.

*Plonk*

You've just shown that not only do you ignore well-educated people who 
tell you why pipelines can have trouble with "lea", you also ignore hard 
numbers.

Your total focus on a cached memory access as being somehow more expensive
than anything else going in the CPU pipeline is sad.

But hey, I've run out of ways to show you wrong. If you believe the world 
is flat, that's your problem.

		Linus

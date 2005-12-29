Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVL2V0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVL2V0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 16:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVL2V0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 16:26:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750974AbVL2V0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 16:26:15 -0500
Date: Thu, 29 Dec 2005 13:25:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
 <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com>
 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Dec 2005, Linus Torvalds wrote:
> 
> At least _I_ take breakage reports seriously. If there are maintainers 
> that don't, complain to them. I'll back you up. Breaking user space simply 
> isn't acceptable without years of preparation and warning.

Btw, sometimes we knowingly change semantics that we believe that nobody 
would ever be able to care about. Then we literally _depend_ on people 
complaining about breakage in case we were wrong, and if you guys don't, 
and just curse, and upgrade programs, we actually miss out on real 
information.

And yes, occasionally we don't have much choice, and things break. It 
should be extremely rare, though. Much more commonly it would be a bug or 
an unintentional change that somebody didn't even realized changed 
semantics subtly.

		Linus

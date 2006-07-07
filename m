Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWGGV7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWGGV7f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWGGV7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:59:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56987 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932339AbWGGV7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:59:34 -0400
Date: Fri, 7 Jul 2006 14:59:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Krzysztof Halasa <khc@pm.waw.pl>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0607071456430.3869@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu><20060705101059.66a762bf.akpm@osdl.org><20060705193551.GA13070@elte.hu><20060705131824.52fa20ec.akpm@osdl.org><Pine.LNX.4.64.0607051332430.12404@g5.osdl.org><20060705204727.GA16615@elte.hu><Pine.LNX.4.64.0607051411460.12404@g5.osdl.org><20060705214502.GA27597@elte.hu><Pine.LNX.4.64.0607051458200.12404@g5.osdl.org><Pine.LNX.4.64.0607051555140.12404@g5.osdl.org><20060706081639.GA24179@elte.hu><Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com><Pine.LNX.4.64.0607060856080.12404@g5.osdl.org><Pine.LNX.4.64.0607060911530.12404@g5.osdl.org><Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
 <m34pxt8emn.fsf@defiant.localdomain> <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
 <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org> <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jul 2006, linux-os (Dick Johnson) wrote:
>
> This is a bait and switch argument. The code was displayed to show
> the compiler output, not an example of good coding practice.

NO IT IS NOT.

The whole point of my argument is simple:

> > 	"'volatile' is useless. The things it did 30 years ago are much
> > 	 more complex these days, and need to be tied to much more
> > 	 detailed rules that depend on the actual particular problem,
> > 	 rather than one keyword to the compiler that doesn't actually
> > 	 give enough information for the compiler to do anything useful"

And dammit, if you cannot admit that, then you're not worth discussing 
with.

"volatile" is useless. It's a big hammer in a world where the nails aren't 
nails any more, they are screws, thumb-tacks, and spotwelding.

It still makes a difference for code generation, OF COURSE. But it's the 
wrong thing to use.

		Linus

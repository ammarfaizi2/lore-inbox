Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSFTWSj>; Thu, 20 Jun 2002 18:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSFTWSi>; Thu, 20 Jun 2002 18:18:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48655 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315634AbSFTWSh>; Thu, 20 Jun 2002 18:18:37 -0400
Date: Thu, 20 Jun 2002 15:18:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Cort Dougan <cort@fsmlabs.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
In-Reply-To: <3D125032.3040809@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0206201511300.872-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Martin Dalecki wrote:
>
> Yes HT gives 12%. naive SMP gives 50% and good SMP (aka corssbar bus)
> gives 70% for two CPU. All those numbers are well below the level
> where more then 2-4 makes hardly any sense...

You don't _understand_.

If it's "free", you take that 70% for the second CPU, and the additional
20% for the next two.

Don't bother repeating yourself about Amdahls law. Realize what Moore's
law says: things get cheaper over time. A _lot_ cheaper.

It's still a fact that people are willing to pay for performance. Even if
they strictly don't "need" it (but who are you or I to say who "needs"
performance?).

At which point it doesn't _matter_ if you only get 70% or 30% or 12%
improvement. If it's within "cheap enough", people will buy it. In fact,
once it gets "too cheap", people will buy something more expensive just
because a cheap PC obviously isn't good enough. That's _reality_.

Your "efficiency" arguments have no basis in the real life of economics in
a developing market. Only embedded people care about absolute cost and
absolute efficiencies ("it's not worth it for us to go for a more powerful
CPU, since we don't need it"). The rest of the world takes that 66MHz
improvement (in a CPU that does multiple gigahertz) and is happy about it.
Or takes the added 12%, and is happy about it.

Humans are not rational creatures. We're _rationalizing_ creatures, and we
love rationalizing that big machine that just makes us feel better.

		Linus


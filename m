Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277280AbRJEAPx>; Thu, 4 Oct 2001 20:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277272AbRJEAPn>; Thu, 4 Oct 2001 20:15:43 -0400
Received: from zeus.kernel.org ([204.152.189.113]:56793 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S277280AbRJEAP3>;
	Thu, 4 Oct 2001 20:15:29 -0400
Date: Thu, 4 Oct 2001 17:18:42 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ben Greear <greearb@candelatech.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>, <mingo@elte.hu>,
        jamal <hadi@cyberus.ca>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>, <netdev@oss.sgi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BBCF802.1B650B20@candelatech.com>
Message-ID: <Pine.LNX.4.40.0110041712450.1022-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001, Ben Greear wrote:

> Linus Torvalds wrote:
> >
> > On 4 Oct 2001, Robert Love wrote:
> > >
> > > Agreed.  I am actually amazed that the opposite of what is happening
> > > does not happen -- that more people aren't clamoring for this solution.
> >
> > Ehh.. I think that most people who are against Ingo's patches are so
> > mainly because there _is_ an alternative that looks nicer.
> >
> >                 Linus
>
> The alternative (NAPI) only works with Tulip and Intel NICs, it seems.
> When the alternative works for every driver known (including 3rd party
> ones, like the e100), then it will truly be an alternative.  Untill
> then, it will be a great feature for those who can use it, and the
> rest of the poor folks will need a big generic hammer.

NAPI needs aware drivers and introduces changes to the queue processing (
packets left in DMA ring ) and it'll be at least 2.5.x
It's clearly a nicer solution that does not suffer of drawbacks that
Ingo's code have.
Ingo's patch is more hack-ish but addresses the problem with minimal
changes.




- Davide



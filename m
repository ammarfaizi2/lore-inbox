Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277297AbRJECEz>; Thu, 4 Oct 2001 22:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277299AbRJECEp>; Thu, 4 Oct 2001 22:04:45 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:42683 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S277297AbRJECE3>;
	Thu, 4 Oct 2001 22:04:29 -0400
Date: Thu, 4 Oct 2001 22:01:56 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ben Greear <greearb@candelatech.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>, <mingo@elte.hu>,
        <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>, <netdev@oss.sgi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BBCF802.1B650B20@candelatech.com>
Message-ID: <Pine.GSO.4.30.0110042151440.13257-100000@shell.cyberus.ca>
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
>

Ben,
Lets put some reality check and history just for entertainment value:
It took ten years of Linux existence (and i am just using you
as an example no pun intended) to realize your life was actually
an emergency that depended  on Ingos patch. Maybe i am being cruel,
so lets backtrack only over the last 4 years when Alexey first had the
HFC in there; i am willing to bet a large amount of money that you didnt
once use it or even care to post a query if such a thing existed. Ok, so
lets assume you didnt know it existed ... over a year back i posted widely
on it with conjunction to the return code to the netif_rx() extension ...
and still you didnt care that much although you seem to be a user of one
of the converted drivers -- the tulip and in particular the znyx hardware
which was used in the testing. IIRC, you actually said something on that
post .. Then one bright early morn, Eastern time zone, Ingo appears, not
in the form of atoms rather electrons masquareding as bits ...

cheers,
jamal

PS:- I am going to try and mitigate myself from this thread now; my
email-sending rate will be drastically reduced.


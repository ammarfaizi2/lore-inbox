Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276920AbRJHQAG>; Mon, 8 Oct 2001 12:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbRJHP74>; Mon, 8 Oct 2001 11:59:56 -0400
Received: from [216.191.240.114] ([216.191.240.114]:41349 "EHLO
	shell.cyberus.ca") by vger.kernel.org with ESMTP id <S276888AbRJHP7m>;
	Mon, 8 Oct 2001 11:59:42 -0400
Date: Mon, 8 Oct 2001 11:57:11 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrea Arcangeli <andrea@suse.de>,
        Ingo Molnar <mingo@elte.hu>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <E15qcRA-0000uJ-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.30.0110081146050.5473-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Oct 2001, Alan Cox wrote:

> > I hear you, but I think isolation is important;
> > If i am telneted (literal example here) onto that machine (note eth0 is
> > not cardbus based) and cardbus is causing the loops then iam screwed.
> > [The same applies to everything that shares interupts]
>
> Worst case it sucks, but it isnt dead.
>
> Once you disable the IRQ and kick over to polling the cardbus and the
> ethernet both still get regular service. Ok so your pps rate and your
> latency are unpleasant, but you are not dead.
>

Agreed if you add the polling cardbus bit.
Note polling cardbus would require more changes than the above.
My concern was more of the following: This is a temporary solution.  A
quickie if you may. The proper solution is to have the isolation part. If
we push this in, doesnt it result in procastination of "we'll do it later"
Why not do it properly since this was never a show stopper to begin with?
[The showstopper was networking]

cheers,
jamal


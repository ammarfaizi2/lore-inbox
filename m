Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284008AbRLAIus>; Sat, 1 Dec 2001 03:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281506AbRLAIum>; Sat, 1 Dec 2001 03:50:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34568 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284008AbRLAIu2>; Sat, 1 Dec 2001 03:50:28 -0500
Subject: Re: Coding style - a non-issue
To: yodaiken@fsmlabs.com (Victor Yodaiken)
Date: Sat, 1 Dec 2001 08:57:17 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        yodaiken@fsmlabs.com (Victor Yodaiken),
        riel@conectiva.com.br (Rik van Riel), akpm@zip.com.au (Andrew Morton),
        lm@bitmover.com (Larry McVoy),
        phillips@bonn-fries.net (Daniel Phillips),
        hps@intermeta.de (Henning Schmiedehausen),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <20011130214448.A28617@hq2> from "Victor Yodaiken" at Nov 30, 2001 09:44:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16A5xV-0006UL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's a characteristic good Linux design method ,( or call it "less than random
> mutation method" if that makes you feel happy): read the literature,
> think hard, try something, implement it

That assumes computer science is a functional engineering discipline. Its
not, at best we are at the alchemy stage of progression. You put two things
together it goes bang and you try to work out why.

In many of these fields there is no formal literature. The scientific paper
system in computer science is based on publishing things people already
believe. Much of the rest of the knowledge is unwritten or locked away in
labs as a trade secret, and wil probably never be reused.

Take TCP for example. The TCP protocol is specified in a series of
documents. If you make a formally correct implementation of the base TCP RFC
you won't even make connections. Much of the flow control behaviour, the
queueing and the detail is learned only by being directly part of the
TCP implementing community. You can read  all the scientific papers you
like, it will not make you a good TCP implementor. 

Alan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135917AbRAMAhk>; Fri, 12 Jan 2001 19:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135964AbRAMAhU>; Fri, 12 Jan 2001 19:37:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:10768 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135917AbRAMAhS>; Fri, 12 Jan 2001 19:37:18 -0500
Date: Fri, 12 Jan 2001 16:36:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Frank de Lange <frank@unternet.org>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <E14HDjY-0005Ei-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101121635590.8097-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2001, Alan Cox wrote:

> > Could you disable both bandaids? I disabled them, no problems so far.
> > Now back to the disable_irq_nosync().
> 
> Ok so it looks like the disable_irq code is buggy. Unfortunately its not
> just used for these drivers they are just the heaviest users.

It may well not be disable_irq() that is buggy. In fact, there's good
reason to believe that it's a hardware problem.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

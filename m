Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132660AbRALUEe>; Fri, 12 Jan 2001 15:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132805AbRALUEY>; Fri, 12 Jan 2001 15:04:24 -0500
Received: from chiara.elte.hu ([157.181.150.200]:49678 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132660AbRALUEN>;
	Fri, 12 Jan 2001 15:04:13 -0500
Date: Fri, 12 Jan 2001 21:03:49 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Frank de Lange <frank@unternet.org>,
        Manfred Spraul <manfred@colorfullife.com>, <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
 related?
In-Reply-To: <Pine.LNX.4.10.10101121158050.3010-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101122101370.2576-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jan 2001, Linus Torvalds wrote:

> [...] Ingo, what was the focus-cpu thing?

well, some time ago i had an ne2k card in an SMP system as well, and found
this very problem. Disabling/enabling focus-cpu appeared to make a
difference, but later on i made experiments that show that in both cases
the hang happens. I spent a good deal of time trying to fix this problem,
but failed - so any fresh ideas are more than welcome.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132384AbRALUiH>; Fri, 12 Jan 2001 15:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132999AbRALUiB>; Fri, 12 Jan 2001 15:38:01 -0500
Received: from chiara.elte.hu ([157.181.150.200]:57614 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132756AbRALUhr>;
	Fri, 12 Jan 2001 15:37:47 -0500
Date: Fri, 12 Jan 2001 21:37:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Frank de Lange <frank@unternet.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
In-Reply-To: <20010112213555.F26555@unternet.org>
Message-ID: <Pine.LNX.4.30.0101122136180.2772-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jan 2001, Frank de Lange wrote:

> It is. As I already mentioned in other messages, I already tested with
> JUST the patched 8390.c driver, no other patches. It was stable. I
> then patched apic.c AND io_apic.c, which did not introduce new
> instabilities. Unless you think that reverting back to a stock
> io_apic.c would cause instabilities (which would be weird, since I had
> no instabilities running only a patched 8390.c), I think the patch to
> 8390.c DOES remove the symptoms all by itself. No other patches seem
> necessary to get a stable box.

okay - i just wanted to hear a definitive word from you that this fixes
your problem, because this is what we'll have to do as a final solution.
(barring any other solution.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

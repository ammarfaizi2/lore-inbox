Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132355AbRALUcS>; Fri, 12 Jan 2001 15:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132384AbRALUcH>; Fri, 12 Jan 2001 15:32:07 -0500
Received: from chiara.elte.hu ([157.181.150.200]:54030 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132355AbRALUbz>;
	Fri, 12 Jan 2001 15:31:55 -0500
Date: Fri, 12 Jan 2001 21:31:15 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Frank de Lange <frank@unternet.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
In-Reply-To: <20010112212646.D26555@unternet.org>
Message-ID: <Pine.LNX.4.30.0101122130310.2772-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jan 2001, Frank de Lange wrote:

> WITH or WITHOUT the changed 8390 driver? I can already give you the
> results for running WITH the changed driver: it works. I have not yet
> tried it WITHOUT the changed 8390 driver (so that would be stock 8390,
> patched apic.c, stock io_apic.c). Please let me know which you want...

WITH. patched 8390.c, patched apic.c, sock io_apic.c. My very strong
feeling is that this will be a stable combination, and that this is what
we want as a final solution.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

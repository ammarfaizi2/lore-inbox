Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132654AbRALUui>; Fri, 12 Jan 2001 15:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132559AbRALUu2>; Fri, 12 Jan 2001 15:50:28 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:24582 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S132402AbRALUuS>; Fri, 12 Jan 2001 15:50:18 -0500
Date: Fri, 12 Jan 2001 20:46:09 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Frank de Lange <frank@unternet.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
In-Reply-To: <Pine.LNX.4.30.0101122136180.2772-100000@e2>
Message-ID: <Pine.LNX.4.30.0101122040160.30254-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Ingo Molnar wrote:

> okay - i just wanted to hear a definitive word from you that this fixes
> your problem, because this is what we'll have to do as a final solution.
> (barring any other solution.)

Patching 8390.c won't fix this for me. The only thing on IRQ19 when I saw
interrupts die was usb-uhci, and that doesn't appear to use disable_irq.

But then again, I've only ever seen this happen once. It's not repeatable.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

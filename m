Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131765AbRALUes>; Fri, 12 Jan 2001 15:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132439AbRALUeh>; Fri, 12 Jan 2001 15:34:37 -0500
Received: from chiara.elte.hu ([157.181.150.200]:56078 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132384AbRALUe0>;
	Fri, 12 Jan 2001 15:34:26 -0500
Date: Fri, 12 Jan 2001 21:34:03 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Frank de Lange <frank@unternet.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
In-Reply-To: <20010112213217.E26555@unternet.org>
Message-ID: <Pine.LNX.4.30.0101122132290.2772-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jan 2001, Frank de Lange wrote:

> BTW, does this (TARGET_CPUS cpu_online_mask) not wreak havoc with
> systems with hot-pluggable CPUs (many Suns, etc...)? Wouldn;t it be
> better to make this a config option (like the optional PCI fixes for
> crappy BIOSs)?

? this is x86-only code. There is no hot-pluggable CPU support for Linux
AFAIK. (But in any case, the code is basically ready for hot-pluggable
CPUs, just take a few precautions and change cpu_online_mask and a couple
of other things.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

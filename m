Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136176AbRAMBil>; Fri, 12 Jan 2001 20:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132417AbRAMBic>; Fri, 12 Jan 2001 20:38:32 -0500
Received: from colorfullife.com ([216.156.138.34]:22534 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136176AbRAMBiP>;
	Fri, 12 Jan 2001 20:38:15 -0500
Message-ID: <3A5FB17C.A112F27B@colorfullife.com>
Date: Sat, 13 Jan 2001 02:38:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Frank de Lange <frank@unternet.org>,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <Pine.LNX.4.10.10101121635590.8097-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> It may well not be disable_irq() that is buggy. In fact, there's good
> reason to believe that it's a hardware problem.
> 
Perhaps a problem with the 82093AA external IO APIC used for 440BX
board? I haven't seen any reports from newer Intel boards (the ICH2
includes an IO APIC) or from Via boards.

The problem is not SMP specific: Frank wrote that it also occured when
he booted with "max_cpus=1".

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbRALRtr>; Fri, 12 Jan 2001 12:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRALRtj>; Fri, 12 Jan 2001 12:49:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1811 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129655AbRALRtS>; Fri, 12 Jan 2001 12:49:18 -0500
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
To: manfred@colorfullife.com (Manfred Spraul)
Date: Fri, 12 Jan 2001 17:49:57 +0000 (GMT)
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, frank@unternet.org
In-Reply-To: <3A5F3BF4.7C5567F8@colorfullife.com> from "Manfred Spraul" at Jan 12, 2001 06:16:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14H8Ks-0004hA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Frank, could you try what happens with the NMI oopser disabled?
> 
> The second major difference I'm immediately aware of is the number of
> the reschedule/tlb flush/etc interrupt: 2.2 uses the lowest priority,
> 2.4 the highest priority.

Im trying to remember what they were, but some APIC versions do have errata
and someting about 3 irqs at the same priority level rings a bell.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131231AbQKQJvF>; Fri, 17 Nov 2000 04:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131485AbQKQJuz>; Fri, 17 Nov 2000 04:50:55 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:61188 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S131231AbQKQJui>;
	Fri, 17 Nov 2000 04:50:38 -0500
Date: Fri, 17 Nov 2000 10:20:35 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] dmfe.c network driver update for 2.4
In-Reply-To: <3A145806.FF5F0066@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0011171018130.24487-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Jeff Garzik wrote:

> The kernel driver APIs are designed so that SMP and UP cases are equally
> high-performance, and portable beyond the x86 platform.
> 
> Pretty much all ISA and PCI drivers need to be portable and SMP safe...
> if not so, it's a bug.  That said, there is certainly more motivation to
> make a popular PCI driver is SMP safe than an older ISA driver.  And
> portability is [IMHO] less of a priority than SMP safety, though it
> depends on the hardware being supported.

How about adding an ifdef CONFIG_SMP then print ugly warning to all known
SMP unsafe drivers? A message could be printed booth at compile and load
time.

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

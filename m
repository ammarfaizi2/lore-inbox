Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLSAVU>; Mon, 18 Dec 2000 19:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLSAVK>; Mon, 18 Dec 2000 19:21:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48135 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129391AbQLSAVA>; Mon, 18 Dec 2000 19:21:00 -0500
Subject: Re: Startup IPI (was: Re: test13-pre3)
To: VANDROVE@vc.cvut.cz (Petr Vandrovec)
Date: Mon, 18 Dec 2000 23:51:44 +0000 (GMT)
Cc: macro@ds2.pg.gda.pl (Maciej W. Rozycki),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        mingo@chiara.elte.hu
In-Reply-To: <100F3C80070F@vcnet.vc.cvut.cz> from "Petr Vandrovec" at Dec 19, 2000 12:33:47 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E148A4I-0006RM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah. Just do not read video memory when another CPU starts. I'll try
> disabling cache on both CPUs, maybe it will make some difference, as
> secondary CPU should start with caches disabled. But maybe that it is 
> just broken AGP bus, and nothing else. But until I find what's really
> broken on my hardware, I'd like to leave 'udelay(300)' in.

In the case where it boots does it also report mismatched MTRRs ??

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

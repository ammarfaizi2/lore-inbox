Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQLSTAJ>; Tue, 19 Dec 2000 14:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130511AbQLSS76>; Tue, 19 Dec 2000 13:59:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14084 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129464AbQLSS7s>; Tue, 19 Dec 2000 13:59:48 -0500
Subject: Re: Startup IPI (was: Re: test13-pre3)
To: VANDROVE@vc.cvut.cz (Petr Vandrovec)
Date: Tue, 19 Dec 2000 18:27:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        macro@ds2.pg.gda.pl (Maciej W. Rozycki),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        mingo@chiara.elte.hu
In-Reply-To: <1020BC8D12AC@vcnet.vc.cvut.cz> from "Petr Vandrovec" at Dec 19, 2000 06:03:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E148RTs-0000Hu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In the case where it boots does it also report mismatched MTRRs ??
> 
> Yes, it complains. But BIOS correctly reports x1/x2 depending on
> number of CPUs I plug into motherboard, so I believe that it did
> some initialization before it start loading OS.

That may explain the hangs. Intel docs don't seem to guarantee what happens if 
the MTRRs don't match across CPU's.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

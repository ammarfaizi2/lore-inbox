Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132503AbQLVW4X>; Fri, 22 Dec 2000 17:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132411AbQLVW4O>; Fri, 22 Dec 2000 17:56:14 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:6404 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132465AbQLVW4D>; Fri, 22 Dec 2000 17:56:03 -0500
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200012222224.XAA02297@kufel.dom>
Subject: Re: Fw: max number of ide controllers?
To: kufel!turbolinux.com!adilger@green.mif.pg.gda.pl (Andreas Dilger)
Date: Fri, 22 Dec 2000 23:24:27 +0100 (CET)
Cc: kufel!pcscs.com!chas@green.mif.pg.gda.pl (Charles Wilkins),
        kufel!turbolinux.com!adilger@green.mif.pg.gda.pl (Andreas Dilger),
        kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl (Linux Kernel
	mailing list),
        kufel!vger.kernel.org!linux-raid@green.mif.pg.gda.pl (Linux Raid
	mailing list)
In-Reply-To: <200012222126.eBMLQNY19430@webber.adilger.net> from "Andreas Dilger" at gru 22, 2000 02:26:23 
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Charles Wilkins writes:
> > I have ide.2.2.18.1209.patch applied. The kernel is 2.2.18.
> > So what is the answer? 4 controllers max or 10 for my kernel?
> 
> 10 controllers if you have the IDE patches applied.  4 otherwise.

Look the source Luck ...

2.2.18 ide.c:

static const byte       ide_hwif_to_major[] = {IDE0_MAJOR, IDE1_MAJOR,
IDE2_MAJOR, IDE3_MAJOR, IDE4_MAJOR, IDE5_MAJOR };

6 otherwise

Andrzej

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

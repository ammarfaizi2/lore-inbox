Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130504AbQJaUzj>; Tue, 31 Oct 2000 15:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130562AbQJaUz3>; Tue, 31 Oct 2000 15:55:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41329 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130504AbQJaUzS>; Tue, 31 Oct 2000 15:55:18 -0500
Subject: Re: Update: 2.2.15 SMP problem...
To: babina@pex.net (John Babina III)
Date: Tue, 31 Oct 2000 20:56:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <Pine.LNX.4.20.0010311531060.17340-100000@pioneer.local.net> from "John Babina III" at Oct 31, 2000 03:41:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qiSW-0008Fc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> how much memory you have, is there any patch I can put into a 2.2.x kernel
> or a program to run after bootup to find out the max MEM= setting which is
> appropriate, without having to do blind tests changing the amount until it
> crashes?

There is a patch for E820 memory detection that Orc posted. I've not merged it
because last time I checked it lacked the sanity checks the 2.4 code has to
catch BIOSes that lie.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

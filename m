Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131021AbQL1DFj>; Wed, 27 Dec 2000 22:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbQL1DF3>; Wed, 27 Dec 2000 22:05:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23056 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131021AbQL1DFY>; Wed, 27 Dec 2000 22:05:24 -0500
Subject: Re: Linux 2.2.19pre3
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Thu, 28 Dec 2000 02:37:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001228021859.A4661@emma1.emma.line.org> from "Matthias Andree" at Dec 28, 2000 02:18:59 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14BSwU-00038p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > o	VIA686a timer reset to 18Hz background		(Vojtech Pavlik)
> 
> I patched my 2.2.18-ma2 with that patch to see if that helps me off my
> sys time slowness, but it does unfortunately not help.

Thats unrelated

> I have my system clock drift roughly -1 s/min, though my CMOS clock is
> fine unless tampered with.

Unless its a driver holding off irqs for a long time your only option is
probably to replace the crystals on the board with ones that are more
accurate.

adjtimex will let you tell Linux the clock on the board is crap too

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132480AbRAaRZi>; Wed, 31 Jan 2001 12:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131717AbRAaRZ3>; Wed, 31 Jan 2001 12:25:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62472 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132366AbRAaRZR>; Wed, 31 Jan 2001 12:25:17 -0500
Subject: Re: Looking for comparison data on network stack prowess
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Wed, 31 Jan 2001 17:26:04 +0000 (GMT)
Cc: david@linux.com (David Ford), linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <200101272242.f0RMgme376419@saturn.cs.uml.edu> from "Albert D. Cahalan" at Jan 27, 2001 05:42:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14O11D-0002jM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux did not steal the BSD stack. I recall that Alan Cox
> politely asked UCB to have it under the GPL, and was refused.

Start with the right history then

Ross Biro did the original Linux networking code. At the time the 386BSD code
was potentially useful but two things occurred

1.	I asked a real lawyer about mixing BSD and GPL code and got told the
	advertising clause was an additional restriction

2.	BSDI got sued, making the entire BSD codebase potentially contaminated

Someone in .de (Alas I forget their name now) actually did port BSD net/2 to
Linux.

FvK took over and then I took over and we had net2debugged (no relation to
BSD net/2) and then net/3 and net/4 over time.

The 1.0 networking code worked but certainly wasnt BSD grade, the 1.2 code
worked better but wasnt BSD grade. 2.0 was certainly on a par and 2.2/2.4
have added a lot of other stuff. *BSD has also not stood still.

You can certainly find cases where either is better.

> Oh, BTW, BSD was _not_ the first OS with IP. The first was some
> horrid mainframe thing. Sometimes, he who codes last codes best.

Humph. TOPS-10 is a beautiful OS.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

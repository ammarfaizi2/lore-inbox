Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbQKGMEQ>; Tue, 7 Nov 2000 07:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129246AbQKGMD4>; Tue, 7 Nov 2000 07:03:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61812 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129232AbQKGMDu>; Tue, 7 Nov 2000 07:03:50 -0500
Subject: Re: Pentium 4 and 2.4/2.5
To: fdavis112@juno.com (Frank Davis)
Date: Tue, 7 Nov 2000 12:04:48 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001104.183646.-371331.1.fdavis112@juno.com> from "Frank Davis" at Nov 04, 2000 06:36:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t7Uh-0007JR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I noticed that Pentium 4 isn't an config option in 2.4.0-test10. Is
> someone working on a patch for the the kernel (if needed) to support the
> Pentium 4 after 2.4.0 is released?

And also for 2.2. 2.2.18pre18/19 should ident the CPU fine. A contributed patch
should also report the caches correctly in 2.2.18pre20 once I release it.

The big 2.4 issue is that 2.4 won't work with a CPU running at 2GHz or higher
(2.2.18 will be the first 2.2 kernel handling this). The changes have yet to be
pushed into 2.4. Thus judging by Intels noises so far it will only be early
PIV processors that work ;)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

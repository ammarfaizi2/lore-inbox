Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129117AbQKFApr>; Sun, 5 Nov 2000 19:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQKFAph>; Sun, 5 Nov 2000 19:45:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8002 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129117AbQKFApf>; Sun, 5 Nov 2000 19:45:35 -0500
Subject: Re: rdtsc to mili secs?
To: andrea@suse.de (Andrea Arcangeli)
Date: Mon, 6 Nov 2000 00:46:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), sushil@veritas.com (Sushil Agarwal),
        linux-kernel@vger.kernel.org
In-Reply-To: <20001106013453.A10275@athlon.random> from "Andrea Arcangeli" at Nov 06, 2000 01:34:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13saQP-0005ki-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Nov 06, 2000 at 12:28:00AM +0000, Alan Cox wrote:
> > or running SMP with non matched CPU clocks.
> 
> In this last case I guess he will have more problems than not being able to
> convert from cpu-clock to usec 8). Scheduler and gettimeofday will do the wrong
> thing in that case (scheduler both for bougs avg_slice and fairness).

2.2 handles this case correctly. Ok well at least without bad things happening.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

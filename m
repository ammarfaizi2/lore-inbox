Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129845AbQKFAfN>; Sun, 5 Nov 2000 19:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129838AbQKFAfD>; Sun, 5 Nov 2000 19:35:03 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:10570 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129383AbQKFAez>; Sun, 5 Nov 2000 19:34:55 -0500
Date: Mon, 6 Nov 2000 01:34:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sushil Agarwal <sushil@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: rdtsc to mili secs?
Message-ID: <20001106013453.A10275@athlon.random>
In-Reply-To: <20001106011000.A9787@athlon.random> <E13sa8o-0005jc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E13sa8o-0005jc-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 06, 2000 at 12:28:00AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 12:28:00AM +0000, Alan Cox wrote:
> or running SMP with non matched CPU clocks.

In this last case I guess he will have more problems than not being able to
convert from cpu-clock to usec 8). Scheduler and gettimeofday will do the wrong
thing in that case (scheduler both for bougs avg_slice and fairness).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129514AbQLKSrH>; Mon, 11 Dec 2000 13:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQLKSq5>; Mon, 11 Dec 2000 13:46:57 -0500
Received: from m383-mp1-cvx1c.col.ntl.com ([213.104.77.127]:5124 "EHLO
	[213.104.77.127]") by vger.kernel.org with ESMTP id <S129231AbQLKSqn>;
	Mon, 11 Dec 2000 13:46:43 -0500
To: <scole@lanl.gov>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <00121013363704.01067@spc.esa.lanl.gov>
From: "John Fremlin" <vii@penguinpowered.com>
Date: 11 Dec 2000 18:16:43 +0000
In-Reply-To: Steven Cole's message of "Sun, 10 Dec 2000 13:36:37 -0700"
Message-ID: <m2k896rfg4.fsf@localhost.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Steven Cole <scole@lanl.gov> writes:

[...]

> In each case, the task and the tools used are the same.  The only
> difference was the kernel used. In both cases, 2.2.18 won by 3%.
> Its comparing apples to apples and oranges to oranges. Granted 3%
> isn't very much, but I would have guessed that 2.4.0 would have been
> the winner.  It wasn't, at least for this single processor machine.

Two points: (1) gcc 2.95 makes slightly slower code than egcs-1.1
(according to benchmarks on gcc.gnu.org) so compile 2.4 kernel with
egcs for a fairer comparison. (2) The new VM was a performance
regression for throughput.

I think that it is important that the extent of the indisputable
performance decreases be quantified and traced. For me there was a
subjective performance peak around 2.3.48 IIRC, though it might have
been before. Andrea Archangeli has a VM patch that seems to
help in some cases.

It would be interesting to run a series of (automated) tests on a lot
of kernel versions, and to see how far performance is behind FreeBSD
(or even NetBSD).

[...]

-- 

	http://www.penguinpowered.com/~vii
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

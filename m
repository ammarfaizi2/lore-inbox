Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQKFAKd>; Sun, 5 Nov 2000 19:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129364AbQKFAKO>; Sun, 5 Nov 2000 19:10:14 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23368 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129121AbQKFAKC>; Sun, 5 Nov 2000 19:10:02 -0500
Date: Mon, 6 Nov 2000 01:10:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Sushil Agarwal <sushil@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rdtsc to mili secs?
Message-ID: <20001106011000.A9787@athlon.random>
In-Reply-To: <Pine.SOL.4.05.10011060433030.17401-100000@vxindia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.05.10011060433030.17401-100000@vxindia>; from sushil@veritas.com on Mon, Nov 06, 2000 at 04:39:23AM +0530
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 04:39:23AM +0530, Sushil Agarwal wrote:
> Hi,
>     According to the Intel Arch. Instruction set reference the
> resolution of the "rdtsc" instruction is a clock cycle. How
> do I convert this to mili seconds? 

fast_gettimeoffset_quotient, see do_fast_gettimeoffset().

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

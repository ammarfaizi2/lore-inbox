Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269417AbRHND5b>; Mon, 13 Aug 2001 23:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269786AbRHND5V>; Mon, 13 Aug 2001 23:57:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63499 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269423AbRHND5S>; Mon, 13 Aug 2001 23:57:18 -0400
Date: Mon, 13 Aug 2001 20:56:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (1/11) fs/super.c fixes
In-Reply-To: <Pine.GSO.4.21.0108132126270.10579-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0108132053270.1227-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Aug 2001, Alexander Viro wrote:
>
> 	Linus, I'm resending the second series of superblock handling
> fixes.

Please verify that the patches apply. They don't. Re-sending will not
help, as long as the patches do not actually apply in series.

With these patches, as with the previous batch, the result is:

	patching file fs/super.c
	patching file fs/super.c
	patching file fs/super.c
	Hunk #1 succeeded at 669 (offset 3 lines).
	Hunk #2 succeeded at 834 with fuzz 1 (offset 1 line).
	Hunk #3 succeeded at 886 with fuzz 2 (offset 1 line).
	Hunk #4 FAILED at 950.
	Hunk #5 FAILED at 986.
	Hunk #6 FAILED at 1041.
	Hunk #7 FAILED at 1070.
	Hunk #8 succeeded at 1050 with fuzz 2 (offset -85 lines).
	4 out of 8 hunks FAILED -- saving rejects to file fs/super.c.rej
	... more failures ..

ie serious failures starting with 3/11.

		Linus



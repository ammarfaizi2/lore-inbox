Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270349AbRHNELx>; Tue, 14 Aug 2001 00:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270295AbRHNELm>; Tue, 14 Aug 2001 00:11:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62396 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269786AbRHNELc>;
	Tue, 14 Aug 2001 00:11:32 -0400
Date: Tue, 14 Aug 2001 00:11:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (1/11) fs/super.c fixes
In-Reply-To: <Pine.LNX.4.33.0108132053270.1227-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0108140004450.10579-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Aug 2001, Linus Torvalds wrote:

> 
> On Mon, 13 Aug 2001, Alexander Viro wrote:
> >
> > 	Linus, I'm resending the second series of superblock handling
> > fixes.
> 
> Please verify that the patches apply. They don't. Re-sending will not
> help, as long as the patches do not actually apply in series.

> With these patches, as with the previous batch, the result is:
> 
> 	patching file fs/super.c
> 	patching file fs/super.c
> 	patching file fs/super.c
> 	Hunk #1 succeeded at 669 (offset 3 lines).
> 	Hunk #2 succeeded at 834 with fuzz 1 (offset 1 line).
> 	Hunk #3 succeeded at 886 with fuzz 2 (offset 1 line).
> 	Hunk #4 FAILED at 950.
> 	Hunk #5 FAILED at 986.
> 	Hunk #6 FAILED at 1041.
> 	Hunk #7 FAILED at 1070.
> 	Hunk #8 succeeded at 1050 with fuzz 2 (offset -85 lines).
> 	4 out of 8 hunks FAILED -- saving rejects to file fs/super.c.rej
> 	... more failures ..
> 
> ie serious failures starting with 3/11.

Oh, hell... Looks like I'm in for downloading the tarball over 56K link ;-/
Just in case - md5 of fs/super.c (2.4.9-pre3) here is
3e98e0cc929aebcb186698eae026a0b1.  If it differs from your tree...

_Ouch_.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133006AbRAHV4d>; Mon, 8 Jan 2001 16:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133051AbRAHV4M>; Mon, 8 Jan 2001 16:56:12 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35104 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135192AbRAHVzy>; Mon, 8 Jan 2001 16:55:54 -0500
Date: Mon, 8 Jan 2001 22:56:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Mohammad A. Haque" <mhaque@haque.net>, linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010108225605.Y27646@athlon.random>
In-Reply-To: <20010108213036.T27646@athlon.random> <Pine.GSO.4.21.0101081537570.4061-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0101081537570.4061-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 08, 2001 at 04:08:58PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 04:08:58PM -0500, Alexander Viro wrote:
> 	Andrea, fix your code. Linux-only stuff is OK when there is no

BTW, "rmdir `pwd`" is not portable either.

> portable way to achieve the same result. In your situation such way indeed
> exists and is prefectly doable in userland. If you want a cute DoWhatIMean
> wrapper around rmdir(2) - fine, you've just written one of the variants.

As just said I'm really not concerned about my code.

> Any reasons to keep that in the kernel? None? Thank you, case closed.

I think it would provide nicer semantics as 2.2.x does.  The performance
argument seems irrelevant to me.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

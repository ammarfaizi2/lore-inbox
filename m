Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268864AbRHFQri>; Mon, 6 Aug 2001 12:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268871AbRHFQr2>; Mon, 6 Aug 2001 12:47:28 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:30595 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S268864AbRHFQrV>; Mon, 6 Aug 2001 12:47:21 -0400
Date: Mon, 6 Aug 2001 10:47:16 -0600
Message-Id: <200108061647.f76GlG521620@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.GSO.4.21.0108060723110.13716-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0108060723110.13716-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 	OK, folks - that's it.  By all reasonable standards a year
> _is_ sufficient time to fix an obvious race.  One in
> devfs/base.c::create_entry() had been described to Richard more than
> a year ago.  While I respect the "I'll do it myself, don't spoil the
> fun" stance, it's clearly over the bleedin' top.  Patch for that one
> is in the end of posting.  Linus, see if it looks sane for you.

Well, funny you send this today, Al, as today was supposed to be the
day I start work on fixing a pile of races. I've got the most
important features in before 2.5 is forked, and I've got a free day to
get started on this.

I'll look at your patch after breakfast :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

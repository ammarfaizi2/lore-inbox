Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbRAIMTW>; Tue, 9 Jan 2001 07:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbRAIMTM>; Tue, 9 Jan 2001 07:19:12 -0500
Received: from hera.cwi.nl ([192.16.191.1]:65529 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129773AbRAIMTA>;
	Tue, 9 Jan 2001 07:19:00 -0500
Date: Tue, 9 Jan 2001 13:18:27 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101091218.NAA143674.aeb@texel.cwi.nl>
To: Andries.Brouwer@cwi.nl, andrea@suse.de
Subject: Re: `rmdir .` doesn't work in 2.4
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I trust your specs said so, however I'm not sure which are the specs
> we should follow for Linux.

> At least for LFS 2.2.x fixage I always followed the SuSv2 specs

We are Linux, and free to do whatever we want.
However, following POSIX makes a large body of software available.
It would be very unwise to deviate from POSIX if it can be avoided.

Now POSIX describes only part of Unix, and for other parts we get
our inspiration from SVID, or X/Open, or SUSv2, or by looking at
what other Unix-like systems do, like *BSD*, Solaris, AIX, etc.
But these sources are often contradictory.

The next version of the POSIX standard (which will simultaneously
be SUSv3) is expected a few months from now. As soon as it exists,
we'll want to follow it, as much as possible. Today it doesnt exist,
but in case of doubt it is reasonable to follow the draft.
(And in case the draft is really ridiculous, there is still time
to file a change request.)

Andries


See http://www.opengroup.org/austin/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

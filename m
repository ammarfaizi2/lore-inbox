Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131552AbQK2T12>; Wed, 29 Nov 2000 14:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131678AbQK2T1S>; Wed, 29 Nov 2000 14:27:18 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:594 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S131552AbQK2T1L>; Wed, 29 Nov 2000 14:27:11 -0500
Date: Wed, 29 Nov 2000 19:56:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: corruption
Message-ID: <20001129195630.A6006@athlon.random>
In-Reply-To: <Pine.LNX.4.10.10011282105040.5871-100000@penguin.transmeta.com> <Pine.GSO.4.21.0011290351080.14112-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0011290351080.14112-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Nov 29, 2000 at 04:08:26AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2000 at 04:08:26AM -0500, Alexander Viro wrote:
> Problem fixed by Jens' patch had been there since March, so if it's a

No, it's there only since Jens fixed the request merging bug in test11 or so.

With previous kernel the head pointer couldn't change so that change
was unnecessary and initializing it outside the critical section was
a micro scalability optimization :).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

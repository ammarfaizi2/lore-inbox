Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132089AbQKSBEH>; Sat, 18 Nov 2000 20:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132100AbQKSBD5>; Sat, 18 Nov 2000 20:03:57 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28210 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132089AbQKSBDj>; Sat, 18 Nov 2000 20:03:39 -0500
Date: Sun, 19 Nov 2000 01:33:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 largefile fixes + [f]truncate() error value fix
Message-ID: <20001119013324.F26779@athlon.random>
In-Reply-To: <20001118194058.C24555@athlon.random> <Pine.GSO.4.21.0011181643420.21893-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0011181643420.21893-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Nov 18, 2000 at 04:55:23PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 04:55:23PM -0500, Alexander Viro wrote:
> > 		if (size >> 33) {
>                        ITYM 32 

this is a bug in 2.2.x mainstream btw.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

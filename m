Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbRAJQm0>; Wed, 10 Jan 2001 11:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132738AbRAJQmG>; Wed, 10 Jan 2001 11:42:06 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:55147 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132606AbRAJQmE>; Wed, 10 Jan 2001 11:42:04 -0500
Date: Wed, 10 Jan 2001 17:41:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Chris Mason <mason@suse.com>, Marc Lehmann <pcg@goof.com>,
        reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
        vs@namesys.botik.ru
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE Linux)
Message-ID: <20010110174141.F22197@athlon.random>
In-Reply-To: <75150000.979093424@tiny> <Pine.GSO.4.21.0101092129380.11512-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0101092129380.11512-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Jan 10, 2001 at 12:47:17AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 12:47:17AM -0500, Alexander Viro wrote:
> Chris, I seriously suspect that it's not that simple (read: trace is a
> BS). 0x20b is just too large for filldir().
[..]
> and we don't trigger them... Fsck knows. copy_to_user() and put_user() should
> not be able to screw the kernel stack.

That's what I said Chris yesterday.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

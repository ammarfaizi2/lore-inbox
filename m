Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130371AbRAHRJI>; Mon, 8 Jan 2001 12:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbRAHRIs>; Mon, 8 Jan 2001 12:08:48 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:60269 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129736AbRAHRIk>; Mon, 8 Jan 2001 12:08:40 -0500
Date: Mon, 8 Jan 2001 18:08:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@math.psu.edu>
Subject: `rmdir .` doesn't work in 2.4
Message-ID: <20010108180857.A26776@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Al,

why `rmdir .` is been deprecated in 2.4.x?  I wrote software that depends on
`rmdir .` to work (it's local software only for myself so I don't care that it
may not work on unix) and I'm getting flooded by failing cronjobs since I put
2.4.0 on such machine.  `rmdir .` makes perfect sense, the cwd dentry remains
pinned by me until I `cd ..`, when it gets finally deleted from disk.  I'd like
if we could resurrect such fine feature (adapting userspace is just a few liner
but that isn't the point). Comments?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

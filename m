Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbRAHUaz>; Mon, 8 Jan 2001 15:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbRAHUaf>; Mon, 8 Jan 2001 15:30:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:45845 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129573AbRAHUaY>; Mon, 8 Jan 2001 15:30:24 -0500
Date: Mon, 8 Jan 2001 21:30:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Mohammad A. Haque" <mhaque@haque.net>, linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010108213036.T27646@athlon.random>
In-Reply-To: <20010108185518.G27646@athlon.random> <Pine.GSO.4.21.0101081259230.4061-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0101081259230.4061-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 08, 2001 at 01:04:24PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 01:04:24PM -0500, Alexander Viro wrote:
> Racy. Nonportable. Has portable and simple equivalent. Again, don't
> bother with chdir at all - if you know the name of directory even
> ../name will work. It's not about the current directory. It's about
> the invalid last component of the name.

The last component of the name isn't invalid, it's a plain valid directory. If
according to you `rmdir ../name` and rmdir `pwd` makes sense  then according to
me `rmdir .` makes perfect sense too.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRAIABl>; Mon, 8 Jan 2001 19:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131256AbRAIABb>; Mon, 8 Jan 2001 19:01:31 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:44589 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129752AbRAIABO>; Mon, 8 Jan 2001 19:01:14 -0500
Date: Tue, 9 Jan 2001 01:01:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010109010125.O27646@athlon.random>
In-Reply-To: <20010108185518.G27646@athlon.random> <Pine.GSO.4.21.0101081259230.4061-100000@weyl.math.psu.edu> <20010108213036.T27646@athlon.random> <93dicp$ano$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93dicp$ano$1@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jan 08, 2001 at 03:27:21PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 03:27:21PM -0800, Linus Torvalds wrote:
> However, it is against all UNIX standards, and Linux-2.4 will explicitly

I may be missing something but apparently SuSv2 allows it, you can check here:

	http://www.opengroup.org/onlinepubs/007908799/xsh/rmdir.html

Infact SuSv2 doesn't even allow rmdir to return -EINVAL.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274130AbRISSZc>; Wed, 19 Sep 2001 14:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272341AbRISSZW>; Wed, 19 Sep 2001 14:25:22 -0400
Received: from [195.223.140.107] ([195.223.140.107]:63214 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274130AbRISSZS>;
	Wed, 19 Sep 2001 14:25:18 -0400
Date: Wed, 19 Sep 2001 20:25:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010919202539.E720@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109181122550.9711-100000@penguin.transmeta.com> <Pine.GSO.4.21.0109191205580.28824-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109191205580.28824-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Sep 19, 2001 at 12:11:56PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 12:11:56PM -0400, Alexander Viro wrote:
> the rest.  Andrea, could you send it to me?  In particular, I'm deeply
> suspicious about changes in blkdev_put() in case of BDEV_FILE.

of course, for the record you can also find it in the ftp area all
splitted out, but I've no problem to send it via email too.

Quite frankly the BDEV_* handling was and is a total mess IMHO, even if
it was written by you ;), there was no difference at all from many of
them, I didn't fixed that but I had to check all them on the differences
until I realized there was none. I also think the other things you
mentioned (besides the inode pinning bug, non critical) are not buggy
(infact I never had a single report), but well we'll verify that in
detail ASAP.

Andrea

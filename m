Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273127AbRIJBD4>; Sun, 9 Sep 2001 21:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273126AbRIJBDr>; Sun, 9 Sep 2001 21:03:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:7536 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273120AbRIJBDg>; Sun, 9 Sep 2001 21:03:36 -0400
Date: Mon, 10 Sep 2001 03:04:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010910030405.A11329@athlon.random>
In-Reply-To: <20010910001556Z16150-26183+680@humbolt.nl.linux.org> <Pine.LNX.4.33.0109091724120.22033-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109091724120.22033-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Sep 09, 2001 at 05:38:14PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 05:38:14PM -0700, Linus Torvalds wrote:
> It would definitely make all the issues with Andrea's pagecache code just
> go away completely.

I also recommend to write it on top of the blkdev in pagecache patch
since there I just implemented the "physical address space" abstraction,
I had to write it to make the mknod hda and mknod hda.new to share the
same cache transparently.

Andrea

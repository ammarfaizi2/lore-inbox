Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274662AbRITVj7>; Thu, 20 Sep 2001 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274659AbRITVjv>; Thu, 20 Sep 2001 17:39:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39623 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274657AbRITVjh>;
	Thu, 20 Sep 2001 17:39:37 -0400
Date: Thu, 20 Sep 2001 17:40:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010920231804.C729@athlon.random>
Message-ID: <Pine.GSO.4.21.0109201736550.5631-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Andrea Arcangeli wrote:

> > Sigh... Try BLKFLSBUF + write() + BLKFLSBUF.
> 
> write will return -EIO and second BLKFLSBUF will do nothing.

Now compare that with behaviour of -pre10 (not to mention the
(in)sanity of "this ioctl() will make all IO on the fd fail until
somebody opens the same file" semantics).


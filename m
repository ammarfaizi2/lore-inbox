Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbRGLIU6>; Thu, 12 Jul 2001 04:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267451AbRGLIUs>; Thu, 12 Jul 2001 04:20:48 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23860 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267450AbRGLIUj>; Thu, 12 Jul 2001 04:20:39 -0400
Date: Thu, 12 Jul 2001 10:21:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7pre6aa1
Message-ID: <20010712102105.D779@athlon.random>
In-Reply-To: <20010712101635.C779@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010712101635.C779@athlon.random>; from andrea@suse.de on Thu, Jul 12, 2001 at 10:16:35AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 10:16:35AM +0200, Andrea Arcangeli wrote:
> Only in 2.4.7pre6aa1: 40_blkdev-pagecache-5
> 
> 	Now fixed also initrd, and tested that reads and writes with part of
> 	the page beyond of the end of the device works (assuming userspace
> 	knows where the device ends without relying on the last
> 	readable/writeable byte, kernel doesn't destabilize if you write and
> 	read beyond the end though).

btw, I also made a port of the blkdev in pagecache rev 5 against
2.4.7pre6+o_direct-10. So to test blkdev in pagecache you can also apply
in order:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.7pre5/o_direct-10
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.7pre6/blkdev-pagecache-5

on top of 2.4.7pre6.

Andrea

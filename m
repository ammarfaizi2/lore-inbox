Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbREPNIw>; Wed, 16 May 2001 09:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261932AbREPNIm>; Wed, 16 May 2001 09:08:42 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:32523 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261916AbREPNIf>; Wed, 16 May 2001 09:08:35 -0400
Date: Wed, 16 May 2001 14:54:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: eccesys@topmail.de
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: rwsem, gcc3 again
Message-ID: <20010516145402.B3725@athlon.random>
In-Reply-To: <20010516090327.4A0BFA5A9DA@www.topmail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010516090327.4A0BFA5A9DA@www.topmail.de>; from eccesys@topmail.de on Wed, May 16, 2001 at 11:03:27AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 11:03:27AM +0200, eccesys@topmail.de wrote:
> David,
> I am using the gcc-3.0 snapshot of 14.5.2001 from codesourcery (i686 binary).
> I have now tried to mimic CPU=386 behaviour (patch posted yesterday night)
> and it compiles (just sound fails), by exchanging y and n in
> CONFIG_RWSEM_GENERIC_SPINLOCK and CONFIG_RWSEM_XCHGADD_ALGORITHM.
> 
> Thanks for your patience, all listening...

can you check if the alternate rwsem compiles with gcc 3.0? I had a
report that they don't compile but I checked and that had to be a gcc
3.0 bug, and so I was waiting to hear they start to compile with latest
CVS of gcc 3.0.

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5pre2aa1/00_rwsem-11

Andrea

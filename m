Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131803AbQKCUqb>; Fri, 3 Nov 2000 15:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131829AbQKCUqY>; Fri, 3 Nov 2000 15:46:24 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33044 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131803AbQKCUqM>; Fri, 3 Nov 2000 15:46:12 -0500
Date: Fri, 3 Nov 2000 21:46:13 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Kai Harrekilde-Petersen <Kai.Harrekilde-Petersen@exbit.dk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Value of TASK_UNMAPPED_SIZE on 2.4
Message-ID: <20001103214613.C17349@athlon.random>
In-Reply-To: <fa.d4dt9vv.1gm6abv@ifi.uio.no> <fa.ebii26v.1mgevrq@ifi.uio.no> <80snp8reck.fsf@orthanc.exbit-technology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80snp8reck.fsf@orthanc.exbit-technology.com>; from Kai.Harrekilde-Petersen@exbit.dk on Fri, Nov 03, 2000 at 09:27:07PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 09:27:07PM +0100, Kai Harrekilde-Petersen wrote:
> Is this available as a patch, or preferably as a compilation option to

They're available here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.14/bigmem-large-mapping-1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.14/bigmem-large-task-1.bz2

But they're against 2.2.x + bigmem. The first one is still valid (and it's
similar to the one discussed here). The second one doesn't apply to 2.4.x
and both vmlinux.lds and PAGE_OFFSET should be changed that way to
make it to work there.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

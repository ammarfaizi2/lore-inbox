Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284389AbRLDOmG>; Tue, 4 Dec 2001 09:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284392AbRLDOly>; Tue, 4 Dec 2001 09:41:54 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:10588 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S284349AbRLDOTT>; Tue, 4 Dec 2001 09:19:19 -0500
Date: Tue, 4 Dec 2001 15:18:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Peter Zaitsev <pz@spylog.ru>, theowl@freemail.c3.hu, theowl@freemail.hu,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: your mail on mmap() to the kernel list
Message-ID: <20011204151849.V3447@athlon.random>
In-Reply-To: <3C08A4BD.1F737E36@zip.com.au>, <3C082244.8587.80EF082@localhost>, <3C082244.8587.80EF082@localhost> <61437219298.20011201113130@spylog.ru> <3C08A4BD.1F737E36@zip.com.au> <142576153324.20011203020702@spylog.ru> <3C0ABA9E.5E652392@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C0ABA9E.5E652392@zip.com.au>; from akpm@zip.com.au on Sun, Dec 02, 2001 at 03:34:54PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2001 at 03:34:54PM -0800, Andrew Morton wrote:
> Peter Zaitsev wrote:
> > 
> > ...
> 
> It's very simple.  The kernel has a linked list of vma's for your
> process.  It is kept in address order.  Each time you request a
> new mapping, the kernel walks down that list looking for an address
> at which to place the new mapping.  This data structure is set up
> for efficient find-by-address, not for efficient find-a-gap.

exactly.

Andrea

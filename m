Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279617AbRKIHYK>; Fri, 9 Nov 2001 02:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279627AbRKIHYA>; Fri, 9 Nov 2001 02:24:00 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:29450 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279617AbRKIHXs>; Fri, 9 Nov 2001 02:23:48 -0500
Message-ID: <3BEB8341.2671AEDD@zip.com.au>
Date: Thu, 08 Nov 2001 23:18:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andreas Dilger <adilger@turbolabs.com>, ext2-devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] ext2/ialloc.c cleanup
In-Reply-To: <20011108235632.D907@lynx.no> <Pine.GSO.4.21.0111090210060.9938-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Thu, 8 Nov 2001, Andreas Dilger wrote:
> 
> > It may be possible to hack the test data into ext2 by creating a filesystem
> > with the same number of block groups as the test FFS filesystem with the
> > Smith workload.  It may also not be valid for our needs, as we are playing
> > with the actual group selection algorithm, so real pathnames may give us
> > a different layout.
> 
> Umm...  What was the block and fragment sizes in their tests?

Size: 			502M
Fragment size:		1k
Block size:		8k
Max cluster size:	56k

I haven't been trying to recreate the Smith tests, BTW.  Just using
it as a representative workload and something which is worth
optimising for.

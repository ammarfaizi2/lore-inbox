Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135965AbREJBRU>; Wed, 9 May 2001 21:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135971AbREJBRK>; Wed, 9 May 2001 21:17:10 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:47353 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135965AbREJBRC>; Wed, 9 May 2001 21:17:02 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105100115.f4A1FxaM020439@webber.adilger.int>
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <01051001124700.06492@starship> "from Daniel Phillips at May 10,
 2001 01:12:47 am"
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Wed, 9 May 2001 19:15:58 -0600 (MDT)
CC: john slee <indigoid@higherplane.net>,
        "Mart?n Marqu?s" <martin@bugs.unl.edu.ar>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes:
> The ext2 indexing patch is apparently stable but it's still pre-alpha 
> until the hash function is finalized.  I could see using it to run 
> performance tests of ext2+indexing against the alternatives, but only 
> if you are prepared to rerun mke2fs later.  Then there is the matter of 
> making fsck index-aware.  As it stands now, if fsck finds an index it 
> will remove it.

Actually, I would think e2fsck will simply refuse to run if the COMPAT
flag is set...

> It would be great to see a table of ReiserFS/XFS/Ext2+index performance 
> results.  Well, to make it really fair it should be Ext3+index so I'd 
> better add 'backport the patch to 2.2' or 'bug Stephen and friends to 
> hurry up' to my to-do list.

Actually, Andrew Morton has a nearly working ext3 implementation for 2.4.
It is at the stage where it works most of the time, but we are not yet sure
that everything that needs to be journaled is.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

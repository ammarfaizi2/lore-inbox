Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267379AbRGPXsU>; Mon, 16 Jul 2001 19:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267737AbRGPXsB>; Mon, 16 Jul 2001 19:48:01 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:21233 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267379AbRGPXry>; Mon, 16 Jul 2001 19:47:54 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107162347.f6GNlnLk004959@webber.adilger.int>
Subject: Re: NGROUP increase - thoughts
In-Reply-To: <3B5379A9.6A9B11BE@sun.com> "from Tim Hockin at Jul 16, 2001 04:32:57
 pm"
To: Tim Hockin <thockin@sun.com>
Date: Mon, 16 Jul 2001 17:47:49 -0600 (MDT)
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> I'm sure this has been given thought, so I want to probe teh collective
> resources.  We need to have users in more than 32 groups.  In fact, they
> may need to be a member of MANY more groups than that.
> 
> What is the current thinking on this problem?  Would it be desirable to
> replace current->groups[NGROUPS] with a poibnter to an array?  Thus
> allowing (with libc changes) many more groups?

The real solution is ACLs (if you are talking filesystem permissions).
See acl.bestbits.at, I think, for ext2 ACL/EA patch.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129853AbRAQJZV>; Wed, 17 Jan 2001 04:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130153AbRAQJZL>; Wed, 17 Jan 2001 04:25:11 -0500
Received: from [24.65.192.120] ([24.65.192.120]:45294 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129853AbRAQJY5>;
	Wed, 17 Jan 2001 04:24:57 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101170924.f0H9Odu04425@webber.adilger.net>
Subject: Re: 2.0.37 crashes immediately
In-Reply-To: <Pine.HPX.4.10.10101170957350.29885-100000@stud3.tuwien.ac.at>
 "from Stefan Ring at Jan 17, 2001 10:00:31 am"
To: Stefan Ring <e9725446@student.tuwien.ac.at>
Date: Wed, 17 Jan 2001 02:24:39 -0700 (MST)
CC: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Ring writes:
> Every version above 2.0.36 behaves the same (from the 2.0.x series). Gee,
> I should have said a few words about my intent. Of course, I'm not
> actually using these old versions of everything. I just wanted to run a
> 2.0.x kernel to do some hardware testing, and since 2.0.x can't access the
> new ext2fs with the spare superblock option, I thought, I might be up and
> running fastest by installing a RH distribution still using the 2.0.x
> kernel.

Actually, if you have the 2.0.39 kernel (or a pre-patch), it can use the
sparse ext2 superblock feature.  Even so, it is only a matter of turning the
sparse_super flag on or off and running e2fsck on the filesystem to convert.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLMJYX>; Wed, 13 Dec 2000 04:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbQLMJYO>; Wed, 13 Dec 2000 04:24:14 -0500
Received: from [24.65.192.120] ([24.65.192.120]:40439 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129524AbQLMJX7>;
	Wed, 13 Dec 2000 04:23:59 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012130853.eBD8rQe15407@webber.adilger.net>
Subject: Re: [PATCH] 2.2.18 ext2 large file bug?
In-Reply-To: <Pine.GSO.4.21.0012130324410.3177-100000@weyl.math.psu.edu>
 "from Alexander Viro at Dec 13, 2000 03:42:34 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Wed, 13 Dec 2000 01:53:26 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro writes:
> 	(x>>33) is the same as (x / (1LL<<33)). I.e. _with_ your change it
> becomes "file >= 8Gb", instead of the current (correct) "file >= 2Gb".

OOPS.  My bad.  You are right.  Time to hide head in sand.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129485AbQKVWgG>; Wed, 22 Nov 2000 17:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129514AbQKVWf5>; Wed, 22 Nov 2000 17:35:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16755 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129485AbQKVWfm>; Wed, 22 Nov 2000 17:35:42 -0500
Subject: Re: PROBLEM: Cruft mounting option incorrect in ISOFS code
To: jeffery.s.peel@intel.com (Peel, Jeffery S)
Date: Wed, 22 Nov 2000 22:06:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <9678C2B4D848D41187450090276D1FAE2999D6@FMSMSX32> from "Peel, Jeffery S" at Nov 22, 2000 01:56:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yi1u-0006V9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> under 1 gig in size.  You can exhibit the problem by mounting the dvd movie
> "The World is Not Enough" as it contains a video_ts.vob which is larger than
> 1 gigabyte.  You will see that most of the file lengths are incorrect due to
> the "cruft mounting option" hacking off the high order byte.  There are
> certainly many more movies out there that exhibit this problem so it would
> be a good thing for someone to fix.

The cruft thing is correct in itself. The size being 4Gb is trivial to change
providing someone can provide a reference to the standards that say its ok.
So is the limit 4Gig, who documents it ?

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

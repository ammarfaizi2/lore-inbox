Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267452AbRHAQYX>; Wed, 1 Aug 2001 12:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbRHAQYN>; Wed, 1 Aug 2001 12:24:13 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:63223 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267452AbRHAQYB>; Wed, 1 Aug 2001 12:24:01 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108011623.f71GNpH4006704@webber.adilger.int>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <3B672C6B.9AC418B0@pp.htv.fi> "from Jussi Laako at Aug 1, 2001 01:08:43
 am"
To: Jussi Laako <jlaako@pp.htv.fi>
Date: Wed, 1 Aug 2001 10:23:50 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako writes:
> Just a side note to this discussion.
> 
> I'd be very happy with full data journalling even with 50% performance
> penalty... There are applications that require extreme data integrity all
> times no matter what happens.

Use ext3 then.  It allows full data journaling.  It will even support data
journaling on some files and metadata-only journaling on the rest of the
filesystem (this is currently broken on SMP machines, because not many
people have had a need to use it yet, but it will get fixed).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert


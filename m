Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263430AbREXI6o>; Thu, 24 May 2001 04:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263422AbREXI6f>; Thu, 24 May 2001 04:58:35 -0400
Received: from zeus.kernel.org ([209.10.41.242]:45209 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263425AbREXI6T>;
	Thu, 24 May 2001 04:58:19 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105231808.f4NI8h3T029065@webber.adilger.int>
Subject: Re: lot's of oops's on 2.4.4 in d_lookup/cached_lookup
In-Reply-To: <F349BC4F5799D411ACE100D0B706B3BB768D16@umr-mail03.cc.umr.edu>
 "from Neulinger, Nathan at May 23, 2001 12:10:42 pm"
To: "Neulinger, Nathan" <nneul@umr.edu>
Date: Wed, 23 May 2001 12:08:41 -0600 (MDT)
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan writes:
> I've got a system monitoring box, running 2.4.4 with a few patches (ide,
> inode-nr_unused, max-readahead, knfsd, and a couple of basic tuning opts w/o
> code changes). Basically, the server runs anywhere from a few hours to a few
> days, but always seems to get to a point where it gets tons of the following
> type of oops. It is almost ALWAYS in d_lookup.
> 
> May 23 10:53:44 sysmon kernel: Unable to handle kernel paging request at
> virtual address 96000000

I can't help you with your specific problem, but I'm curious if someone
can explain exactly what "Unable to handle kernel paging request" means?
Is this a bad pointer deference, a page fault for a non-existent page?
Stack corruption or overflow?  What would cause this?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

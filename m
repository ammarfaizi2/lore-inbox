Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131532AbRBWSzd>; Fri, 23 Feb 2001 13:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131651AbRBWSzO>; Fri, 23 Feb 2001 13:55:14 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:28924 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S131532AbRBWSzM>; Fri, 23 Feb 2001 13:55:12 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102231854.f1NIsSR04313@webber.adilger.net>
Subject: Re: filesystem statistics
In-Reply-To: <UTC200102221534.QAA243062.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl"
 at "Feb 22, 2001 04:34:25 pm"
To: Andries.Brouwer@cwi.nl
Date: Fri, 23 Feb 2001 11:54:28 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer writes:
> Now that people are discussing the right hash function to use,
> and the amount of space taken by filenames in various schemes,
> I wondered how these things are on a random machine.
> Here some statistics.

Can you generate statistics on the number of files in each directory,
and the total size of each directory?  For total directory size, it
may be useful to have not only size in kB and/or disk blocks, but also
the sum of raw dentry sizes as well, because directories always show
full block sizes.

This would also be helpful to determine how often indexing will be used
in an "average" system.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129686AbRBYUJI>; Sun, 25 Feb 2001 15:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129691AbRBYUI7>; Sun, 25 Feb 2001 15:08:59 -0500
Received: from mailout4-0.nyroc.rr.com ([24.92.226.120]:53437 "EHLO
	mailout4-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S129686AbRBYUIi>; Sun, 25 Feb 2001 15:08:38 -0500
Message-ID: <3A996644.A5856F14@rochester.rr.com>
Date: Sun, 25 Feb 2001 15:08:36 -0500
From: James D Strandboge <jstrand1@rochester.rr.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac1loop6jds1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: fat problem in 2.4.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bug with truncate in the fat filesystem that was present in 2.4.0,
and fixed with the 2.4.0-ac12 (or earlier) patch is still in the main
(unpatched) kernel, both 2.4.1 and 2.4.2.  The problem is that I cannot
apply the 2.4.0-ac patch to the newer kernels and I cannot patch up to
2.4.1 from 2.4.0 if I already applied the ac patch (so I obviously can't
get to 2.4.2).  I also can't patch from 2.4.0-ac12 to 2.4.1-ac20 using
only ac patches.  Neither of the ac patches for 2.4.1 and 2.4.2 have
this fix for fat, so giving the '-R' option to patch took away the fix.

I would be happy to extract the fix from 2.4.0-ac12, but I am not a
kernel developer and am not sure how many files were changed to fix this
bug.

I want to move up to 2.4.2 for the reiserfs updates and then eventually
to at least 2.4.2-ac2 for the loopback fix (but need the fat
functionality too).

Thanks for any help or suggestions.

James Strandboge
jstrand1@rochester.rr.com


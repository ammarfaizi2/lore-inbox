Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291890AbSBIAZt>; Fri, 8 Feb 2002 19:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287886AbSBIAZk>; Fri, 8 Feb 2002 19:25:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40709 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287872AbSBIAZ0>;
	Fri, 8 Feb 2002 19:25:26 -0500
Message-ID: <3C646C74.4EEC674A@mandrakesoft.com>
Date: Fri, 08 Feb 2002 19:25:24 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Submitting BK patches...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Continuing the BK lovefest a bit...  (hi Andrew)

Here's modifying my patch submission method a bit.  I have taken my
pending changes for you, and split them up into different BK clones. 
Each tree represents a different patch "theme", for different types of
patches being submitted to you:  net driver maintenance stuff is at
http://gkernel.bkbits.net/net-drivers-2.5, filesystem-related stuff can
be stored at fs-2.5, small driver fixes at small-fixes-2.5, etc.  This
gives you a more fine grain from which to 'bk pull'.

It also makes it easier on me as a maintainer, because I can (for
example) continue to push boring maintenance patches to net-drivers-2.5,
which leaving more controversial or unrelated trees untouched.  If you
want to ignore net driver merges for a couple weeks, I can keep pushing
release-quality stuff to net-drivers-2.5, and then you can just 'bk
pull' all the acculumated stuff.

In order to keep the community better in the loop, I'll post the
commented changeset summaries you get, as well as full GNU-style patches
for any changes worth comment.  (in the near future, I'm hoping I can
provide a URL to a plaintext GNU-style patch for each changeset, making
this stuff even more accessible to non-BK users)

The next two e-mails are examples which are ready to be merged.  All BK
changes from me are now under their own URL, http://gkernel.bkbits/... 
You'll note the "pull from" URL at the top of each changeset e-mail.

Comments and questions (from all) welcome...  I'm hoping this sort of
system will (a) make merging and review easier for you, (b) make ongoing
maintenance easier for me, and (c) keep all these changes visible and
easily available to people not using BK.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265420AbUAAWBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265421AbUAAWAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:00:25 -0500
Received: from thunk.org ([140.239.227.29]:58786 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265420AbUAAVvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 16:51:09 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [PATCH] [2.4.24-pre3] 0/5  EXT2/3 Updates
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1AcAhw-0000LE-Ky@thunk.org>
Date: Thu, 01 Jan 2004 16:50:20 -0500
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I would appreciate it if you would consider applying these patches for
2.4.24:

Patch 1:  Fix VM overcommit accounting of truncated pages pinned by ext3
Patch 2:  Fix Compatibility problem with 2.6 SELinux users who try to
        boot 2.4 kernels (from sct)
Patch 3:  Add forward compatibility for on-line resizing
Patch 4:  Add forward compatibility for expanded inodes
Patch 5:  Add HTREE indexed directory support

Most of these patches have been tested for quite a while as independent
patches against 2.4, as well as in Linux 2.6.0.  Patches 2, 3, and 4 add
better forward compatibility for the EXT2 and EXT3 filesystems.  Patch
#5 is the largests, and adds the HTREE support.  This is a roll-up patch
that includes all of the various bugfixes that are in Linux 2.6.0.

(Note: There are some additional 2.4 ext2/3 patches including those for
the Orlov allocator, that are not included in this patch set; the ones
included here are the ones which I believe are most critical for
inclusion in the 2.4 mainline.)


                                                - Ted

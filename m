Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbSJ2Qfm>; Tue, 29 Oct 2002 11:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261611AbSJ2Qfm>; Tue, 29 Oct 2002 11:35:42 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:37088 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S261558AbSJ2Qfl>;
	Tue, 29 Oct 2002 11:35:41 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] 0/11  Ext2/3 Updates: Extended attributes, ACL, etc.
From: tytso@mit.edu
Message-Id: <E186ZRJ-0006tO-00@snap.thunk.org>
Date: Tue, 29 Oct 2002 11:42:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks to Andrew Morton, Andreas Gruenbacher, and others who tested and
made some last-minute cleanups to the ext2/3 patches while I (and
Linus!) were enjoying the warm sun of the Carribean.

The following patches are taken from Andrew Morton's 2.5.44-mm6, with
these changes:  (1) Updated to patch against BK-current, (2) folded the
bugfix ext2-mount-fix.patch into ext23-acl-xattr-11.patch, where it
belongs.

I believe these patches to be ready for inclusion into the 2.5/6 tree.
They've been in Andrew's tree for a while, and should be quite safe if
they are not enabled via CONFIG_EXT[23]_* options.  Linus, please apply.

An updated set of all of these patches can be found at:

	http://thunk.org/tytso/linux/extfs-2.5

						- Ted

P.S.  Some pictures from the Geekcruise <grin> can be found at:

	http://thunk.org/gallery

Not all of them are up yet; only the pictures from the first 2/3 of the
cruise are there.  The rest should follow shortly.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262030AbSJJFEB>; Thu, 10 Oct 2002 01:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262031AbSJJFEB>; Thu, 10 Oct 2002 01:04:01 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:52627 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S262030AbSJJFEB>;
	Thu, 10 Oct 2002 01:04:01 -0400
To: linux-kernel@vger.kernel.org
cc: ext2-devel@sourceforge.net
Subject: [RFC] [PATCH 0/5] ACL support for ext2/3
From: tytso@mit.edu
Message-Id: <E17zVZw-00069U-00@snap.thunk.org>
Date: Thu, 10 Oct 2002 01:09:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch set adds ACL support to the ext2/3 filesystem.  It
is a port of the 0.8.50 patches from Andreas Gruenbacher.  It requires
the Extended Attribute patches which I had sent earlier as a
pre-requisite, and represents the 2nd of 3 sets of patches from the
acl.bestbits.at code.  (The first set was the EA patches; this is the
second set of patches; and the third set of patches adds ACL support to
NFS, so that the NFS server respects the ACL set on the filesystem.)

Some of these patches in this set are shared in common with the XFS
filesystem, and are needed for ACL support in XFS as well.  These
patches are versus 2.5.40, and still reflect the original design
decision of allowing ext2 and ext3 ACL support to be available as
separate standalone modules.  (See the discussion of the EA patches
about whether or not this makes sense.)

Please comment/bleed on these patches.

						- Ted


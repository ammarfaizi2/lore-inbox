Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266316AbSKGDwC>; Wed, 6 Nov 2002 22:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbSKGDwB>; Wed, 6 Nov 2002 22:52:01 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:41089 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S266316AbSKGDwB>;
	Wed, 6 Nov 2002 22:52:01 -0500
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ext2/3 bugfix 0/6: INTRODUCTION
From: tytso@mit.edu
Message-Id: <E189doU-0007GW-00@snap.thunk.org>
Date: Wed, 06 Nov 2002 22:58:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following patches are bug fixes and updates to the ext2/3 filesystem
code.  Please apply them, or pull from 

       bk://extfs.bkbits.net/extfs-2.5-update

This should address some of the filesystem corruption problems with the
htree code that have been reported in the 2.5 kernel sources.

Note that the last patch is substantially similar to the which Andrew
Morton just sent you; he and I happened to end up working on the same
bug in parallel at the same time, and arrivced at the same conclusion
and substantially the same patch.  My patch simplifies the code a bit
more than his does, in that it removing some unused variables, but
either one should fix the problem.

					- Ted

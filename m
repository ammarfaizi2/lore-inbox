Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVEDUw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVEDUw4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVEDUuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:50:17 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:49646 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261649AbVEDUrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:47:49 -0400
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20050504204744.DA0A0849AD@kleikamp.dyn.webahead.ibm.com>
Date: Wed,  4 May 2005 15:47:44 -0500 (CDT)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
I think I've got this set up right.  I have created a HEAD-for-linus and
HEAD-for-mm in the same git repo.

I've got one patch that I'd like in 2.6.12, and I've got some cleanups
that can just stay in -mm for now.
 
Please pull from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git/HEAD-for-linus

This will update the following files:

 fs/jfs/jfs_xtree.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

through these ChangeSets:

commit 6b6bf51081a27e80334e7ebe2993ae1d046a3222
tree 30c44cf22caf3bbe090f333460711f7719e848af
parent 8800cea62025a5209d110c5fa5990429239d6eee
author Dave Kleikamp <shaggy@austin.ibm.com> Wed, 04 May 2005 09:11:49 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 04 May 2005 09:11:49 -0500

    JFS: Endian errors

    Thanks sparse!

    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>


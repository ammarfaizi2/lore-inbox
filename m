Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWHCOjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWHCOjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWHCOjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:39:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:54925 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932484AbWHCOjb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:39:31 -0400
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20060803143737.CF03D82D86@kleikamp.austin.ibm.com>
Date: Thu,  3 Aug 2006 09:37:37 -0500 (CDT)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

This will update the following files:

 fs/jfs/inode.c     |   16 +----
 fs/jfs/jfs_inode.h |    1 
 fs/jfs/super.c     |  118 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 120 insertions(+), 15 deletions(-)

through these ChangeSets:

commit 8bcb2839b74d605f5549962a6e69dc07768e95b6 
tree 3cb69aeaedc8444ed91882ac63714b52a2df6836 
parent 115ff50bade0f93a288677745a5884def6cbf9b1 
author Dave Kleikamp <shaggy@austin.ibm.com> Fri, 28 Jul 2006 08:46:05 -0500 
committer Dave Kleikamp <shaggy@austin.ibm.com> Fri, 28 Jul 2006 08:46:05 -0500 

    JFS: Fix bug in quota code.  tmp_bh.b_size must be initialized
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 115ff50bade0f93a288677745a5884def6cbf9b1 
tree a646404a99d0587ea0113a2c6dad71d7854a84d4 
parent 64821324ca49f24be1a66f2f432108f96a24e596 
author Dave Kleikamp <shaggy@austin.ibm.com> Wed, 26 Jul 2006 14:52:13 -0500 
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 26 Jul 2006 14:52:13 -0500 

    JFS: Quota support broken, no quota_read and quota_write
    
    jfs_quota_read/write are very near duplicates of ext2_quota_read/write.
    
    Cleaned up jfs_get_block as long as I had to change it to be non-static.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>


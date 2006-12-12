Return-Path: <linux-kernel-owner+w=401wt.eu-S1751411AbWLLPQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWLLPQ2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 10:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWLLPQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 10:16:28 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:34907 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbWLLPQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 10:16:27 -0500
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20061212151619.BC95D82E57@kleikamp.austin.ibm.com>
Date: Tue, 12 Dec 2006 09:16:19 -0600 (CST)
From: shaggy@linux.vnet.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

This will update the following files:

 fs/jfs/jfs_filsys.h |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

through these ChangeSets:

Commit: 36b12fb709d229f277efbbe710031d5a429b2412 
Author: Dave Kleikamp <shaggy@austin.ibm.com> Wed, 06 Dec 2006 17:48:32 -0600 

    JFS: Fix conflicting superblock flags
    
    JFS_NOINTEGRITY and JFS_USRQUOTA are defined to be the same value.
    Change JFS_NOINTEGRITY to 0x40 and re-order the flags in the header
    file to avoid repeating this problem.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>


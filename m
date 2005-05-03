Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVECU0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVECU0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 16:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVECU0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 16:26:33 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:39839 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261682AbVECU0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 16:26:32 -0400
Subject: [ANNOUNCE] jfsutils-1.1.8
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: JFS Discussion <jfs-discussion@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 03 May 2005 15:26:28 -0500
Message-Id: <1115151988.8067.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.1.8 of jfsutils was made available today.
 
 This release include the following changes to the utilities:
 
 - fsck should not bail out if reserved (but unused) inode 1 is bad
 - code cleanup - remove unused variables, eliminate compiler warnings
 - Added blocks parameter to jfs_mkfs to specify file system size
 - Ensure that data gets flushed to disk
 - Fix bug in replaying journal that corrupted inodes
 - Update directory index table when moving directory entries
 - Use O_DIRECT when checking for bad blocks (jfs_mkfs -c)

 For more details about JFS, please see our website:
 http://jfs.sourceforge.net
-- 
David Kleikamp
IBM Linux Technology Center


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752367AbWKDDQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbWKDDQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 22:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752317AbWKDDQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 22:16:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:39559 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752311AbWKDDQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 22:16:37 -0500
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20061104030712.DAB8282DB0@kleikamp.austin.ibm.com>
Date: Fri,  3 Nov 2006 21:07:12 -0600 (CST)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

This will update the following files:

 fs/jfs/xattr.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

through these ChangeSets:

Commit: d572b87946f8c598b3cad86a7913862dd48daadb 
Author: Dave Kleikamp <shaggy@austin.ibm.com> Thu, 02 Nov 2006 10:50:40 -0600 

    JFS: Remove redundant xattr permission checking
    
    The vfs handles most permissions for setting and retrieving xattrs.
    This patch removes a redundant and wrong check so that it won't override
    the correct behavior which is being fixed in the vfs.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>


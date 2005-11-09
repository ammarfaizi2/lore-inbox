Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161239AbVKIVlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161239AbVKIVlF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbVKIVlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:41:05 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:16606 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161238AbVKIVlD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:41:03 -0500
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051109214054.C523D82D17@kleikamp.dyn.webahead.ibm.com>
Date: Wed,  9 Nov 2005 15:40:54 -0600 (CST)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, one more.

Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

This will update the following files:

 fs/jfs/namei.c |    3 +++
 1 file changed, 3 insertions(+)

through these ChangeSets:

commit 988a6490a793b73ff23aa3baf87b337152178e4d
tree c12631ad5e0914d52434ea7443bb053103411cd7
parent f2c84c0e84bfa637a7161eac10157cf3b05b4a73
author Dave Kleikamp <shaggy@austin.ibm.com> Mon, 31 Oct 2005 16:53:04 -0600
committer Dave Kleikamp <shaggy@austin.ibm.com> Mon, 31 Oct 2005 16:53:04 -0600

    JFS: set i_ctime & i_mtime on target directory when creating links
    
    jfs has never been setting i_ctime or i_mtime when creating either hard
    or symbolic links.  I'm surprised nobody had noticed until now.
    
    Thanks to Chris Spiegel for reporting the problem.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUDWTxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUDWTxP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 15:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUDWTxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 15:53:14 -0400
Received: from ns.suse.de ([195.135.220.2]:13727 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261156AbUDWTxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 15:53:11 -0400
Subject: [PATCH] reiserfs v3 patches for 2.6.6-rc2
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, akpm@osdl.org
Content-Type: text/plain
Message-Id: <1082750045.12989.199.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Apr 2004 15:54:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Thanks to Andrew for helping to test and feed many of the reiserfs
patches into mainline.  I've rediffed against the current -mm and linus
trees:

ftp.suse.com/pub/people/mason/patches/reiserfs/2.6.6-rc2

The directory includes a series file to tell you the order to apply the
patches.  The same series file should work with -mm kernels as well
right now.

New in this patch set is data=journal support, which fills out the
compatibility list with the 2.4.x reiserfs data logging patches.  Other
patches include:

xattrs and acls (Jeff Mahoney)
warning/error messages that include device names (Jeff Mahoney)
quotas
block allocator improvements
metadata readahead for some types of tree searches

data=journal is experimental, but most of the code changes don't kick in
unless you mount with data=journal.

The rest of the patches should be stable.

-chris



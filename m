Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbUCDXzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 18:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUCDXzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 18:55:18 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:37569 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262011AbUCDXzN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 18:55:13 -0500
Subject: [PATCH] JFS DMAPI
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Blaschke <blaschke@us.ibm.com>
Content-Type: text/plain
Message-Id: <1078444492.9162.56.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 17:54:52 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
Would you consider adding this patch to -mm?  This would add the DMAPI
interface to JFS.  This function has long been requested by HSMs
(Hierarchical Storage Managers).  It is based on SGI's XFS
implementation, but has been clean up to avoid their vnode interface.

Most of the code is in the fs/jfs/dmapi subdirectory.  The amount of
code in the normal jfs codepaths is quite small.  There is no code
outside of fs/jfs.

Due to the size of the patch, I haven't included it here, but it can be
downloaded from
http://www10.software.ibm.com/developer/opensource/jfs/project/pub/dmapi/dmapi-2.6.4-rc2.patch

There is a user library which can be downloaded at
http://oss.software.ibm.com/jfs/

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center


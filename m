Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbUCGR0q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 12:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbUCGR0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 12:26:46 -0500
Received: from c-67-172-209-82.client.comcast.net ([67.172.209.82]:15369 "EHLO
	skarpsey.home.lan") by vger.kernel.org with ESMTP id S262257AbUCGR0p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 12:26:45 -0500
From: Kelledin <kelledin+XFS@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: XFS and ACLs in 2.4.25...what happen?
Date: Sun, 7 Mar 2004 11:26:45 -0600
User-Agent: KMail/1.6
Cc: linux-xfs@oss.sgi.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403071126.45942.kelledin+XFS@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just pulled down kernel 2.4.25 yesterday, thinking I could 
finally move away from a kernel with a separately-maintained XFS 
patchset.  I then went and grabbed the combined ACL/EA patchset 
from acl.bestbits.at and applied it (applying some chunks by 
hand).

Then I went into menuconfig and started choosing options, only to 
discover that there's no checkbox for CONFIG_XFS_POSIX_ACL, no 
listing for it in Configure.help, and no reference to it (even 
commented) in the resulting .config file.  There are still 
#ifdef hooks for it in the fs/xfs stuff though, and there are 
"Extended attributes" for both ext2 and ext3 (as there should 
be)--just none for XFS.  I see no patches to correct this at 
oss.sgi.com either...

So what gives?  What happened to XFS ACL support?

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"

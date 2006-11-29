Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967597AbWK2Tr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967597AbWK2Tr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967599AbWK2Tr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:47:59 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50063 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S967597AbWK2Tr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:47:58 -0500
Date: Wed, 29 Nov 2006 11:51:03 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.18.4
Message-ID: <20061129195103.GB1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.18.4 kernel.
This has just a single security fix (CVE-2006-5751) for the network
bridge code in it.  An unprivileged local user could potentially write
to kernel memory without this fix.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.18.3 and 2.6.18.4, as it is small enough to do so.
                                                                                
The updated 2.6.18.y git tree can be found at:                                  
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y.git 
and can be browsed at the normal kernel.org git web browser:                    
        www.kernel.org/git/                                                     

thanks,
-chris

--------

 Makefile              |    2 +-
 net/bridge/br_ioctl.c |    9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

Summary of changes from v2.6.18.3 to v2.6.18.4
============================================

Chris Wright:
      bridge: fix possible overflow in get_fdb_entries (CVE-2006-5751)
      Linux 2.6.18.4

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWCEVFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWCEVFH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 16:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWCEVFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 16:05:07 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43907 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751018AbWCEVFF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 16:05:05 -0500
Date: Sun, 5 Mar 2006 13:09:04 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.15.6
Message-ID: <20060305210904.GT3883@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.15.6 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.15.5 and 2.6.15.6, as it is small enough to do so.

The updated 2.6.15.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile                     |    2 +-
 arch/ia64/kernel/unaligned.c |    2 +-
 fs/nfs/direct.c              |    7 ++++++-
 include/linux/types.h        |    1 +
 net/core/request_sock.c      |    1 -
 5 files changed, 9 insertions(+), 4 deletions(-)

Summary of changes from v2.6.15.5 to v2.6.15.6
==============================================


Arnaldo Carvalho de Melo:
      Don't reset rskq_defer_accept in reqsk_queue_alloc

Chris Wright:
      fs/nfs/direct.c compile fix
      Linux 2.6.15.6

Dave Jones:
      mempolicy.c compile fix, make sure BITS_PER_BYTE is defined

Tony Luck:
      [IA64] die_if_kernel() can return (CVE-2006-0742)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVFVWSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVFVWSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVFVWOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:14:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262557AbVFVWHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:07:24 -0400
Date: Wed, 22 Jun 2005 15:07:13 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Linux 2.6.12.1
Message-ID: <20050622220713.GV9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.12.1 kernel
which has two security fixes.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.12 and 2.6.12.1, as it is small enough to do so.

The updated 2.6.12.y git tree can be found at:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.12.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

----------

 Makefile                  |    2 +-
 arch/ia64/kernel/ptrace.c |   15 ++++++++++-----
 arch/ia64/kernel/signal.c |    5 +++--
 fs/exec.c                 |    1 +
 4 files changed, 15 insertions(+), 8 deletions(-)

Summary of changes from v2.6.12 to v2.6.12.1
==============================================

Chris Wright:
  Linux 2.6.12.1

Linus Torvalds:
  Clean up subthread exec (CAN-2005-1913)

Matthew Chapman:
  ia64 ptrace + sigrestore_context (CAN-2005-1761)


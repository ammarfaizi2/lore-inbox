Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbVLOUar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVLOUar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbVLOUar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:30:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:218 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751044AbVLOUaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:30:46 -0500
Date: Thu, 15 Dec 2005 12:22:04 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.13.5
Message-ID: <20051215202204.GA18213@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned before, since people had been wanting another old release,
we (the -stable team) are announcing the release of the 2.6.13.5 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.13.4 and 2.6.13.5, as it is small enough to do so.

The updated 2.6.13.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.13.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                           |    2 
 arch/s390/appldata/appldata_base.c |    7 +
 arch/sparc64/kernel/irq.c          |    1 
 include/linux/proc_fs.h            |    1 
 include/linux/sysctl.h             |    3 
 kernel/sysctl.c                    |  136 +++++++++++++++++++++++++++++--------
 net/bridge/br_if.c                 |    2 
 7 files changed, 119 insertions(+), 33 deletions(-)

Summary of changes from v2.6.13.4 to v2.6.13.5
==============================================

Al Viro:
      CVE-2005-2709 sysctl unregistration oops

Greg Kroah-Hartman:
      Linux 2.6.13.5

Stephen Hemminger:
      br: fix race on bridge del if

Sven Hartge:
      Fix compile error in irq.c


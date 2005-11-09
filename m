Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbVKIBIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbVKIBIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 20:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030495AbVKIBIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 20:08:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:22731 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030493AbVKIBIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 20:08:34 -0500
Date: Tue, 8 Nov 2005 17:07:29 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.14.1
Message-ID: <20051109010729.GA22439@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.14.1 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.14 and 2.6.14.1, as it is small enough to do so.

The updated 2.6.14.y git tree can be found at:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.14.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                           |    2 
 arch/s390/appldata/appldata_base.c |    7 +
 include/linux/proc_fs.h            |    1 
 include/linux/sysctl.h             |    3 
 kernel/sysctl.c                    |  136 +++++++++++++++++++++++++++++--------
 5 files changed, 117 insertions(+), 32 deletions(-)


Summary of changes from v2.6.13.3 to v2.6.13.4
============================================

Al Viro:
      CVE-2005-2709 sysctl unregistration oops

Greg Kroah-Hartman:
      Linux 2.6.14.1


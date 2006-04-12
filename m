Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWDLUfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWDLUfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 16:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWDLUfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 16:35:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:33194 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932233AbWDLUfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 16:35:15 -0400
Date: Wed, 12 Apr 2006 13:33:58 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.5
Message-ID: <20060412203358.GA10641@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.5 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.4 and 2.6.16.5, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                   |    2 +-
 arch/x86_64/kernel/entry.S |   28 ++++++++++------------------
 2 files changed, 11 insertions(+), 19 deletions(-)


Summary of changes from v2.6.16.4 to v2.6.16.5
==============================================

Andi Kleen:
      x86_64: Clean up execve
      x86_64: When user could have changed RIP always force IRET (CVE-2006-0744)

Greg Kroah-Hartman:
      Linux 2.6.16.5


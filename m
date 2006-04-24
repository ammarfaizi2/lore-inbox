Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWDXUfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWDXUfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWDXUfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:35:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:25556 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751250AbWDXUfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:35:42 -0400
Date: Mon, 24 Apr 2006 13:33:58 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.11
Message-ID: <20060424203358.GA17597@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.11 kernel
(because just one -stable kernel a day is obviously not enough...)

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.10 and 2.6.16.11, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile      |    2 +-
 fs/cifs/dir.c |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

Summary of changes from v2.6.16.10 to v2.6.16.11
================================================

Greg Kroah-Hartman:
      Linux 2.6.16.11

Steve French:
      Don't allow a backslash in a path component (CVE-2006-1863)


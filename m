Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWDREYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWDREYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 00:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWDREYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 00:24:11 -0400
Received: from mail.suse.de ([195.135.220.2]:54914 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932180AbWDREYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 00:24:10 -0400
Date: Mon, 17 Apr 2006 21:23:00 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.7
Message-ID: <20060418042300.GA11061@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.7 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.6 and 2.6.16.7, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

Note, there seems to be a bit of a discrepancy in the assigning of CVE
numbers to a specific issue that was solved in this release.  The
original author and I both asked for CVE numbers for different patches
and seem to have gotten the same one.  Please note that these are two
different issues, yet, the same CVE number.  Hopefully it gets fixed
eventually for those who like to track these kinds of things...

thanks,

greg k-h

--------

 Makefile     |    2 +-
 mm/madvise.c |    3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)


Summary of changes from v2.6.16.6 to v2.6.16.7
==============================================

Greg Kroah-Hartman:
      Linux 2.6.16.7

Hugh Dickins:
      fix MADV_REMOVE vulnerability (CVE-2006-1524 for real this time)


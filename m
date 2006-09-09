Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWIIDdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWIIDdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 23:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWIIDdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 23:33:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:23430 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932109AbWIIDdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 23:33:12 -0400
Date: Fri, 8 Sep 2006 20:33:00 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.17.13
Message-ID: <20060909033300.GA8960@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.17.13 kernel.

This fixes two build errors with the 2.6.17.12 release.  If you aren't
experiencing them, there is no need to upgrade.  We are very sorry for
for the mistakes that happened with the .12 release, and those
responsible have been sacked.

I'll also be replying to this message with a copy of the patch between
2.6.17.12 and 2.6.17.13, as it is small enough to do so.

The updated 2.6.17.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                |    2 +-
 include/linux/idr.h     |    1 +
 include/linux/pci_ids.h |    5 ++++-
 lib/idr.c               |   43 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 2 deletions(-)

Summary of changes from v2.6.17.12 to v2.6.17.13
================================================

Alan Cox:
      pci_ids.h: add some VIA IDE identifiers

Greg Kroah-Hartman:
      Linux 2.6.17.13

Jeff Mahoney:
      lib: add idr_replace


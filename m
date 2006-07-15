Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbWGOUM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWGOUM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 16:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWGOUMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 16:12:09 -0400
Received: from tomts47-srv.bellnexxia.net ([209.226.175.191]:5263 "EHLO
	tomts47-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1030324AbWGOUMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 16:12:03 -0400
Date: Sat, 15 Jul 2006 13:08:56 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.16.26
Message-ID: <20060715200856.GA15036@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.26 kernel.

This should fix the reported issue of NetworkManager dying when using
the 2.6.16.25 kernel release.  All users of the 2.6.16 kernel are
recommended to upgrade to this kernel, as it fixes a publicly known
security issue that can provide root access to any local user of the
machine.

I'll also be replying to this message with a copy of the patch between
2.6.16.25 and 2.6.16.26, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile       |    2 +-
 fs/proc/base.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

Summary of changes from v2.6.16.25 to v2.6.16.26
================================================

Greg Kroah-Hartman:
      Linux 2.6.16.25

Linus Torvalds:
      Relax /proc fix a bit


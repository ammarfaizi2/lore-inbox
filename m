Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVEQEl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVEQEl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 00:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVEQEjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 00:39:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:20204 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261687AbVEQEhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 00:37:50 -0400
Date: Mon, 16 May 2005 21:37:00 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@linux.kernel.org
Subject: [GIT PATCH] Stable bugfixes for 2.6.12-rc4
Message-ID: <20050517043700.GA17349@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the patches that were in the 2.6.11.9 and 2.6.11.10 releases,
syncing up your tree with the -stable tree.  (I can't base the -stable
tree off of your git tree due to the lack of a "real" 2.6.11 in your
tree, this will change once 2.6.12 is out.)

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/stable-2.6.git/

Full patches will be sent to the linux-kernel mailing list, if anyone
wants to see them.

thanks,

greg k-h

 drivers/block/ioctl.c   |    2 ++
 drivers/block/pktcdvd.c |    4 ++--
 drivers/char/raw.c      |    2 +-
 fs/binfmt_elf.c         |    4 ++--
 4 files changed, 7 insertions(+), 5 deletions(-)

------------
Greg Kroah-Hartman:
  o fix Linux kernel ELF core dump privilege elevation

Peter Osterlund:
  o Fix root hole in pktcdvd

Stephen C. Tweedie:
  o Fix root hole in raw device



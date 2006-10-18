Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWJRUGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWJRUGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWJRUGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:06:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:4325 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932111AbWJRUGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:06:42 -0400
Date: Wed, 18 Oct 2006 13:04:33 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ecashin@coraid.com
Subject: [GIT PATCH] AOE fixes and update for 2.6.19-rc2
Message-ID: <20061018200433.GA10079@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some ATA over Ethernet patches against your current git tree.
They all have been in the -mm tree for a few months.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 drivers/block/aoe/aoe.h     |   30 ++--
 drivers/block/aoe/aoeblk.c  |   44 +++---
 drivers/block/aoe/aoechr.c  |   18 +--
 drivers/block/aoe/aoecmd.c  |  303 ++++++++++++++++++++++++++++---------------
 drivers/block/aoe/aoedev.c  |   52 +++++--
 drivers/block/aoe/aoemain.c |   10 +
 drivers/block/aoe/aoenet.c  |    9 +
 7 files changed, 287 insertions(+), 179 deletions(-)

---------------

Ed L Cashin:
      aoe: eliminate isbusy message
      aoe: update copyright date
      aoe: remove unused NARGS enum
      aoe: zero copy write 1 of 2
      aoe: jumbo frame support 1 of 2
      aoe: clean up printks via macros
      aoe: jumbo frame support 2 of 2
      aoe: improve retransmission heuristics
      aoe: zero copy write 2 of 2
      aoe: module parameter for device timeout
      aoe: use bio->bi_idx
      aoe: remove sysfs comment
      aoe: update driver version
      aoe: revert printk macros

Greg Kroah-Hartman:
      aoe: fix sysfs_create_file warnings


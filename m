Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVILUPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVILUPv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVILUPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:15:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:30149 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932205AbVILUP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:15:28 -0400
Date: Mon, 12 Sep 2005 13:10:35 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] More Driver patches for 2.6.13
Message-ID: <20050912201035.GA20330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more small driver patches for 2.6.13.  The fix up the
comments in the crc16 code, update the aoe driver, and fix up some
firmware documentation.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

The full patch set will be sent to the linux-kernel mailing lists, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/aoe/mkshelf.sh                          |    6 ++++--
 Documentation/firmware_class/firmware_sample_driver.c |    8 ++++----
 drivers/block/aoe/aoe.h                               |   12 ++++++------
 drivers/w1/w1_ds2433.c                                |    6 +++++-
 include/linux/crc16.h                                 |   16 +---------------
 5 files changed, 20 insertions(+), 28 deletions(-)


Christophe Lucas:
  printk : Documentation/firmware_class/firmware_sample_driver.c

Ed L Cashin:
  aoe [1/2]: support 16 AoE slot addresses per AoE shelf
  aoe [2/2]: update driver version number to twelve

Evgeniy Polyakov:
  crc16: remove w1 specific comments.


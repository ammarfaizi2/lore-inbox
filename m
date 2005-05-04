Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVEDHW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVEDHW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVEDHO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:14:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:60393 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262063AbVEDHLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:11:43 -0400
Date: Wed, 4 May 2005 00:10:23 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] AOE bugfixes for 2.6.12-rc3
Message-ID: <20050504071023.GA18043@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a number of AOE bugfixes for 2.6.12-rc3.  They have all been in
the last few -mm releases.

Pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/

Full patches will be sent to the linux-kernel mailing lists, if anyone
wants to see them.

thanks,

greg k-h

-------------

 Documentation/aoe/aoe.txt   |   52 +++++++++++++++++++++++++++++++++++---------
 Documentation/aoe/status.sh |    4 ---
 drivers/block/aoe/aoe.h     |    2 -
 drivers/block/aoe/aoeblk.c  |   13 +++++++++++
 drivers/block/aoe/aoedev.c  |   11 +++------
 drivers/block/aoe/aoenet.c  |   17 +++++++++++++-
 6 files changed, 76 insertions(+), 23 deletions(-)

Ed L. Cashin:
  o aoe: update version number to 10
  o aoe: add firmware version to info in sysfs
  o aoe: allow multiple aoe devices to have the same mac
  o aoe: update the documentation to mention aoetools
  o aoe: aoe-stat should work for built-in as well as module
  o aoe: improve allowed interfaces configuration


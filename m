Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbWBNGrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbWBNGrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWBNGrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:47:16 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:28596
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030499AbWBNGrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:47:15 -0500
Date: Mon, 13 Feb 2006 22:47:18 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: [GIT PATCH] I2C and hwmon patches for 2.6.16-rc3
Message-ID: <20060214064718.GA20228@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some i2c and hwmon patches for 2.6.16-rc3.  They all fix bugs
that are currently present in the tree.  All but one of these patches
have been in the last few -mm releases.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/hwmon/w83627hf |    4 ++++
 drivers/hwmon/it87.c         |    3 ++-
 drivers/hwmon/vt8231.c       |    8 ++++----
 drivers/hwmon/w83781d.c      |   43 +++++++++++++++++++++++++------------------
 drivers/i2c/busses/i2c-isa.c |   12 ------------
 5 files changed, 35 insertions(+), 35 deletions(-)


Jean Delvare:
      vt8231: Fix sysfs temperature interface
      w83781d: Use real-time status registers
      w83627hf: Document the reset module parameter
      it87: Fix oops on removal
      i2c: Drop outdated probe/remove code in i2c-isa


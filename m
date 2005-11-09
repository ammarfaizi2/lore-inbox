Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161275AbVKIWD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161275AbVKIWD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161277AbVKIWDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:03:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:29317 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161292AbVKIWDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:03:15 -0500
Date: Wed, 9 Nov 2005 14:02:35 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: [GIT PATCH] More I2C and hwmon patches for 2.6.14 - try 2
Message-ID: <20051109220235.GB8729@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some small i2c and hwmon patches.  They fix some bugs that were
caused by the previous round of i2c patches, and should go in before
2.6.15-rc1 is out.  Most of these are in the last -mm release.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series was sent already to sensors mailing list, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/i2c/busses/i2c-viapro |    6 ++----
 Documentation/i2c/writing-clients   |    4 ++--
 drivers/hwmon/w83627hf.c            |   16 ++++------------
 drivers/i2c/busses/i2c-viapro.c     |   27 ++++++++++++++-------------
 drivers/i2c/chips/ds1337.c          |    4 ++--
 5 files changed, 24 insertions(+), 33 deletions(-)

James Chapman:
      i2c: ds1337 BCD conversion fix

Jean Delvare:
      i2c: writing-client doc update complement
      i2c-viapro: Some adjustments

Yuan Mu:
      hwmon: Fix two w83627hf bugs


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUDVW3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUDVW3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 18:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUDVW3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 18:29:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:17839 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263429AbUDVW3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 18:29:11 -0400
Date: Thu, 22 Apr 2004 15:28:53 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core fixes for 2.6.6-rc2
Message-ID: <20040422222853.GA2932@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are two driver core fixes for 2.6.6-rc2, along with a tipar.c
driver fix.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 drivers/base/firmware_class.c |    2 +-
 drivers/char/tipar.c          |    2 +-
 drivers/i2c/chips/eeprom.c    |    1 +
 drivers/scsi/qla2xxx/qla_os.c |    2 ++
 fs/sysfs/bin.c                |   16 +++++++++++++---
 fs/sysfs/symlink.c            |    6 +++---
 6 files changed, 21 insertions(+), 8 deletions(-)
-----


<mebrown:michaels-house.net>:
  o sysfs module unload race fix for bin_attributes

Linda Xie:
  o symlink doesn't support kobj name > 20 charaters (KOBJ_NAME_LEN)

Romain Lievin:
  o tipar char driver: wrong timeout value


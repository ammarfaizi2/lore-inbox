Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbUKSX0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUKSX0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUKSX0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:26:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:65432 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261635AbUKSWAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:00:00 -0500
Date: Fri, 19 Nov 2004 13:59:35 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] I2C fixes for 2.6.10-rc2
Message-ID: <20041119215935.GA15956@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver fixes for 2.6.10-rc2.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 Documentation/i2c/writing-clients     |   20 ++++++++++++++++----
 drivers/i2c/busses/Kconfig            |    1 +
 drivers/i2c/busses/i2c-amd756-s4882.c |    7 +++++--
 drivers/i2c/busses/i2c-nforce2.c      |    9 ++++-----
 drivers/i2c/chips/smsc47m1.c          |   29 +++++++++++++++++++++--------
 drivers/i2c/i2c-core.c                |   20 --------------------
 include/linux/pci_ids.h               |    2 ++
 7 files changed, 49 insertions(+), 39 deletions(-)
-----


<thomas:plx.com>:
  o I2C: i2c-nforce2.c add support for nForce3 Pro 150 MCP

Gabriel Paubert:
  o I2C: minor comment fix

Jean Delvare:
  o I2C: Cleanups to the recent smbus functions removal
  o I2C: Fixes to the i2c-amd756-s4882 driver
  o I2C: Do not register useless smsc47m1


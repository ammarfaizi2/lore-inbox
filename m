Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTFWXlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTFWXjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:39:48 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:65187 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264374AbTFWXhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:37:48 -0400
Date: Mon, 23 Jun 2003 16:49:39 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver changes for 2.5.73
Message-ID: <20030623234939.GA11901@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver changes for 2.5.73.  They add two new i2c bus
controller drivers.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/Kconfig              |   20 +
 drivers/i2c/Makefile             |    1 
 drivers/i2c/busses/Kconfig       |   16 +
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-ali1535.c |  555 +++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-prosavage.c      |  362 +++++++++++++++++++++++++
 6 files changed, 955 insertions(+)
-----

<henk:god.dyndns.org>:
  o I2C: add i2c-prosavage driver

Greg Kroah-Hartman:
  o I2C: add i2c-ali1535 bus driver


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTEIXmN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTEIXmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:42:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:460 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263586AbTEIXke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:40:34 -0400
Date: Fri, 9 May 2003 16:55:04 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] More i2c driver changes for 2.5.69
Message-ID: <20030509235504.GD3517@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more minor i2c fixups for 2.5.69.  They are basically a
bunch of fixes for the it87 driver, and a few other minor changes.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/chips/it87.c |  195 +++++++++++++++++++++++------------------------
 drivers/i2c/i2c-core.c   |   33 ++++++-
 include/linux/i2c.h      |   13 +--
 3 files changed, 133 insertions(+), 108 deletions(-)
-----

<warp:mercury.d2dc.net>:
  o I2C: And another it87 patch
  o I2C: Yet another it87 patch
  o I2C: Another it87 patch

Greg Kroah-Hartman:
  o i2c: register the i2c_adapter_driver so things link up properly in sysfs
  o i2c: add i2c_adapter class support

Mark W. McClelland:
  o I2C: add more classes


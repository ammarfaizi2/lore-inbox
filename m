Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTLDWbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTLDWaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:30:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:60119 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263622AbTLDWaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:30:00 -0500
Date: Thu, 4 Dec 2003 14:27:52 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver fix for 2.6.0-test11
Message-ID: <20031204222752.GA2541@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a i2c driver fixes for 2.6.0-test11.  It fixes an problem in the
i2c-nforce2 driver when it is used to talk to the eeprom i2c driver.

Please pull from:  bk://linuxusb.bkbits.net/i2c-2.6

thanks,

greg k-h

 drivers/i2c/busses/i2c-nforce2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
-----

Jean Delvare:
  o I2C: fix i2c_smbus_write_byte() for i2c-nforce2


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263950AbTJOS26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTJOS1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:27:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:57777 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263932AbTJOS0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:26:18 -0400
Date: Wed, 15 Oct 2003 11:04:56 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] More i2c driver fixes for 2.6.0-test7
Message-ID: <20031015180456.GA22107@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more minor i2c driver fixes for 2.6.0-test7.  They fix
some bugs in the w83781d.c driver, and remove some unneeded MOD_INC and
MOD_DEC calls (which fixes some compiler warnings.)

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

thanks,

greg k-h

------

Greg Kroah-Hartman:
  o I2C: fix more define problems in w83781d driver
  o I2C: remove unneeded MOD_INC and MOD_DEC calls

Luca Tettamanti:
  o I2C: sensors/w83781d.c creates useless sysfs entries


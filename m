Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263567AbUDZVA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUDZVA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 17:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUDZVA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 17:00:57 -0400
Received: from mail.kroah.org ([65.200.24.183]:31906 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263563AbUDZVA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 17:00:56 -0400
Date: Mon, 26 Apr 2004 14:00:21 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] 2 more USB fixes for 2.6.6-rc2
Message-ID: <20040426210021.GA27461@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are two small patches that fix an oops in the usb hiddev driver.
This oops was exposed due to a sysfs patch that I previously sent you
(that patch was correct, the hiddev driver was wrong...)  They have been
acked by Vojtech.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/fix-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/input/hiddev.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)
-----

Greg Kroah-Hartman:
  o USB: further cleanup of the hiddev driver, fixing another possible oops on disconnect
  o USB: fix up fake usb_interface structure in hiddev


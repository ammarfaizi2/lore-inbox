Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVBQUXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVBQUXf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVBQUXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:23:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:41904 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261158AbVBQUXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:23:31 -0500
Date: Thu, 17 Feb 2005 12:23:19 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] 2 More USB fixes for 2.6.11-rc4
Message-ID: <20050217202319.GA13944@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, Pete just told me today that these two patches should go in before
2.6.11 comes out, sorry for not adding them to the USB patches from
yesterday.  They both fix bugs in the ub driver, and have been in the
past few -mm releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/fix-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h


 drivers/block/ub.c |  197 ++++++++++++++++++++++++++++++++---------------------
 1 files changed, 120 insertions(+), 77 deletions(-)
-----


Pete Zaitcev:
  o ub: fix Add ioctls to ub patch
  o USB: Add ioctls to ub


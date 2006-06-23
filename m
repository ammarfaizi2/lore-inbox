Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWFWGAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWFWGAr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 02:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWFWGAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 02:00:47 -0400
Received: from ns2.suse.de ([195.135.220.15]:53143 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932352AbWFWGAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 02:00:46 -0400
Date: Thu, 22 Jun 2006 22:57:37 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes for suspend issues
Message-ID: <20060623055737.GA29631@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the two patches that fix the suspend issue and the USB oops
issue in your current tree.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 drivers/base/core.c    |   19 +++++++++++--------
 drivers/usb/core/usb.c |    2 ++
 2 files changed, 13 insertions(+), 8 deletions(-)

---------------

Greg Kroah-Hartman:
      USB: get USB suspend to work again
      Driver core: fix locking issues with the devices that are attached to classes


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVEEG7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVEEG7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 02:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVEEG5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 02:57:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:21158 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261937AbVEEG5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 02:57:22 -0400
Date: Wed, 4 May 2005 23:56:09 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] driver core bugfixes for 2.6.12-rc3
Message-ID: <20050505065609.GA838@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two driver core bugfixes for 2.6.12-rc3.

Pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Full patches will be sent to the linux-kernel mailing lists, if anyone
wants to see them.

thanks,

greg k-h

-------------

 drivers/base/bus.c  |    5 ++---
 drivers/base/core.c |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

Alexander Nyberg:
  o Hotplug: Make dev->bus checking consistent

Roman Kagan:
  o drivers/base/bus.c: fix iteration in driver_detach()



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVEPSaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVEPSaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVEPSaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:30:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:18893 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261780AbVEPS3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:29:55 -0400
Date: Mon, 16 May 2005 11:25:45 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Linux 2.6.11.10
Message-ID: <20050516182544.GA9960@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a recently announced security issue with the current kernel, we
(the -stable team) are announcing the release of the 2.6.11.10 kernel.

The diffstat and short summary of the fixes are below.  

I'll also be replying to this message with a copy of the patch between
2.6.11.9 and 2.6.11.10, as it is small enough to do so.

Also, the 2.6.11.y tree is now being kept in git.  It can be found at:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.11.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

----------
 Makefile                |    2 +-
 drivers/block/ioctl.c   |    2 ++
 drivers/block/pktcdvd.c |    4 ++--
 drivers/char/raw.c      |    2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

Summary of changes from v2.6.11.9 to v2.6.11.10
==============================================

Dave Jones:
  o Fix root hole in raw device

Greg Kroah-Hartman:
  o Linux 2.6.11.10

Peter Osterlund:
  o Fix root hole in pktcdvd


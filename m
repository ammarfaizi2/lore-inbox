Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVCJAzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVCJAzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVCJAx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:53:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:60063 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262635AbVCJAmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:35 -0500
Date: Wed, 9 Mar 2005 16:18:12 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] AOE fixes for 2.6.11
Message-ID: <20050310001812.GA31984@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some AOE driver fixes and documentation updates.  These have
all been in the -mm releases for a while.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/2.6.11/aoe

Individual patches will follow, sent to the linux-kernel list.

thanks,

greg k-h

 Documentation/aoe/aoe.txt         |   13 +++++++++---
 Documentation/aoe/status.sh       |    7 ++++--
 Documentation/aoe/udev-install.sh |   36 ++++++++++++++++++++++++++++-----
 Documentation/aoe/udev.txt        |   23 +++++++++++++++++++++
 drivers/block/aoe/aoe.h           |    1 
 drivers/block/aoe/aoechr.c        |   41 ++------------------------------------
 drivers/block/aoe/aoecmd.c        |    8 ++++---
 7 files changed, 77 insertions(+), 52 deletions(-)
-----


Alexander Nyberg:
  o AoE warning on 64-bit archs

Ed L. Cashin:
  o aoe: drivers/block/aoe/aoechr.c cleanups
  o aoe status.sh: handle sysfs not in /etc/mtab
  o aoe: fail IO on disk errors
  o aoe: update documentation for udev users
  o aoe: add documentation for udev users


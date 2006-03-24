Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422719AbWCXGJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbWCXGJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423162AbWCXGJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:09:32 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:23688
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1422719AbWCXGJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:09:32 -0500
Date: Thu, 23 Mar 2006 22:09:05 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ecashin@coraid.com
Subject: [GIT PATCH] AOE patches for 2.6.16
Message-ID: <20060324060905.GA20310@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some ATA over Ethernet patches against your current git tree.
They all have been in the -mm tree for a few months.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/aoe/mkdevs.sh |    2 
 Documentation/aoe/udev.txt  |    1 
 drivers/block/aoe/aoe.h     |   14 +--
 drivers/block/aoe/aoeblk.c  |   22 ++---
 drivers/block/aoe/aoechr.c  |   37 ++++++++
 drivers/block/aoe/aoecmd.c  |  187 +++++++++++++++++++++++++++++---------------
 drivers/block/aoe/aoedev.c  |   69 +++++++++++-----
 drivers/block/aoe/aoemain.c |    4 
 drivers/block/aoe/aoenet.c  |   22 +----
 9 files changed, 238 insertions(+), 120 deletions(-)

---------------

Ed L Cashin:
      aoe [1/8]: zero packet data after skb allocation
      aoe [2/8]: support dynamic resizing of AoE devices
      aoe [3/8]: increase allowed outstanding packets
      aoe [4/8]: use less confusing driver name
      aoe [5/8]: allow network interface migration on packet retransmit
      aoe [6/8]: update device information on last close
      aoe [7/8]: update driver compatibility string
      aoe [8/8]: update driver version number
      aoe: do not stop retransmit timer when device goes down
      aoe [1/3]: support multiple AoE listeners
      aoe [2/3]: don't request ATA device ID on ATA error
      aoe [3/3]: update version to 22


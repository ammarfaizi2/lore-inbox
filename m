Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbTCYRqK>; Tue, 25 Mar 2003 12:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263155AbTCYRqK>; Tue, 25 Mar 2003 12:46:10 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:35085 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263143AbTCYRqI>; Tue, 25 Mar 2003 12:46:08 -0500
Date: Tue, 25 Mar 2003 17:57:18 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Framebuffer updates. 
Message-ID: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As usually I have a patch avalaible at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

 drivers/video/aty/aty128fb.c  |   16 +++++++---------
 drivers/video/console/fbcon.c |    4 ++--
 drivers/video/controlfb.c     |   18 +++---------------
 drivers/video/platinumfb.c    |   28 ++++++++--------------------
 drivers/video/radeonfb.c      |   10 ++++++++++
 drivers/video/softcursor.c    |    2 +-
 6 files changed, 31 insertions(+), 47 deletions(-)

The patch has updates for the ATI Rage 128, Control, and Platnium 
framebuffer driver. The Radeon patch adds PLL times for the R* series of
cards. Memory is now safe to allocate for the software cursor and inside 
fbcon. There still are issues with syncing which cause the cursor on some 
systems to become corrupt sometimes. 




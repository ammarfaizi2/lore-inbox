Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUCBUCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 15:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUCBUCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 15:02:08 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:59397 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261755AbUCBUCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 15:02:03 -0500
Date: Tue, 2 Mar 2004 20:02:01 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: jim.hague@acm.org
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: New permedia fbdev driver.
Message-ID: <Pine.LNX.4.44.0403021959150.18264-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the new permedia written to the new api. Please test it. You can 
grab a traditional diff from

http://phoenix.infradead.org/~jsimmons/pm2fb.diff

or grab it from the BK tree below. 

bk pull bk://fbdev.bkbits.net/fbdev-2.6

This will update the following files:

 drivers/video/cvisionppc.h |   51 
 include/video/pm2fb.h      |  222 ---
 drivers/video/Kconfig      |   18 
 drivers/video/Makefile     |    2 
 drivers/video/pm2fb.c      | 3014 +++++++++++++--------------------------------
 include/video/cvisionppc.h |   51 
 include/video/permedia2.h  |  222 +++
 7 files changed, 1210 insertions(+), 2370 deletions(-)

through these ChangeSets:

<jsimmons@infradead.org> (04/02/17 1.1557.1.5)
   [PERMEDIA2 FBDEV] Updated to the new api.




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVKRPCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVKRPCr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVKRPCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:02:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60313 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750778AbVKRPCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:02:46 -0500
Date: Fri, 18 Nov 2005 15:02:35 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Andrew Stribblehill <a.d.stribblehill@durham.ac.uk>
Subject: [PATCH] device-mapper: remove unused definition
Message-ID: <20051118150235.GQ11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Andrew Stribblehill <a.d.stribblehill@durham.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unused #define.
 
From: Andrew Stribblehill <a.d.stribblehill@durham.ac.uk>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14-rc2/drivers/md/dm-io.h
===================================================================
--- linux-2.6.14-rc2.orig/drivers/md/dm-io.h	2005-09-20 04:00:41.000000000 +0100
+++ linux-2.6.14-rc2/drivers/md/dm-io.h	2005-09-26 22:36:36.000000000 +0100
@@ -9,9 +9,6 @@
 
 #include "dm.h"
 
-/* FIXME make this configurable */
-#define DM_MAX_IO_REGIONS 8
-
 struct io_region {
 	struct block_device *bdev;
 	sector_t sector;

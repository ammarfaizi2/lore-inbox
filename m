Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbUKSBQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbUKSBQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbUKSBOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:14:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57862 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263031AbUKSBOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:14:20 -0500
Date: Fri, 19 Nov 2004 02:14:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill blk.h
Message-ID: <20041119011413.GA6589@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All blk.h users were vonverted in 2.5, and at the same time blk.h began 
giving a warning.

The patch below removes this obsolete file.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/include/linux/blk.h	2004-10-18 23:54:55.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,2 +0,0 @@
-#warning this file is obsolete, please use <linux/blkdev.h> instead
-#include <linux/blkdev.h>


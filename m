Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272447AbTGaKtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272971AbTGaKtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:49:23 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:12563 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S272447AbTGaKtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:49:18 -0400
Date: Thu, 31 Jul 2003 11:49:17 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 2/6] dm: remove blk.h include
Message-ID: <20030731104917.GF394@fib011235813.fsnet.co.uk>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731104517.GD394@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove includes of <linux/blk.h>. This header is deprecated in 2.6.
[Kevin Corry]

--- diff/drivers/md/dm-ioctl-v1.c	2003-07-28 11:55:33.000000000 +0100
+++ source/drivers/md/dm-ioctl-v1.c	2003-07-31 11:13:18.000000000 +0100
@@ -12,7 +12,6 @@
 #include <linux/dm-ioctl.h>
 #include <linux/init.h>
 #include <linux/wait.h>
-#include <linux/blk.h>
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 
--- diff/drivers/md/dm-ioctl-v4.c	2003-07-28 11:55:33.000000000 +0100
+++ source/drivers/md/dm-ioctl-v4.c	2003-07-31 11:13:18.000000000 +0100
@@ -11,7 +11,6 @@
 #include <linux/miscdevice.h>
 #include <linux/init.h>
 #include <linux/wait.h>
-#include <linux/blk.h>
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 

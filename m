Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272979AbTGaKvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272980AbTGaKvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:51:22 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:19973 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S272979AbTGaKvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:51:11 -0400
Date: Thu, 31 Jul 2003 11:51:09 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 5/6] dm: missing #include
Message-ID: <20030731105109.GI394@fib011235813.fsnet.co.uk>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731104517.GD394@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missing #include
--- diff/drivers/md/dm-ioctl-v4.c	2003-07-31 11:13:18.000000000 +0100
+++ source/drivers/md/dm-ioctl-v4.c	2003-07-31 11:14:03.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/dm-ioctl.h>
 
 #include <asm/uaccess.h>
 

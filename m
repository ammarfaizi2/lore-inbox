Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967120AbWKYTRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967120AbWKYTRf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967142AbWKYTRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:17:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3341 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S967137AbWKYTRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:17:04 -0500
Date: Sat, 25 Nov 2006 20:17:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Josef Jeff Sipek <jsipek@cs.sunysb.edu>,
       Michael Halcrow <mhalcrow@us.ibm.com>
Subject: [-mm patch] fs/stack.c should #include <linux/fs_stack.h>
Message-ID: <20061125191707.GK3702@stusta.de>
References: <20061123021703.8550e37e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123021703.8550e37e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for 
its global functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm1/fs/stack.c.old	2006-11-25 00:34:03.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/stack.c	2006-11-25 00:34:34.000000000 +0100
@@ -1,5 +1,6 @@
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_stack.h>
 
 /* does _NOT_ require i_mutex to be held.
  *

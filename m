Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbULLUBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbULLUBI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbULLT65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 14:58:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25106 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262126AbULLT6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:58:01 -0500
Date: Sun, 12 Dec 2004 20:57:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/resource.c: make resource_op static
Message-ID: <20041212195748.GM22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes resource_op static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/kernel/resource.c.old	2004-12-12 03:15:10.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/resource.c	2004-12-12 03:15:20.000000000 +0100
@@ -91,7 +91,7 @@
 	return 0;
 }
 
-struct seq_operations resource_op = {
+static struct seq_operations resource_op = {
 	.start	= r_start,
 	.next	= r_next,
 	.stop	= r_stop,


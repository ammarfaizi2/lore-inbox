Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUJ3R5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUJ3R5P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 13:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbUJ3R5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 13:57:14 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8968 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261232AbUJ3R5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 13:57:08 -0400
Date: Sat, 30 Oct 2004 19:56:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] efs: make a struct static
Message-ID: <20041030175636.GP4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a struct in the efs code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/include/linux/efs_vh.h.old	2004-10-30 14:03:58.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/include/linux/efs_vh.h	2004-10-30 14:04:13.000000000 +0200
@@ -44,7 +44,7 @@
 #define SGI_EFS		0x07
 #define IS_EFS(x)	(((x) == SGI_EFS) || ((x) == SGI_SYSV))
 
-struct pt_types {
+static struct pt_types {
 	int	pt_type;
 	char	*pt_name;
 } sgi_pt_types[] = {


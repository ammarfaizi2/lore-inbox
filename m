Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUKGAxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUKGAxg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 19:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUKGAxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 19:53:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5391 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261505AbUKGAxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 19:53:35 -0500
Date: Sun, 7 Nov 2004 01:52:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jaharkes@cs.cmu.edu
Cc: codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/coda/psdev.c shouldn't include lp.h
Message-ID: <20041107005258.GY1295@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't see any reason why fs/coda/psdev.c includes lp.h


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/fs/coda/psdev.c.old	2004-11-07 01:31:11.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/fs/coda/psdev.c	2004-11-07 01:31:16.000000000 +0100
@@ -22,7 +22,6 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/time.h>
-#include <linux/lp.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUDYBQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUDYBQw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 21:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUDYBQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 21:16:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60876 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262007AbUDYBQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 21:16:51 -0400
Date: Sun, 25 Apr 2004 03:16:47 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove __NO_VERSION__ from cx88
Message-ID: <20040425011647.GC895@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__NO_VERSION__ is useless since ages, but there are two new occurences 
in drivers/media/video/cx88/ in 2.6.5.

The patch below removes them.

Please apply
Adrian

--- linux-2.6.6-rc2-mm1-full/drivers/media/video/cx88/cx88-i2c.c.old	2004-04-25 03:12:09.000000000 +0200
+++ linux-2.6.6-rc2-mm1-full/drivers/media/video/cx88/cx88-i2c.c	2004-04-25 03:12:32.000000000 +0200
@@ -22,8 +22,6 @@
     
 */
 
-#define __NO_VERSION__ 1
-
 #include <linux/module.h>
 #include <linux/init.h>
 
--- linux-2.6.6-rc2-mm1-full/drivers/media/video/cx88/cx88-video.c.old	2004-04-25 03:12:52.000000000 +0200
+++ linux-2.6.6-rc2-mm1-full/drivers/media/video/cx88/cx88-video.c	2004-04-25 03:13:00.000000000 +0200
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263253AbUJ2AhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbUJ2AhT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbUJ2AhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:37:09 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8199 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263268AbUJ2AaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:30:22 -0400
Date: Fri, 29 Oct 2004 02:29:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kjsisson@bellsouth.net
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] USB stv680.c: remove an unused function
Message-ID: <20041029002950.GF29142@stusta.de>
References: <20041028232817.GM3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028232817.GM3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from 
drivers/usb/media/stv680.c


diffstat output:
 drivers/usb/media/stv680.c |    6 ------
 1 files changed, 6 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/usb/media/stv680.c.old	2004-10-28 23:31:16.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/usb/media/stv680.c	2004-10-28 23:32:24.000000000 +0200
@@ -498,12 +498,6 @@
 /****************************************************************************
  *  sysfs
  ***************************************************************************/
-static inline struct usb_stv *cd_to_stv(struct class_device *cd)
-{
-	struct video_device *vdev = to_video_device(cd);
-	return video_get_drvdata(vdev);
-}
-
 #define stv680_file(name, variable, field)				\
 static ssize_t show_##name(struct class_device *class_dev, char *buf)	\
 {									\

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130646AbRCEGhL>; Mon, 5 Mar 2001 01:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130647AbRCEGhC>; Mon, 5 Mar 2001 01:37:02 -0500
Received: from viper.haque.net ([64.0.249.226]:45454 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S130646AbRCEGgu>;
	Mon, 5 Mar 2001 01:36:50 -0500
Message-ID: <3AA33401.4A5A1EA6@haque.net>
Date: Mon, 05 Mar 2001 01:36:49 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] 2.4.3-pre{1,2} md_autodetect_dev unresolved
Content-Type: multipart/mixed;
 boundary="------------ECC893B85FC46ADB08C1D98C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ECC893B85FC46ADB08C1D98C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
--------------ECC893B85FC46ADB08C1D98C
Content-Type: text/plain; charset=us-ascii;
 name="2.4.3-p2-md.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.3-p2-md.diff"

--- linux/drivers/md/md.c.orig	Mon Mar  5 00:48:51 2001
+++ linux/drivers/md/md.c	Mon Mar  5 01:20:18 2001
@@ -3902,5 +3902,6 @@
 MD_EXPORT_SYMBOL(md_interrupt_thread);
 MD_EXPORT_SYMBOL(mddev_map);
 MD_EXPORT_SYMBOL(md_check_ordering);
+MD_EXPORT_SYMBOL(md_autodetect_dev);
 //MD_EXPORT_SYMBOL(name_to_kdev_t);
 

--------------ECC893B85FC46ADB08C1D98C--


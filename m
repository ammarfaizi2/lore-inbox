Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbTIOVhL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbTIOVhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:37:11 -0400
Received: from [193.138.115.2] ([193.138.115.2]:62968 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S261653AbTIOVgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:36:03 -0400
Date: Mon, 15 Sep 2003 23:34:50 +0200 (CEST)
From: Jesper Juhl <jju@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] aic7xxx config info corrections against 2.6.0-test5
Message-ID: <Pine.LNX.4.56.0309152319130.6308@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below are a few minor cleanups for the kernel config info regarding the
aic7xxx and aic79xx scsi drivers. Patches are generated against
2.6.0-test5

The following is done :

- correct minor typo in Documentation/scsi/aic79xx.txt
- correct minor typo in Documentation/scsi/aic7xxx.txt
- correct reference to nonexisting document (README.aic79xx) in drivers/scsi/aic7xxx/Kconfig.aic79xx
- correct reference to nonexisting document in (README.aic7xxx) in drivers/scsi/aic7xxx/Kconfig.aic7xxx


Kind regards,

Jesper Juhl <jju@dif.dk>



diff -ur linux-2.6.0-test5-orig/Documentation/scsi/aic79xx.txt
linux-2.6.0-test5/Documentation/scsi/aic79xx.txt
--- linux-2.6.0-test5-orig/Documentation/scsi/aic79xx.txt       2003-09-08
21:50:18.000000000 +0200
+++ linux-2.6.0-test5/Documentation/scsi/aic79xx.txt    2003-09-14
16:12:08.000000000 +0200
@@ -141,7 +141,7 @@
               Option: global_tag_depth
           Definition: Global tag depth for all targets on all busses.
                       This option sets the default tag depth which
-                      may be selectively overridden vi the tag_info
+                      may be selectively overridden via the tag_info
                       option.
      Possible Values: 1 - 253
        Default Value: 32



diff -ur linux-2.6.0-test5-orig/Documentation/scsi/aic7xxx.txt
linux-2.6.0-test5/Documentation/scsi/aic7xxx.txt
--- linux-2.6.0-test5-orig/Documentation/scsi/aic7xxx.txt       2003-09-08
21:49:58.000000000 +0200
+++ linux-2.6.0-test5/Documentation/scsi/aic7xxx.txt    2003-09-14
16:11:45.000000000 +0200
@@ -225,7 +225,7 @@
               Option: global_tag_depth:[value]
           Definition: Global tag depth for all targets on all busses.
                       This option sets the default tag depth which
-                      may be selectively overridden vi the tag_info
+                      may be selectively overridden via the tag_info
                       option.
      Possible Values: 1 - 253
        Default Value: 32



diff -ur linux-2.6.0-test5-orig/drivers/scsi/aic7xxx/Kconfig.aic79xx
linux-2.6.0-test5/drivers/scsi/aic7xxx/Kconfig.aic79xx
--- linux-2.6.0-test5-orig/drivers/scsi/aic7xxx/Kconfig.aic79xx 2003-09-08
21:50:03.000000000 +0200
+++ linux-2.6.0-test5/drivers/scsi/aic7xxx/Kconfig.aic79xx      2003-09-15
23:32:06.000000000 +0200
@@ -66,7 +66,7 @@
        with read streaming enabled so it is disabled by default.  Read
        Streaming can be configured in much the same way as tagged
queueing
        using the "rd_strm" command line option.  See
-       drivers/scsi/aic7xxx/README.aic79xx for details.
+       <file:Documentation/scsi/aic79xx.txt> for details.

 config AIC79XX_DEBUG_ENABLE
        bool "Compile in Debugging Code"



diff -ur linux-2.6.0-test5-orig/drivers/scsi/aic7xxx/Kconfig.aic7xxx
linux-2.6.0-test5/drivers/scsi/aic7xxx/Kconfig.aic7xxx
--- linux-2.6.0-test5-orig/drivers/scsi/aic7xxx/Kconfig.aic7xxx 2003-09-08
21:50:01.000000000 +0200
+++ linux-2.6.0-test5/drivers/scsi/aic7xxx/Kconfig.aic7xxx      2003-09-15
22:00:34.000000000 +0200
@@ -36,7 +36,7 @@
        on some devices.  The upper bound is 253.  0 disables tagged
queueing.

        Per device tag depth can be controlled via the kernel command line
-       "tag_info" option.  See drivers/scsi/aic7xxx/README.aic7xxx
+       "tag_info" option.  See <file:Documentation/scsi/aic7xxx.txt>
        for details.

 config AIC7XXX_RESET_DELAY_MS


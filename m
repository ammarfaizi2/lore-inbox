Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVDULRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVDULRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDULRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:17:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19333 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261289AbVDULRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:17:21 -0400
Date: Thu, 21 Apr 2005 13:11:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: [patch] acpi: fix video docs
Message-ID: <20050421111105.GA20062@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes typos/formatting in video_extension.txt.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean/Documentation/power/video_extension.txt	2004-12-25 13:34:57.000000000 +0100
+++ linux/Documentation/power/video_extension.txt	2005-03-22 12:20:53.000000000 +0100
@@ -1,13 +1,16 @@
-This driver implement the ACPI Extensions For Display Adapters
-for integrated graphics devices on motherboard, as specified in
-ACPI 2.0 Specification, Appendix B, allowing to perform some basic
-control like defining the video POST device, retrieving EDID information
-or to setup a video output, etc.  Note that this is an ref. implementation only.
-It may or may not work for your integrated video device.
+ACPI video extensions
+~~~~~~~~~~~~~~~~~~~~~
+
+This driver implement the ACPI Extensions For Display Adapters for
+integrated graphics devices on motherboard, as specified in ACPI 2.0
+Specification, Appendix B, allowing to perform some basic control like
+defining the video POST device, retrieving EDID information or to
+setup a video output, etc.  Note that this is an ref. implementation
+only.  It may or may not work for your integrated video device.
 
 Interfaces exposed to userland through /proc/acpi/video:
 
-VGA/info : display the supported video bus device capability like ,Video ROM, CRT/LCD/TV.
+VGA/info : display the supported video bus device capability like Video ROM, CRT/LCD/TV.
 VGA/ROM :  Used to get a copy of the display devices' ROM data (up to 4k).
 VGA/POST_info : Used to determine what options are implemented.
 VGA/POST : Used to get/set POST device.
@@ -15,7 +18,7 @@
 	Please refer ACPI spec B.4.1 _DOS
 VGA/CRT : CRT output
 VGA/LCD : LCD output
-VGA/TV : TV output 
+VGA/TVO : TV output 
 VGA/*/brightness : Used to get/set brightness of output device
 
 Notify event through /proc/acpi/event:

-- 
Boycott Kodak -- for their patent abuse against Java.

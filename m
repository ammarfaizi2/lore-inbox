Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVAPB1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVAPB1t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 20:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVAPB1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 20:27:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:49807 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262375AbVAPB1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 20:27:40 -0500
Message-ID: <41E9C156.3040805@osdl.org>
Date: Sat, 15 Jan 2005 17:20:22 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH] i386: update defconfig
Content-Type: multipart/mixed;
 boundary="------------080805060201090701000307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080805060201090701000307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I suggest that we do a little defconfig module trimming.

Reduce number of modules built via defconfig.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  arch/i386/defconfig |   12 ++++++------
  1 files changed, 6 insertions(+), 6 deletions(-)
---

--------------080805060201090701000307
Content-Type: text/x-patch;
 name="defconfig_i386.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="defconfig_i386.patch"


Reduce number of modules built via defconfig.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/i386/defconfig |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -Naurp ./arch/i386/defconfig~defcfg ./arch/i386/defconfig
--- ./arch/i386/defconfig~defcfg	2005-01-15 16:13:03.848940080 -0800
+++ ./arch/i386/defconfig	2005-01-15 16:47:14.933127888 -0800
@@ -359,7 +359,7 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
-CONFIG_SCSI_DPT_I2O=m
+# CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
 # CONFIG_SCSI_MEGARAID is not set
@@ -388,7 +388,7 @@ CONFIG_SCSI_SATA_SIS=m
 # CONFIG_SCSI_IMM is not set
 # CONFIG_SCSI_NCR53C406A is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
-CONFIG_SCSI_IPR=m
+# CONFIG_SCSI_IPR is not set
 # CONFIG_SCSI_IPR_TRACE is not set
 # CONFIG_SCSI_IPR_DUMP is not set
 # CONFIG_SCSI_PAS16 is not set
@@ -660,7 +660,7 @@ CONFIG_8139TOO_PIO=y
 # Ethernet (10000 Mbit)
 #
 # CONFIG_IXGB is not set
-CONFIG_S2IO=m
+# CONFIG_S2IO is not set
 # CONFIG_S2IO_NAPI is not set
 
 #
@@ -1013,7 +1013,7 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_KBTAB is not set
 # CONFIG_USB_POWERMATE is not set
 # CONFIG_USB_MTOUCH is not set
-CONFIG_USB_EGALAX=m
+# CONFIG_USB_EGALAX is not set
 # CONFIG_USB_XPAD is not set
 # CONFIG_USB_ATI_REMOTE is not set
 
@@ -1063,8 +1063,8 @@ CONFIG_USB_EGALAX=m
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
-CONFIG_USB_CYTHERM=m
-CONFIG_USB_PHIDGETSERVO=m
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGETSERVO is not set
 # CONFIG_USB_TEST is not set
 
 #

--------------080805060201090701000307--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVIQHEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVIQHEo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 03:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbVIQHEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 03:04:43 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:57505
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750986AbVIQHEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 03:04:43 -0400
Subject: [PATCH] hwmon Kconfig for hdaps.
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Robert Love <rml@novell.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 17 Sep 2005 01:04:35 -0600
Message-Id: <1126940675.5461.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Here is an updated list of laptops that are supported by the HDAPS
driver which is not complete in the Kconfig of the current tree.

Please let me know if I should be doing the patch in a different way.

I use as below, But the documentation for patches says diff -up? I
assume the git diff does the trick.

debian:~/linux-2.6# git diff drivers/hwmon/Kconfig~
drivers/hwmon/Kconfig

Evolution makes it look ugly. Please let me know.


Signed-off-by: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>


diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -418,7 +418,8 @@ config SENSORS_HDAPS
        help
          This driver provides support for the IBM Hard Drive Active
Protection
          System (hdaps), which provides an accelerometer and other
misc. data.
-         Supported laptops include the IBM ThinkPad T41, T42, T43, and
R51.
+         Supported laptops include the IBM ThinkPad T41, T42, T43, R50,
R51,
+         R52, X40* and X41.
          The accelerometer data is readable via sysfs.
 
          This driver also provides an input class device, allowing the



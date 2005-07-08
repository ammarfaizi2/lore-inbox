Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVGHWUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVGHWUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbVGHWSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:18:40 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:51628 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262790AbVGHWCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:02:55 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix SERIO_RAW config help text
From: Peter Osterlund <petero2@telia.com>
Date: 09 Jul 2005 00:02:45 +0200
Message-ID: <m3ackxj6re.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The help text for SERIO_RAW refers to the wrong sysfs device node.
This patch fixes it.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/input/serio/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/input/serio/Kconfig~serio-help-fix drivers/input/serio/Kconfig
--- linux/drivers/input/serio/Kconfig~serio-help-fix	2005-07-05 11:43:25.000000000 +0200
+++ linux-petero/drivers/input/serio/Kconfig	2005-07-05 11:43:25.000000000 +0200
@@ -175,7 +175,7 @@ config SERIO_RAW
 	  allocating minor 1 (that historically corresponds to /dev/psaux)
 	  first. To bind this driver to a serio port use sysfs interface:
 
-	      echo -n "serio_raw" > /sys/bus/serio/devices/serioX/driver
+	      echo -n "serio_raw" > /sys/bus/serio/devices/serioX/drvctl
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called serio_raw.
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340

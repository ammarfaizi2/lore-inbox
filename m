Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbUK1Wku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbUK1Wku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 17:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbUK1Wku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 17:40:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33295 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261359AbUK1Wj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 17:39:26 -0500
Date: Sun, 28 Nov 2004 23:39:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove bouncing email address of Thomas Hood
Message-ID: <20041128223919.GF4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes the bouncing email address of Thomas Hood (I 
haven't found any more recent email address).


diffstat output:
 arch/i386/kernel/apm.c     |    4 ++--
 drivers/pnp/pnpbios/core.c |    2 +-
 drivers/pnp/pnpbios/proc.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/pnp/pnpbios/core.c.old	2004-11-28 23:33:19.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/pnp/pnpbios/core.c	2004-11-28 23:33:29.000000000 +0100
@@ -12,7 +12,7 @@
  * Minor reorganizations by David Hinds <dahinds@users.sourceforge.net>
  * Further modifications (C) 2001, 2002 by:
  *   Alan Cox <alan@redhat.com>
- *   Thomas Hood <jdthood@mail.com>
+ *   Thomas Hood
  *   Brian Gerst <bgerst@didntduck.org>
  *
  * Ported to the PnP Layer and several additional improvements (C) 2002
--- linux-2.6.10-rc2-mm3-full/drivers/pnp/pnpbios/proc.c.old	2004-11-28 23:33:38.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/pnp/pnpbios/proc.c	2004-11-28 23:33:44.000000000 +0100
@@ -2,7 +2,7 @@
  * /proc/bus/pnp interface for Plug and Play devices
  *
  * Written by David Hinds, dahinds@users.sourceforge.net
- * Modified by Thomas Hood, jdthood@mail.com
+ * Modified by Thomas Hood
  *
  * The .../devices and .../<node> and .../boot/<node> files are
  * utilized by the lspnp and setpnp utilities, supplied with the
--- linux-2.6.10-rc2-mm3-full/arch/i386/kernel/apm.c.old	2004-11-28 23:33:52.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/arch/i386/kernel/apm.c	2004-11-28 23:34:07.000000000 +0100
@@ -166,14 +166,14 @@
  *         If an APM idle fails log it and idle sensibly
  *   1.15: Don't queue events to clients who open the device O_WRONLY.
  *         Don't expect replies from clients who open the device O_RDONLY.
- *         (Idea from Thomas Hood <jdthood@mail.com>)
+ *         (Idea from Thomas Hood)
  *         Minor waitqueue cleanups. (John Fremlin <chief@bandits.org>)
  *   1.16: Fix idle calling. (Andreas Steinmetz <ast@domdv.de> et al.)
  *         Notify listeners of standby or suspend events before notifying
  *         drivers. Return EBUSY to ioctl() if suspend is rejected.
  *         (Russell King <rmk@arm.linux.org.uk> and Thomas Hood)
  *         Ignore first resume after we generate our own resume event
- *         after a suspend (Thomas Hood <jdthood@mail.com>)
+ *         after a suspend (Thomas Hood)
  *         Daemonize now gets rid of our controlling terminal (sfr).
  *         CONFIG_APM_CPU_IDLE now just affects the default value of
  *         idle_threshold (sfr).


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWFZU4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWFZU4Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWFZU4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:56:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58893 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932121AbWFZU4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:56:24 -0400
Date: Mon, 26 Jun 2006 22:56:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] typo fixes: mecanism -> mechanism
Message-ID: <20060626205622.GD23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

 arch/powerpc/kernel/prom_init.c              |    2 +-
 arch/powerpc/platforms/powermac/cpufreq_32.c |    2 +-
 drivers/macintosh/therm_pm72.h               |    2 +-
 drivers/video/aty/radeonfb.h                 |    2 +-
 include/asm-powerpc/of_device.h              |    2 +-
 include/asm-powerpc/pmac_pfunc.h             |    2 +-
 include/asm-ppc/page.h                       |    2 +-
 include/linux/fb.h                           |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.17-mm2-full/arch/powerpc/kernel/prom_init.c.old	2006-06-26 22:27:28.000000000 +0200
+++ linux-2.6.17-mm2-full/arch/powerpc/kernel/prom_init.c	2006-06-26 22:27:42.000000000 +0200
@@ -988,7 +988,7 @@
 }
 
 /*
- * Initialize memory allocation mecanism, parse "memory" nodes and
+ * Initialize memory allocation mechanism, parse "memory" nodes and
  * obtain that way the top of memory and RMO to setup out local allocator
  */
 static void __init prom_init_mem(void)
--- linux-2.6.17-mm2-full/arch/powerpc/platforms/powermac/cpufreq_32.c.old	2006-06-26 22:27:52.000000000 +0200
+++ linux-2.6.17-mm2-full/arch/powerpc/platforms/powermac/cpufreq_32.c	2006-06-26 22:27:57.000000000 +0200
@@ -68,7 +68,7 @@
 static unsigned int sleep_freq;
 
 /*
- * Different models uses different mecanisms to switch the frequency
+ * Different models uses different mechanisms to switch the frequency
  */
 static int (*set_speed_proc)(int low_speed);
 static unsigned int (*get_speed_proc)(void);
--- linux-2.6.17-mm2-full/drivers/macintosh/therm_pm72.h.old	2006-06-26 22:28:07.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/macintosh/therm_pm72.h	2006-06-26 22:28:14.000000000 +0200
@@ -93,7 +93,7 @@
  * 0. This appear to be safe enough for this first version
  * of the driver, though I would accept any clean patch
  * doing a better use of the device-tree without turning the
- * while i2c registration mecanism into a racy mess
+ * while i2c registration mechanism into a racy mess
  *
  * Note: Xserve changed this. We have some bits on the K2 bus,
  * which I arbitrarily set to 0x200. Ultimately, we really want
--- linux-2.6.17-mm2-full/drivers/video/aty/radeonfb.h.old	2006-06-26 22:28:22.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/video/aty/radeonfb.h	2006-06-26 22:28:26.000000000 +0200
@@ -382,7 +382,7 @@
 /* Note about this function: we have some rare cases where we must not schedule,
  * this typically happen with our special "wake up early" hook which allows us to
  * wake up the graphic chip (and thus get the console back) before everything else
- * on some machines that support that mecanism. At this point, interrupts are off
+ * on some machines that support that mechanism. At this point, interrupts are off
  * and scheduling is not permitted
  */
 static inline void _radeon_msleep(struct radeonfb_info *rinfo, unsigned long ms)
--- linux-2.6.17-mm2-full/include/asm-powerpc/of_device.h.old	2006-06-26 22:28:34.000000000 +0200
+++ linux-2.6.17-mm2-full/include/asm-powerpc/of_device.h	2006-06-26 22:28:38.000000000 +0200
@@ -9,7 +9,7 @@
 /*
  * The of_platform_bus_type is a bus type used by drivers that do not
  * attach to a macio or similar bus but still use OF probing
- * mecanism
+ * mechanism
  */
 extern struct bus_type of_platform_bus_type;
 
--- linux-2.6.17-mm2-full/include/asm-powerpc/pmac_pfunc.h.old	2006-06-26 22:29:01.000000000 +0200
+++ linux-2.6.17-mm2-full/include/asm-powerpc/pmac_pfunc.h	2006-06-26 22:29:07.000000000 +0200
@@ -205,7 +205,7 @@
  *
  * The args array contains as many arguments as is required by the function,
  * this is dependent on the function you are calling, unfortunately Apple
- * mecanism provides no way to encode that so you have to get it right at
+ * mechanism provides no way to encode that so you have to get it right at
  * the call site. Some functions require no args, in which case, you can
  * pass NULL.
  *
--- linux-2.6.17-mm2-full/include/asm-ppc/page.h.old	2006-06-26 22:29:14.000000000 +0200
+++ linux-2.6.17-mm2-full/include/asm-ppc/page.h	2006-06-26 22:29:17.000000000 +0200
@@ -170,7 +170,7 @@
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-/* We do define AT_SYSINFO_EHDR but don't use the gate mecanism */
+/* We do define AT_SYSINFO_EHDR but don't use the gate mechanism */
 #define __HAVE_ARCH_GATE_AREA		1
 
 #include <asm-generic/memory_model.h>
--- linux-2.6.17-mm2-full/include/linux/fb.h.old	2006-06-26 22:29:25.000000000 +0200
+++ linux-2.6.17-mm2-full/include/linux/fb.h	2006-06-26 22:29:31.000000000 +0200
@@ -558,7 +558,7 @@
  * Frame buffer operations
  *
  * LOCKING NOTE: those functions must _ALL_ be called with the console
- * semaphore held, this is the only suitable locking mecanism we have
+ * semaphore held, this is the only suitable locking mechanism we have
  * in 2.6. Some may be called at interrupt time at this point though.
  */
 


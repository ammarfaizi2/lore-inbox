Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284237AbRLPDzV>; Sat, 15 Dec 2001 22:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284240AbRLPDzL>; Sat, 15 Dec 2001 22:55:11 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:33414 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S284237AbRLPDyw>; Sat, 15 Dec 2001 22:54:52 -0500
Date: Sun, 16 Dec 2001 03:56:41 +0000
From: Dave Jones <davej@suse.de>
To: Marcelo Tossati <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: missing MODULE_LICENSE tags.
Message-ID: <20011216035641.A15709@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Marcelo Tossati <marcelo@conectiva.com.br>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
 Here's a bunch of tags that I just dug out of the last -ac patch
that Alan did, that never got around to being merged.

regards,
Dave.


diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15pre6/drivers/acpi/ospm/ac_adapter/ac_osl.c linux-ac/drivers/acpi/ospm/ac_adapter/ac_osl.c
--- linux-2.4.15pre6/drivers/acpi/ospm/ac_adapter/ac_osl.c	Wed Oct 24 21:06:22 2001
+++ linux-ac/drivers/acpi/ospm/ac_adapter/ac_osl.c	Sun Sep 23 16:42:32 2001
@@ -35,6 +35,7 @@
 
 MODULE_AUTHOR("Andrew Grover");
 MODULE_DESCRIPTION("ACPI Component Architecture (CA) - AC Adapter Driver");
+MODULE_LICENSE("GPL");
 
 
 #define AC_PROC_ROOT		"ac_adapter"
diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15pre6/drivers/acpi/ospm/battery/bt_osl.c linux-ac/drivers/acpi/ospm/battery/bt_osl.c
--- linux-2.4.15pre6/drivers/acpi/ospm/battery/bt_osl.c	Wed Oct 24 21:06:22 2001
+++ linux-ac/drivers/acpi/ospm/battery/bt_osl.c	Sun Sep 23 16:42:32 2001
@@ -44,6 +44,7 @@
 
 MODULE_AUTHOR("Andrew Grover");
 MODULE_DESCRIPTION("ACPI Component Architecture (CA) - Control Method Battery Driver");
+MODULE_LICENSE("GPL");
 
 
 #define BT_PROC_ROOT		"battery"
diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15pre6/drivers/acpi/ospm/busmgr/bm_osl.c linux-ac/drivers/acpi/ospm/busmgr/bm_osl.c
--- linux-2.4.15pre6/drivers/acpi/ospm/busmgr/bm_osl.c	Wed Oct 24 21:06:22 2001
+++ linux-ac/drivers/acpi/ospm/busmgr/bm_osl.c	Sun Sep 23 16:42:32 2001
@@ -38,6 +38,7 @@
 
 MODULE_AUTHOR("Andrew Grover");
 MODULE_DESCRIPTION("ACPI Component Architecture (CA) - ACPI Bus Manager");
+MODULE_LICENSE("GPL");
 
 
 /*****************************************************************************
diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15pre6/drivers/acpi/ospm/button/bn_osl.c linux-ac/drivers/acpi/ospm/button/bn_osl.c
--- linux-2.4.15pre6/drivers/acpi/ospm/button/bn_osl.c	Wed Oct 24 21:06:22 2001
+++ linux-ac/drivers/acpi/ospm/button/bn_osl.c	Sun Sep 23 16:42:32 2001
@@ -35,6 +35,7 @@
 
 MODULE_AUTHOR("Andrew Grover");
 MODULE_DESCRIPTION("ACPI Component Architecture (CA) - Button Driver");
+MODULE_LICENSE("GPL");
 
 
 #define BN_PROC_ROOT		"button"
diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15pre6/drivers/acpi/ospm/ec/ec_osl.c linux-ac/drivers/acpi/ospm/ec/ec_osl.c
--- linux-2.4.15pre6/drivers/acpi/ospm/ec/ec_osl.c	Wed Oct 24 21:06:22 2001
+++ linux-ac/drivers/acpi/ospm/ec/ec_osl.c	Sun Sep 23 16:42:32 2001
@@ -36,6 +36,7 @@
 
 MODULE_AUTHOR("Andrew Grover");
 MODULE_DESCRIPTION("ACPI Component Architecture (CA) - Embedded Controller Driver");
+MODULE_LICENSE("GPL");
 
 extern struct proc_dir_entry	*bm_proc_root;
 
diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15pre6/drivers/acpi/ospm/processor/pr_osl.c linux-ac/drivers/acpi/ospm/processor/pr_osl.c
--- linux-2.4.15pre6/drivers/acpi/ospm/processor/pr_osl.c	Mon Nov 19 13:40:54 2001
+++ linux-ac/drivers/acpi/ospm/processor/pr_osl.c	Mon Nov 19 14:09:20 2001
@@ -37,6 +37,7 @@
 
 MODULE_AUTHOR("Andrew Grover");
 MODULE_DESCRIPTION("ACPI Component Architecture (CA) - IA32 Processor Driver");
+MODULE_LICENSE("GPL");
 
 
 #define PR_PROC_ROOT		"processor"
diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15pre6/drivers/acpi/ospm/system/sm_osl.c linux-ac/drivers/acpi/ospm/system/sm_osl.c
--- linux-2.4.15pre6/drivers/acpi/ospm/system/sm_osl.c	Wed Oct 24 21:06:22 2001
+++ linux-ac/drivers/acpi/ospm/system/sm_osl.c	Mon Nov 19 14:09:20 2001
@@ -42,6 +42,7 @@
 
 MODULE_AUTHOR("Andrew Grover");
 MODULE_DESCRIPTION("ACPI Component Architecture (CA) - ACPI System Driver");
+MODULE_LICENSE("GPL");
 
 
 #define SM_PROC_INFO		"info"
diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15pre6/drivers/acpi/ospm/thermal/tz_osl.c linux-ac/drivers/acpi/ospm/thermal/tz_osl.c
--- linux-2.4.15pre6/drivers/acpi/ospm/thermal/tz_osl.c	Wed Oct 24 21:06:22 2001
+++ linux-ac/drivers/acpi/ospm/thermal/tz_osl.c	Thu Oct 11 16:04:57 2001
@@ -35,6 +35,7 @@
 
 MODULE_AUTHOR("Andrew Grover");
 MODULE_DESCRIPTION("ACPI Component Architecture (CA) - Thermal Zone Driver");
+MODULE_LICENSE("GPL");
 
 int TZP = 0;
 MODULE_PARM(TZP, "i");
diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15pre6/drivers/md/md.c linux-ac/drivers/md/md.c
--- linux-2.4.15pre6/drivers/md/md.c	Thu Oct 25 20:58:34 2001
+++ linux-ac/drivers/md/md.c	Mon Nov 19 14:09:21 2001
@@ -4039,4 +4037,4 @@
 MD_EXPORT_SYMBOL(mddev_map);
 MD_EXPORT_SYMBOL(md_check_ordering);
 MD_EXPORT_SYMBOL(get_spare);
-
+MODULE_LICENSE("GPL");
diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15pre6/drivers/net/pcmcia/fmvj18x_cs.c linux-ac/drivers/net/pcmcia/fmvj18x_cs.c
--- linux-2.4.15pre6/drivers/net/pcmcia/fmvj18x_cs.c	Mon Nov 19 13:40:55 2001
+++ linux-ac/drivers/net/pcmcia/fmvj18x_cs.c	Sun Sep 30 19:26:07 2001
@@ -1247,3 +1257,4 @@
     }
     restore_flags(flags);
 }
+MODULE_LICENSE("GPL");
diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15pre6/drivers/video/aty/atyfb_base.c linux-ac/drivers/video/aty/atyfb_base.c
--- linux-2.4.15pre6/drivers/video/aty/atyfb_base.c	Tue Oct 30 23:08:11 2001
+++ linux-ac/drivers/video/aty/atyfb_base.c	Mon Nov 19 14:09:22 2001
@@ -2891,3 +2944,4 @@
 }
 
 #endif
+MODULE_LICENSE("GPL");
diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15pre6/drivers/video/fbmem.c linux-ac/drivers/video/fbmem.c
--- linux-2.4.15pre6/drivers/video/fbmem.c	Mon Nov 19 13:40:56 2001
+++ linux-ac/drivers/video/fbmem.c	Mon Nov 19 14:09:22 2001
@@ -931,3 +951,5 @@
 #if 1 /* to go away in 2.5.0 */
 EXPORT_SYMBOL(GET_FB_IDX);
 #endif
+
+MODULE_LICENSE("GPL");
-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272384AbRHYBwH>; Fri, 24 Aug 2001 21:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272385AbRHYBwA>; Fri, 24 Aug 2001 21:52:00 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:55304 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S272384AbRHYBvs>; Fri, 24 Aug 2001 21:51:48 -0400
Date: Sat, 25 Aug 2001 02:50:15 +0100 (BST)
From: Dave Jones <davej@suse.de>
X-X-Sender: <davej@noodles.codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] const initdata, part 2.
Message-ID: <Pine.LNX.4.31.0108250246320.19400-100000@noodles.codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch changes all the other occurances of const __initdata that
a quick grep revealed. Will split up into pieces and send to
appropriate maintainers tomorrow. (This seemed better than bombing
l-k with ~40 seperate related mails).

regards,

Dave.

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .

diff -urN --exclude-from=/home/davej/.exclude linux-ac/arch/m68k/amiga/config.c linux-dj/arch/m68k/amiga/config.c
--- linux-ac/arch/m68k/amiga/config.c	Tue Jun 12 03:15:27 2001
+++ linux-dj/arch/m68k/amiga/config.c	Sat Aug 25 02:28:55 2001
@@ -44,22 +44,22 @@
 unsigned char amiga_psfreq;
 struct amiga_hw_present amiga_hw_present;

-static const char s_a500[] __initdata = "A500";
-static const char s_a500p[] __initdata = "A500+";
-static const char s_a600[] __initdata = "A600";
-static const char s_a1000[] __initdata = "A1000";
-static const char s_a1200[] __initdata = "A1200";
-static const char s_a2000[] __initdata = "A2000";
-static const char s_a2500[] __initdata = "A2500";
-static const char s_a3000[] __initdata = "A3000";
-static const char s_a3000t[] __initdata = "A3000T";
-static const char s_a3000p[] __initdata = "A3000+";
-static const char s_a4000[] __initdata = "A4000";
-static const char s_a4000t[] __initdata = "A4000T";
-static const char s_cdtv[] __initdata = "CDTV";
-static const char s_cd32[] __initdata = "CD32";
-static const char s_draco[] __initdata = "Draco";
-static const char *amiga_models[] __initdata = {
+static char s_a500[] __initdata = "A500";
+static char s_a500p[] __initdata = "A500+";
+static char s_a600[] __initdata = "A600";
+static char s_a1000[] __initdata = "A1000";
+static char s_a1200[] __initdata = "A1200";
+static char s_a2000[] __initdata = "A2000";
+static char s_a2500[] __initdata = "A2500";
+static char s_a3000[] __initdata = "A3000";
+static char s_a3000t[] __initdata = "A3000T";
+static char s_a3000p[] __initdata = "A3000+";
+static char s_a4000[] __initdata = "A4000";
+static char s_a4000t[] __initdata = "A4000T";
+static char s_cdtv[] __initdata = "CDTV";
+static char s_cd32[] __initdata = "CD32";
+static char s_draco[] __initdata = "Draco";
+static char *amiga_models[] __initdata = {
     s_a500, s_a500p, s_a600, s_a1000, s_a1200, s_a2000, s_a2500, s_a3000,
     s_a3000t, s_a3000p, s_a4000, s_a4000t, s_cdtv, s_cd32, s_draco,
 };
diff -urN --exclude-from=/home/davej/.exclude linux-ac/arch/ppc/amiga/config.c linux-dj/arch/ppc/amiga/config.c
--- linux-ac/arch/ppc/amiga/config.c	Tue May 22 01:04:46 2001
+++ linux-dj/arch/ppc/amiga/config.c	Sat Aug 25 02:28:17 2001
@@ -51,22 +51,22 @@
 unsigned char amiga_psfreq;
 struct amiga_hw_present amiga_hw_present;

-static const char s_a500[] __initdata = "A500";
-static const char s_a500p[] __initdata = "A500+";
-static const char s_a600[] __initdata = "A600";
-static const char s_a1000[] __initdata = "A1000";
-static const char s_a1200[] __initdata = "A1200";
-static const char s_a2000[] __initdata = "A2000";
-static const char s_a2500[] __initdata = "A2500";
-static const char s_a3000[] __initdata = "A3000";
-static const char s_a3000t[] __initdata = "A3000T";
-static const char s_a3000p[] __initdata = "A3000+";
-static const char s_a4000[] __initdata = "A4000";
-static const char s_a4000t[] __initdata = "A4000T";
-static const char s_cdtv[] __initdata = "CDTV";
-static const char s_cd32[] __initdata = "CD32";
-static const char s_draco[] __initdata = "Draco";
-static const char *amiga_models[] __initdata = {
+static char s_a500[] __initdata = "A500";
+static char s_a500p[] __initdata = "A500+";
+static char s_a600[] __initdata = "A600";
+static char s_a1000[] __initdata = "A1000";
+static char s_a1200[] __initdata = "A1200";
+static char s_a2000[] __initdata = "A2000";
+static char s_a2500[] __initdata = "A2500";
+static char s_a3000[] __initdata = "A3000";
+static char s_a3000t[] __initdata = "A3000T";
+static char s_a3000p[] __initdata = "A3000+";
+static char s_a4000[] __initdata = "A4000";
+static char s_a4000t[] __initdata = "A4000T";
+static char s_cdtv[] __initdata = "CDTV";
+static char s_cd32[] __initdata = "CD32";
+static char s_draco[] __initdata = "Draco";
+static char *amiga_models[] __initdata = {
     s_a500, s_a500p, s_a600, s_a1000, s_a1200, s_a2000, s_a2500, s_a3000,
     s_a3000t, s_a3000p, s_a4000, s_a4000t, s_cdtv, s_cd32, s_draco,
 };
diff -urN --exclude-from=/home/davej/.exclude linux-ac/arch/ppc/kernel/residual.c linux-dj/arch/ppc/kernel/residual.c
--- linux-ac/arch/ppc/kernel/residual.c	Tue May 22 01:04:47 2001
+++ linux-dj/arch/ppc/kernel/residual.c	Sat Aug 25 02:27:35 2001
@@ -55,7 +55,7 @@
 unsigned char __res[sizeof(RESIDUAL)] __prepdata = {0,};
 RESIDUAL *res = (RESIDUAL *)&__res;

-const char * PnP_BASE_TYPES[] __initdata = {
+char * PnP_BASE_TYPES[] __initdata = {
   "Reserved",
   "MassStorageDevice",
   "NetworkInterfaceController",
@@ -71,7 +71,7 @@

 /* Device Sub Type Codes */

-const unsigned char * PnP_SUB_TYPES[] __initdata = {
+unsigned char * PnP_SUB_TYPES[] __initdata = {
   "\001\000SCSIController",
   "\001\001IDEController",
   "\001\002FloppyController",
@@ -128,7 +128,7 @@

 /* Device Interface Type Codes */

-const  unsigned char * PnP_INTERFACES[] __initdata = {
+unsigned char * PnP_INTERFACES[] __initdata = {
   "\000\000\000General",
   "\001\000\000GeneralSCSI",
   "\001\001\000GeneralIDE",
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/acpi/include/platform/acgcc.h linux-dj/drivers/acpi/include/platform/acgcc.h
--- linux-ac/drivers/acpi/include/platform/acgcc.h	Sat Aug 25 02:23:23 2001
+++ linux-dj/drivers/acpi/include/platform/acgcc.h	Sat Aug 25 02:13:03 2001
@@ -100,7 +100,6 @@
 #define disable() __cli()
 #define enable()  __sti()
 #define halt()    __asm__ __volatile__ ("sti; hlt":::"memory")
-#define wbinvd()

 /*! [Begin] no source code translation
  *
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/atm/ambassador.c linux-dj/drivers/atm/ambassador.c
--- linux-ac/drivers/atm/ambassador.c	Thu Jun 28 00:18:13 2001
+++ linux-dj/drivers/atm/ambassador.c	Sat Aug 25 02:34:26 2001
@@ -297,16 +297,16 @@
 #define UCODE2(x) #x
 #define UCODE1(x,y) UCODE2(x ## y)

-static const u32 __initdata ucode_start =
+static u32 __initdata ucode_start =
 #include UCODE(start)
 ;

-static const region __initdata ucode_regions[] = {
+static region __initdata ucode_regions[] = {
 #include UCODE(regions)
   { 0, 0 }
 };

-static const u32 __initdata ucode_data[] = {
+static u32 __initdata ucode_data[] = {
 #include UCODE(data)
   0xdeadbeef
 };
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/cdrom/cdu31a.c linux-dj/drivers/cdrom/cdu31a.c
--- linux-ac/drivers/cdrom/cdu31a.c	Fri Feb  9 19:30:22 2001
+++ linux-dj/drivers/cdrom/cdu31a.c	Sat Aug 25 02:39:32 2001
@@ -3250,7 +3250,7 @@
 };

 /* The different types of disc loading mechanisms supported */
-static const char *load_mech[] __initdata = { "caddy", "tray", "pop-up", "unknown" };
+static char *load_mech[] __initdata = { "caddy", "tray", "pop-up", "unknown" };

 static void __init
 get_drive_configuration(unsigned short base_io,
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/char/dsp56k.c linux-dj/drivers/char/dsp56k.c
--- linux-ac/drivers/char/dsp56k.c	Mon Jul 16 00:15:44 2001
+++ linux-dj/drivers/char/dsp56k.c	Sat Aug 25 02:40:28 2001
@@ -505,7 +505,7 @@

 static devfs_handle_t devfs_handle;

-static const char banner[] __initdata = KERN_INFO "DSP56k driver installed\n";
+static char banner[] __initdata = KERN_INFO "DSP56k driver installed\n";

 static int __init dsp56k_init_driver(void)
 {
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/char/pc110pad.c linux-dj/drivers/char/pc110pad.c
--- linux-ac/drivers/char/pc110pad.c	Tue May 22 18:23:16 2001
+++ linux-dj/drivers/char/pc110pad.c	Sat Aug 25 02:41:16 2001
@@ -798,7 +798,7 @@
  *	asked to open it by an application.
  */

-static const char banner[] __initdata = KERN_INFO "PC110 digitizer pad at 0x%X, irq %d.\n";
+static char banner[] __initdata = KERN_INFO "PC110 digitizer pad at 0x%X, irq %d.\n";

 static int __init pc110pad_init_driver(void)
 {
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/char/qpmouse.c linux-dj/drivers/char/qpmouse.c
--- linux-ac/drivers/char/qpmouse.c	Sat Apr 14 04:26:07 2001
+++ linux-dj/drivers/char/qpmouse.c	Sat Aug 25 02:40:36 2001
@@ -338,8 +338,8 @@
 	return 1;
 }

-static const char msg_banner[] __initdata = KERN_INFO "82C710 type pointing device detected -- driver installed.\n";
-static const char msg_nomem[]  __initdata = KERN_ERR "qpmouse: no queue memory.\n";
+static char msg_banner[] __initdata = KERN_INFO "82C710 type pointing device detected -- driver installed.\n";
+static char msg_nomem[]  __initdata = KERN_ERR "qpmouse: no queue memory.\n";

 static int __init qpmouse_init_driver(void)
 {
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/char/softdog.c linux-dj/drivers/char/softdog.c
--- linux-ac/drivers/char/softdog.c	Sun May 20 01:43:05 2001
+++ linux-dj/drivers/char/softdog.c	Sat Aug 25 02:33:45 2001
@@ -160,7 +160,7 @@
 	fops:		&softdog_fops,
 };

-static const char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.05, timer margin: %d sec\n";
+static char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.05, timer margin: %d sec\n";

 static int __init watchdog_init(void)
 {
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/ide/buddha.c linux-dj/drivers/ide/buddha.c
--- linux-ac/drivers/ide/buddha.c	Mon Jul 16 00:22:23 2001
+++ linux-dj/drivers/ide/buddha.c	Sat Aug 25 02:39:20 2001
@@ -43,7 +43,7 @@
 #define BUDDHA_BASE2	0xa00
 #define BUDDHA_BASE3	0xc00

-static const u_int buddha_bases[CATWEASEL_NUM_HWIFS] __initdata = {
+static u_int buddha_bases[CATWEASEL_NUM_HWIFS] __initdata = {
     BUDDHA_BASE1, BUDDHA_BASE2, BUDDHA_BASE3
 };

@@ -76,7 +76,7 @@
 #define BUDDHA_IRQ2	0xf40		/* interrupt */
 #define BUDDHA_IRQ3	0xf80

-static const int buddha_irqports[CATWEASEL_NUM_HWIFS] __initdata = {
+static int buddha_irqports[CATWEASEL_NUM_HWIFS] __initdata = {
     BUDDHA_IRQ1, BUDDHA_IRQ2, BUDDHA_IRQ3
 };

diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/eql.c linux-dj/drivers/net/eql.c
--- linux-ac/drivers/net/eql.c	Wed Jul  4 22:41:33 2001
+++ linux-dj/drivers/net/eql.c	Sat Aug 25 02:30:48 2001
@@ -121,7 +121,7 @@

 #include <asm/uaccess.h>

-static const char version[] __initdata =
+static char version[] __initdata =
 	"Equalizer1996: $Revision: 1.2.1 $ $Date: 1996/09/22 13:52:00 $ Simon Janes (simon@ncm.com)\n";

 #ifndef EQL_DEBUG
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/ewrk3.c linux-dj/drivers/net/ewrk3.c
--- linux-ac/drivers/net/ewrk3.c	Thu Jun 28 01:10:55 2001
+++ linux-dj/drivers/net/ewrk3.c	Sat Aug 25 02:29:31 2001
@@ -164,7 +164,7 @@

 #include "ewrk3.h"

-static const char version[] __initdata =
+static char version[] __initdata =
 "ewrk3.c:v0.43a 2001/02/04 davies@maniac.ultranet.com\n";

 #ifdef EWRK3_DEBUG
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/hamradio/6pack.c linux-dj/drivers/net/hamradio/6pack.c
--- linux-ac/drivers/net/hamradio/6pack.c	Wed Apr 18 22:40:06 2001
+++ linux-dj/drivers/net/hamradio/6pack.c	Sat Aug 25 02:32:16 2001
@@ -699,10 +699,10 @@

 /* Initialize 6pack control device -- register 6pack line discipline */

-static const char msg_banner[]  __initdata = KERN_INFO "AX.25: 6pack driver, " SIXPACK_VERSION " (dynamic channels, max=%d)\n";
-static const char msg_invparm[] __initdata = KERN_ERR  "6pack: sixpack_maxdev parameter too large.\n";
-static const char msg_nomem[]   __initdata = KERN_ERR  "6pack: can't allocate sixpack_ctrls[] array! No 6pack available.\n";
-static const char msg_regfail[] __initdata = KERN_ERR  "6pack: can't register line discipline (err = %d)\n";
+static char msg_banner[]  __initdata = KERN_INFO "AX.25: 6pack driver, " SIXPACK_VERSION " (dynamic channels, max=%d)\n";
+static char msg_invparm[] __initdata = KERN_ERR  "6pack: sixpack_maxdev parameter too large.\n";
+static char msg_nomem[]   __initdata = KERN_ERR  "6pack: can't allocate sixpack_ctrls[] array! No 6pack available.\n";
+static char msg_regfail[] __initdata = KERN_ERR  "6pack: can't register line discipline (err = %d)\n";

 static int __init sixpack_init_driver(void)
 {
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/hamradio/bpqether.c linux-dj/drivers/net/hamradio/bpqether.c
--- linux-ac/drivers/net/hamradio/bpqether.c	Thu Jun 28 01:10:55 2001
+++ linux-dj/drivers/net/hamradio/bpqether.c	Sat Aug 25 02:31:30 2001
@@ -87,7 +87,7 @@

 #include <linux/bpqether.h>

-static const char banner[] __initdata = KERN_INFO "AX.25: bpqether driver version 004\n";
+static char banner[] __initdata = KERN_INFO "AX.25: bpqether driver version 004\n";

 static unsigned char ax25_bcast[AX25_ADDR_LEN] =
 	{'Q' << 1, 'S' << 1, 'T' << 1, ' ' << 1, ' ' << 1, ' ' << 1, '0' << 1};
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/hamradio/mkiss.c linux-dj/drivers/net/hamradio/mkiss.c
--- linux-ac/drivers/net/hamradio/mkiss.c	Wed Apr 18 22:40:06 2001
+++ linux-dj/drivers/net/hamradio/mkiss.c	Sat Aug 25 02:31:41 2001
@@ -54,7 +54,7 @@
 #include <linux/tcp.h>
 #endif

-static const char banner[] __initdata = KERN_INFO "mkiss: AX.25 Multikiss, Hans Albas PE1AYX\n";
+static char banner[] __initdata = KERN_INFO "mkiss: AX.25 Multikiss, Hans Albas PE1AYX\n";

 #define NR_MKISS 4
 #define MKISS_SERIAL_TYPE_NORMAL 1
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/hamradio/scc.c linux-dj/drivers/net/hamradio/scc.c
--- linux-ac/drivers/net/hamradio/scc.c	Sun Aug  5 21:12:40 2001
+++ linux-dj/drivers/net/hamradio/scc.c	Sat Aug 25 02:31:51 2001
@@ -184,7 +184,7 @@
 #include <linux/kernel.h>
 #include <linux/proc_fs.h>

-static const char banner[] __initdata = KERN_INFO "AX.25: Z8530 SCC driver version "VERSION".dl1bke\n";
+static char banner[] __initdata = KERN_INFO "AX.25: Z8530 SCC driver version "VERSION".dl1bke\n";

 static void t_dwait(unsigned long);
 static void t_txdelay(unsigned long);
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/hamradio/yam.c linux-dj/drivers/net/hamradio/yam.c
--- linux-ac/drivers/net/hamradio/yam.c	Wed Apr 18 22:40:06 2001
+++ linux-dj/drivers/net/hamradio/yam.c	Sat Aug 25 02:32:42 2001
@@ -81,7 +81,7 @@
 /* --------------------------------------------------------------------- */

 static const char yam_drvname[] = "yam";
-static const char yam_drvinfo[] __initdata = KERN_INFO "YAM driver version 0.8 by F1OAT/F6FBB\n";
+static char yam_drvinfo[] __initdata = KERN_INFO "YAM driver version 0.8 by F1OAT/F6FBB\n";

 /* --------------------------------------------------------------------- */

diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/strip.c linux-dj/drivers/net/strip.c
--- linux-ac/drivers/net/strip.c	Sun Feb  4 18:05:30 2001
+++ linux-dj/drivers/net/strip.c	Sat Aug 25 02:29:16 2001
@@ -2828,7 +2828,7 @@
  * STRIP driver
  */

-static const char signon[] __initdata = KERN_INFO "STRIP: Version %s (unlimited channels)\n";
+static char signon[] __initdata = KERN_INFO "STRIP: Version %s (unlimited channels)\n";

 static int __init strip_init_driver(void)
 {
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/wan/lapbether.c linux-dj/drivers/net/wan/lapbether.c
--- linux-ac/drivers/net/wan/lapbether.c	Thu Jun 28 01:10:55 2001
+++ linux-dj/drivers/net/wan/lapbether.c	Sat Aug 25 02:30:59 2001
@@ -467,7 +467,7 @@
 	notifier_call: lapbeth_device_event,
 };

-static const char banner[] __initdata = KERN_INFO "LAPB Ethernet driver version 0.01\n";
+static char banner[] __initdata = KERN_INFO "LAPB Ethernet driver version 0.01\n";

 static int __init lapbeth_init_driver(void)
 {
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/wan/syncppp.c linux-dj/drivers/net/wan/syncppp.c
--- linux-ac/drivers/net/wan/syncppp.c	Sat Aug 25 02:23:26 2001
+++ linux-dj/drivers/net/wan/syncppp.c	Sat Aug 25 02:31:09 2001
@@ -1397,7 +1397,7 @@
 	func:	sppp_rcv,
 };

-static const char banner[] __initdata =
+static char banner[] __initdata =
 	KERN_INFO "Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994\n"
 	KERN_INFO "Linux port (c) 1998 Building Number Three Ltd & "
 		  "Jan \"Yenya\" Kasprzak.\n";
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/wan/z85230.c linux-dj/drivers/net/wan/z85230.c
--- linux-ac/drivers/net/wan/z85230.c	Wed Mar  7 03:44:37 2001
+++ linux-dj/drivers/net/wan/z85230.c	Sat Aug 25 02:31:18 2001
@@ -1739,7 +1739,7 @@
 /*
  *	Module support
  */
-static const char banner[] __initdata = KERN_INFO "Generic Z85C30/Z85230 interface driver v0.02\n";
+static char banner[] __initdata = KERN_INFO "Generic Z85C30/Z85230 interface driver v0.02\n";

 static int __init z85230_init_driver(void)
 {
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/wireless/airport.c linux-dj/drivers/net/wireless/airport.c
--- linux-ac/drivers/net/wireless/airport.c	Sat Aug 25 02:23:27 2001
+++ linux-dj/drivers/net/wireless/airport.c	Sat Aug 25 02:32:57 2001
@@ -32,7 +32,7 @@
 #include "hermes.h"
 #include "orinoco.h"

-static const char version[] __initdata = "airport.c 0.06f (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
+static char version[] __initdata = "airport.c 0.06f (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("Driver for the Apple Airport wireless card.");

diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/wireless/hermes.c linux-dj/drivers/net/wireless/hermes.c
--- linux-ac/drivers/net/wireless/hermes.c	Sat Aug 25 02:23:27 2001
+++ linux-dj/drivers/net/wireless/hermes.c	Sat Aug 25 02:33:10 2001
@@ -30,7 +30,7 @@

 #include "hermes.h"

-static const char version[] __initdata = "hermes.c: 1 Aug 2001 David Gibson <hermes@gibson.dropbear.id.au>";
+static char version[] __initdata = "hermes.c: 1 Aug 2001 David Gibson <hermes@gibson.dropbear.id.au>";
 MODULE_DESCRIPTION("Low-level driver helper for Lucent Hermes chipset and Prism II HFA384x wireless MAC controller");
 MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");

diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/wireless/orinoco.c linux-dj/drivers/net/wireless/orinoco.c
--- linux-ac/drivers/net/wireless/orinoco.c	Sat Aug 25 02:23:27 2001
+++ linux-dj/drivers/net/wireless/orinoco.c	Sat Aug 25 02:33:26 2001
@@ -220,7 +220,7 @@
 #include "hermes.h"
 #include "orinoco.h"

-static const char version[] __initdata = "orinoco.c 0.06f (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char version[] __initdata = "orinoco.c 0.06f (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
 MODULE_DESCRIPTION("Driver for Lucent Orinoco, Prism II based and similar wireless cards");

diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/net/wireless/orinoco_cs.c linux-dj/drivers/net/wireless/orinoco_cs.c
--- linux-ac/drivers/net/wireless/orinoco_cs.c	Sat Aug 25 02:23:27 2001
+++ linux-dj/drivers/net/wireless/orinoco_cs.c	Sat Aug 25 02:40:20 2001
@@ -42,7 +42,7 @@

 /*====================================================================*/

-static const char version[] __initdata = "orinoco_cs.c 0.06f (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char version[] __initdata = "orinoco_cs.c 0.06f (David Gibson <hermes@gibson.dropbear.id.au> and others)";

 MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
 MODULE_DESCRIPTION("Driver for PCMCIA Lucent Orinoco, Prism II based and similar wireless cards");
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/scsi/seagate.c linux-dj/drivers/scsi/seagate.c
--- linux-ac/drivers/scsi/seagate.c	Sun Nov 12 03:01:11 2000
+++ linux-dj/drivers/scsi/seagate.c	Sat Aug 25 02:40:06 2001
@@ -291,7 +291,7 @@
 }
 Signature;

-static const Signature __initdata signatures[] =
+static Signature __initdata signatures[] =
 {
   {"ST01 v1.7  (C) Copyright 1987 Seagate", 15, 37, SEAGATE},
   {"SCSI BIOS 2.00  (C) Copyright 1987 Seagate", 15, 40, SEAGATE},
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/sound/sonicvibes.c linux-dj/drivers/sound/sonicvibes.c
--- linux-ac/drivers/sound/sonicvibes.c	Sat Aug 25 02:23:29 2001
+++ linux-dj/drivers/sound/sonicvibes.c	Sat Aug 25 02:39:57 2001
@@ -2481,7 +2481,7 @@

 static int __devinit sv_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
 {
-	static const char __initdata sv_ddma_name[] = "S3 Inc. SonicVibes DDMA Controller";
+	static char __initdata sv_ddma_name[] = "S3 Inc. SonicVibes DDMA Controller";
        	struct sv_state *s;
 	mm_segment_t fs;
 	int i, val, ret;
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/video/amifb.c linux-dj/drivers/video/amifb.c
--- linux-ac/drivers/video/amifb.c	Wed Apr 18 19:49:12 2001
+++ linux-dj/drivers/video/amifb.c	Sat Aug 25 02:39:10 2001
@@ -914,7 +914,7 @@

 #define NUM_TOTAL_MODES  ARRAY_SIZE(ami_modedb)

-static const char *mode_option __initdata = NULL;
+static char *mode_option __initdata = NULL;
 static int round_down_bpp = 1;	/* for mode probing */

 	/*
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/video/aty/atyfb_base.c linux-dj/drivers/video/aty/atyfb_base.c
--- linux-ac/drivers/video/aty/atyfb_base.c	Sat Aug 25 02:23:30 2001
+++ linux-dj/drivers/video/aty/atyfb_base.c	Sat Aug 25 02:35:19 2001
@@ -251,7 +251,7 @@
 static int default_mclk __initdata = 0;

 #ifndef MODULE
-static const char *mode_option __initdata = NULL;
+static char *mode_option __initdata = NULL;
 #endif

 #ifdef CONFIG_PPC
@@ -271,33 +271,33 @@
 static unsigned long phys_guiregbase[FB_MAX] __initdata = { 0, };
 #endif

-static const char m64n_gx[] __initdata = "mach64GX (ATI888GX00)";
-static const char m64n_cx[] __initdata = "mach64CX (ATI888CX00)";
-static const char m64n_ct[] __initdata = "mach64CT (ATI264CT)";
-static const char m64n_et[] __initdata = "mach64ET (ATI264ET)";
-static const char m64n_vta3[] __initdata = "mach64VTA3 (ATI264VT)";
-static const char m64n_vta4[] __initdata = "mach64VTA4 (ATI264VT)";
-static const char m64n_vtb[] __initdata = "mach64VTB (ATI264VTB)";
-static const char m64n_vt4[] __initdata = "mach64VT4 (ATI264VT4)";
-static const char m64n_gt[] __initdata = "3D RAGE (GT)";
-static const char m64n_gtb[] __initdata = "3D RAGE II+ (GTB)";
-static const char m64n_iic_p[] __initdata = "3D RAGE IIC (PCI)";
-static const char m64n_iic_a[] __initdata = "3D RAGE IIC (AGP)";
-static const char m64n_lt[] __initdata = "3D RAGE LT";
-static const char m64n_ltg[] __initdata = "3D RAGE LT-G";
-static const char m64n_gtc_ba[] __initdata = "3D RAGE PRO (BGA, AGP)";
-static const char m64n_gtc_ba1[] __initdata = "3D RAGE PRO (BGA, AGP, 1x only)";
-static const char m64n_gtc_bp[] __initdata = "3D RAGE PRO (BGA, PCI)";
-static const char m64n_gtc_pp[] __initdata = "3D RAGE PRO (PQFP, PCI)";
-static const char m64n_gtc_ppl[] __initdata = "3D RAGE PRO (PQFP, PCI, limited 3D)";
-static const char m64n_xl[] __initdata = "3D RAGE (XL)";
-static const char m64n_ltp_a[] __initdata = "3D RAGE LT PRO (AGP)";
-static const char m64n_ltp_p[] __initdata = "3D RAGE LT PRO (PCI)";
-static const char m64n_mob_p[] __initdata = "3D RAGE Mobility (PCI)";
-static const char m64n_mob_a[] __initdata = "3D RAGE Mobility (AGP)";
+static char m64n_gx[] __initdata = "mach64GX (ATI888GX00)";
+static char m64n_cx[] __initdata = "mach64CX (ATI888CX00)";
+static char m64n_ct[] __initdata = "mach64CT (ATI264CT)";
+static char m64n_et[] __initdata = "mach64ET (ATI264ET)";
+static char m64n_vta3[] __initdata = "mach64VTA3 (ATI264VT)";
+static char m64n_vta4[] __initdata = "mach64VTA4 (ATI264VT)";
+static char m64n_vtb[] __initdata = "mach64VTB (ATI264VTB)";
+static char m64n_vt4[] __initdata = "mach64VT4 (ATI264VT4)";
+static char m64n_gt[] __initdata = "3D RAGE (GT)";
+static char m64n_gtb[] __initdata = "3D RAGE II+ (GTB)";
+static char m64n_iic_p[] __initdata = "3D RAGE IIC (PCI)";
+static char m64n_iic_a[] __initdata = "3D RAGE IIC (AGP)";
+static char m64n_lt[] __initdata = "3D RAGE LT";
+static char m64n_ltg[] __initdata = "3D RAGE LT-G";
+static char m64n_gtc_ba[] __initdata = "3D RAGE PRO (BGA, AGP)";
+static char m64n_gtc_ba1[] __initdata = "3D RAGE PRO (BGA, AGP, 1x only)";
+static char m64n_gtc_bp[] __initdata = "3D RAGE PRO (BGA, PCI)";
+static char m64n_gtc_pp[] __initdata = "3D RAGE PRO (PQFP, PCI)";
+static char m64n_gtc_ppl[] __initdata = "3D RAGE PRO (PQFP, PCI, limited 3D)";
+static char m64n_xl[] __initdata = "3D RAGE (XL)";
+static char m64n_ltp_a[] __initdata = "3D RAGE LT PRO (AGP)";
+static char m64n_ltp_p[] __initdata = "3D RAGE LT PRO (PCI)";
+static char m64n_mob_p[] __initdata = "3D RAGE Mobility (PCI)";
+static char m64n_mob_a[] __initdata = "3D RAGE Mobility (AGP)";


-static const struct {
+static struct {
     u16 pci_id, chip_type;
     u8 rev_mask, rev_val;
     const char *name;
@@ -358,24 +358,24 @@
 #endif /* CONFIG_FB_ATY_CT */
 };

-static const char ram_dram[] __initdata = "DRAM";
-static const char ram_vram[] __initdata = "VRAM";
-static const char ram_edo[] __initdata = "EDO";
-static const char ram_sdram[] __initdata = "SDRAM";
-static const char ram_sgram[] __initdata = "SGRAM";
-static const char ram_wram[] __initdata = "WRAM";
-static const char ram_off[] __initdata = "OFF";
-static const char ram_resv[] __initdata = "RESV";
+static char ram_dram[] __initdata = "DRAM";
+static char ram_vram[] __initdata = "VRAM";
+static char ram_edo[] __initdata = "EDO";
+static char ram_sdram[] __initdata = "SDRAM";
+static char ram_sgram[] __initdata = "SGRAM";
+static char ram_wram[] __initdata = "WRAM";
+static char ram_off[] __initdata = "OFF";
+static char ram_resv[] __initdata = "RESV";

 #ifdef CONFIG_FB_ATY_GX
-static const char *aty_gx_ram[8] __initdata = {
+static char *aty_gx_ram[8] __initdata = {
     ram_dram, ram_vram, ram_vram, ram_dram,
     ram_dram, ram_vram, ram_vram, ram_resv
 };
 #endif /* CONFIG_FB_ATY_GX */

 #ifdef CONFIG_FB_ATY_CT
-static const char *aty_ct_ram[8] __initdata = {
+static char *aty_ct_ram[8] __initdata = {
     ram_off, ram_dram, ram_edo, ram_edo,
     ram_sdram, ram_sgram, ram_wram, ram_resv
 };
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/video/aty128fb.c linux-dj/drivers/video/aty128fb.c
--- linux-ac/drivers/video/aty128fb.c	Sat Aug 25 02:23:30 2001
+++ linux-dj/drivers/video/aty128fb.c	Sat Aug 25 02:38:57 2001
@@ -146,7 +146,7 @@
 };

 /* supported Rage128 chipsets */
-static const struct aty128_chip_info aty128_pci_probe_list[] __initdata =
+static struct aty128_chip_info aty128_pci_probe_list[] __initdata =
 {
     {"Rage128 RE (PCI)", PCI_DEVICE_ID_ATI_RAGE128_RE, rage_128},
     {"Rage128 RF (AGP)", PCI_DEVICE_ID_ATI_RAGE128_RF, rage_128},
@@ -220,7 +220,7 @@
 static char *mode __initdata = NULL;
 static int  nomtrr __initdata = 0;

-static const char *mode_option __initdata = NULL;
+static char *mode_option __initdata = NULL;

 #ifdef CONFIG_PPC
 static int default_vmode __initdata = VMODE_1024_768_60;
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/video/modedb.c linux-dj/drivers/video/modedb.c
--- linux-ac/drivers/video/modedb.c	Sat Aug 25 02:23:30 2001
+++ linux-dj/drivers/video/modedb.c	Sat Aug 25 02:38:25 2001
@@ -41,7 +41,7 @@

 #define DEFAULT_MODEDB_INDEX	0

-static const struct fb_videomode modedb[] __initdata = {
+static struct fb_videomode modedb[] __initdata = {
 #if defined(CONFIG_FB_ATY_CT_VAIO_LCD)
     {
 	/* 1024x480 @ 65 Hz */
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/video/pvr2fb.c linux-dj/drivers/video/pvr2fb.c
--- linux-ac/drivers/video/pvr2fb.c	Sat Aug 25 02:23:30 2001
+++ linux-dj/drivers/video/pvr2fb.c	Sat Aug 25 02:37:49 2001
@@ -299,7 +299,7 @@
 #define DEFMODE_VGA	2

 static int defmode = DEFMODE_NTSC;
-static const char *mode_option __initdata = NULL;
+static char *mode_option __initdata = NULL;

 /* Get the fixed part of the display */

diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/video/riva/fbdev.c linux-dj/drivers/video/riva/fbdev.c
--- linux-ac/drivers/video/riva/fbdev.c	Thu Jul 19 00:36:37 2001
+++ linux-dj/drivers/video/riva/fbdev.c	Sat Aug 25 02:38:15 2001
@@ -260,7 +260,7 @@
 #endif

 #ifndef MODULE
-static const char *mode_option __initdata = NULL;
+static char *mode_option __initdata = NULL;
 #else
 static char *font = NULL;
 #endif
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/video/tdfxfb.c linux-dj/drivers/video/tdfxfb.c
--- linux-ac/drivers/video/tdfxfb.c	Sat Aug 25 02:23:30 2001
+++ linux-dj/drivers/video/tdfxfb.c	Sat Aug 25 02:37:57 2001
@@ -529,7 +529,7 @@
 #endif
 static int  nohwcursor = 0;
 static char __initdata fontname[40] = { 0 };
-static const char *mode_option __initdata = NULL;
+static char *mode_option __initdata = NULL;

 /* -------------------------------------------------------------------------
  *                      Hardware-specific funcions
diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/zorro/names.c linux-dj/drivers/zorro/names.c
--- linux-ac/drivers/zorro/names.c	Fri Oct 27 18:56:41 2000
+++ linux-dj/drivers/zorro/names.c	Sat Aug 25 02:37:26 2001
@@ -37,9 +37,9 @@
  * real memory.. Parse the same file multiple times
  * to get all the info.
  */
-#define MANUF( manuf, name )		static const char __manufstr_##manuf[] __initdata = name;
+#define MANUF( manuf, name )		static char __manufstr_##manuf[] __initdata = name;
 #define ENDMANUF()
-#define PRODUCT( manuf, prod, name ) 	static const char __prodstr_##manuf##prod[] __initdata = name;
+#define PRODUCT( manuf, prod, name ) 	static char __prodstr_##manuf##prod[] __initdata = name;
 #include "devlist.h"


@@ -48,7 +48,7 @@
 #define PRODUCT( manuf, prod, name )	{ 0x##prod, 0, __prodstr_##manuf##prod },
 #include "devlist.h"

-static const struct zorro_manuf_info __initdata zorro_manuf_list[] = {
+static struct zorro_manuf_info __initdata zorro_manuf_list[] = {
 #define MANUF( manuf, name )		{ 0x##manuf, sizeof(__prods_##manuf) / sizeof(struct zorro_prod_info), __manufstr_##manuf, __prods_##manuf },
 #define ENDMANUF()
 #define PRODUCT( manuf, prod, name )
diff -urN --exclude-from=/home/davej/.exclude linux-ac/net/ax25/af_ax25.c linux-dj/net/ax25/af_ax25.c
--- linux-ac/net/ax25/af_ax25.c	Thu Apr 12 20:11:39 2001
+++ linux-dj/net/ax25/af_ax25.c	Sat Aug 25 02:36:39 2001
@@ -1841,7 +1841,7 @@
 EXPORT_SYMBOL(null_ax25_address);
 EXPORT_SYMBOL(ax25_display_timer);

-static const char banner[] __initdata = KERN_INFO "NET4: G4KLX/GW4PTS AX.25 for Linux. Version 0.37 for Linux NET4.0\n";
+static char banner[] __initdata = KERN_INFO "NET4: G4KLX/GW4PTS AX.25 for Linux. Version 0.37 for Linux NET4.0\n";

 static int __init ax25_init(void)
 {
diff -urN --exclude-from=/home/davej/.exclude linux-ac/net/ipv4/ipip.c linux-dj/net/ipv4/ipip.c
--- linux-ac/net/ipv4/ipip.c	Thu May 24 23:00:59 2001
+++ linux-dj/net/ipv4/ipip.c	Sat Aug 25 02:36:04 2001
@@ -878,7 +878,7 @@
 	name:		"IPIP"
 };

-static const char banner[] __initdata =
+static char banner[] __initdata =
 	KERN_INFO "IPv4 over IPv4 tunneling driver\n";

 int __init ipip_init(void)
diff -urN --exclude-from=/home/davej/.exclude linux-ac/net/ipx/af_ipx.c linux-dj/net/ipx/af_ipx.c
--- linux-ac/net/ipx/af_ipx.c	Wed May 16 18:31:27 2001
+++ linux-dj/net/ipx/af_ipx.c	Sat Aug 25 02:35:53 2001
@@ -2536,7 +2536,7 @@

 static unsigned char ipx_8022_type = 0xE0;
 static unsigned char ipx_snap_id[5] = { 0x0, 0x0, 0x0, 0x81, 0x37 };
-static const char banner[] __initdata =
+static char banner[] __initdata =
 	KERN_INFO "NET4: Linux IPX 0.47 for NET4.0\n"
 	KERN_INFO "IPX Portions Copyright (c) 1995 Caldera, Inc.\n" \
 	KERN_INFO "IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.\n";
diff -urN --exclude-from=/home/davej/.exclude linux-ac/net/ipx/af_spx.c linux-dj/net/ipx/af_spx.c
--- linux-ac/net/ipx/af_spx.c	Sat Jun 30 18:38:44 2001
+++ linux-dj/net/ipx/af_spx.c	Sat Aug 25 02:35:36 2001
@@ -910,7 +910,7 @@
 	create:		spx_create,
 };

-static const char banner[] __initdata = KERN_INFO "NET4: Sequenced Packet eXchange (SPX) 0.02 for Linux NET4.0\n";
+static char banner[] __initdata = KERN_INFO "NET4: Sequenced Packet eXchange (SPX) 0.02 for Linux NET4.0\n";

 static int __init spx_proto_init(void)
 {
diff -urN --exclude-from=/home/davej/.exclude linux-ac/net/lapb/lapb_iface.c linux-dj/net/lapb/lapb_iface.c
--- linux-ac/net/lapb/lapb_iface.c	Thu Apr 12 20:16:36 2001
+++ linux-dj/net/lapb/lapb_iface.c	Sat Aug 25 02:36:27 2001
@@ -397,7 +397,7 @@
 EXPORT_SYMBOL(lapb_data_request);
 EXPORT_SYMBOL(lapb_data_received);

-static const char banner[] __initdata = KERN_INFO "NET4: LAPB for Linux. Version 0.01 for NET4.0\n";
+static char banner[] __initdata = KERN_INFO "NET4: LAPB for Linux. Version 0.01 for NET4.0\n";

 static int __init lapb_init(void)
 {
diff -urN --exclude-from=/home/davej/.exclude linux-ac/net/netrom/af_netrom.c linux-dj/net/netrom/af_netrom.c
--- linux-ac/net/netrom/af_netrom.c	Thu Apr 19 16:38:50 2001
+++ linux-dj/net/netrom/af_netrom.c	Sat Aug 25 02:36:15 2001
@@ -1262,7 +1262,7 @@

 static struct net_device *dev_nr;

-static const char banner[] __initdata = KERN_INFO "G4KLX NET/ROM for Linux. Version 0.7 for AX25.037 Linux 2.4\n";
+static char banner[] __initdata = KERN_INFO "G4KLX NET/ROM for Linux. Version 0.7 for AX25.037 Linux 2.4\n";

 static int __init nr_proto_init(void)
 {
diff -urN --exclude-from=/home/davej/.exclude linux-ac/net/unix/af_unix.c linux-dj/net/unix/af_unix.c
--- linux-ac/net/unix/af_unix.c	Sat Aug 25 02:23:37 2001
+++ linux-dj/net/unix/af_unix.c	Sat Aug 25 02:36:54 2001
@@ -1852,7 +1852,7 @@
 static inline void unix_sysctl_unregister(void) {}
 #endif

-static const char banner[] __initdata = KERN_INFO "NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.\n";
+static char banner[] __initdata = KERN_INFO "NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.\n";

 static int __init af_unix_init(void)
 {


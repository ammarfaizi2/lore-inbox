Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268377AbTBSC7i>; Tue, 18 Feb 2003 21:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268367AbTBSC6T>; Tue, 18 Feb 2003 21:58:19 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:49416 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S268387AbTBSC53>; Tue, 18 Feb 2003 21:57:29 -0500
Subject: [PATCH] 2.5.62 spelling fix for compatable -> compatible in 45
	files.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 18 Feb 2003 19:58:51 -0700
Message-Id: <1045623532.10680.301.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the following spelling fixes.

compatable    -> compatible
compatability -> compatibility 

 Documentation/pnp.txt                   |    2 +-
 Documentation/rpc-cache.txt             |    2 +-
 Documentation/sound/oss/PSS-updates     |    8 ++++----
 arch/alpha/lib/ev6-memcpy.S             |    2 +-
 arch/i386/kernel/cpu/cyrix.c            |    2 +-
 arch/ia64/ia32/sys_ia32.c               |    2 +-
 arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c   |    2 +-
 arch/m68k/ifpsp060/src/isp.S            |    2 +-
 arch/mips/kernel/irixsig.c              |    2 +-
 arch/mips64/kernel/linux32.c            |    2 +-
 arch/parisc/kernel/ioctl32.c            |    2 +-
 arch/ppc/xmon/ansidecl.h                |    2 +-
 arch/ppc64/kernel/sys32.S               |    2 +-
 arch/ppc64/kernel/sys_ppc32.c           |    2 +-
 arch/ppc64/xmon/ansidecl.h              |    2 +-
 arch/s390x/kernel/linux32.c             |    2 +-
 arch/sparc64/kernel/ioctl32.c           |    2 +-
 arch/sparc64/kernel/sunos_ioctl32.c     |    2 +-
 arch/sparc64/kernel/sys32.S             |    2 +-
 arch/sparc64/kernel/sys_sparc32.c       |    2 +-
 arch/sparc64/kernel/sys_sunos32.c       |    2 +-
 arch/x86_64/ia32/ia32_ioctl.c           |    2 +-
 arch/x86_64/ia32/sys_ia32.c             |    2 +-
 drivers/char/agp/via-agp.c              |    4 ++--
 drivers/char/ftape/zftape/zftape-ctl.c  |    2 +-
 drivers/char/ftape/zftape/zftape-eof.c  |    2 +-
 drivers/char/ftape/zftape/zftape-vtbl.c |    2 +-
 drivers/char/ftape/zftape/zftape-vtbl.h |    2 +-
 drivers/char/ppdev.c                    |    2 +-
 drivers/ide/pci/serverworks.c           |    2 +-
 drivers/md/md.c                         |    2 +-
 drivers/net/am79c961a.c                 |    2 +-
 drivers/scsi/3w-xxxx.c                  |    2 +-
 drivers/scsi/3w-xxxx.h                  |    2 +-
 drivers/scsi/pci2220i.c                 |    4 ++--
 drivers/serial/amba.c                   |    2 +-
 fs/befs/ChangeLog                       |    2 +-
 fs/cifs/CHANGES                         |    2 +-
 include/asm-arm/hardware/iomd.h         |    2 +-
 include/asm-ia64/sn/eeprom.h            |    2 +-
 include/asm-ppc64/iSeries/ItLpNaca.h    |    2 +-
 include/asm-sparc64/psrcompat.h         |    2 +-
 include/linux/cdrom.h                   |    2 +-
 include/linux/init.h                    |    2 +-
 sound/oss/mad16.c                       |    2 +-
 45 files changed, 50 insertions(+), 50 deletions(-)

diff -ur linux-2.5.62-1104-orig/Documentation/pnp.txt linux-2.5.62-1104/Documentation/pnp.txt
--- linux-2.5.62-1104-orig/Documentation/pnp.txt	Thu Jan 16 19:21:39 2003
+++ linux-2.5.62-1104/Documentation/pnp.txt	Tue Feb 18 18:25:13 2003
@@ -233,7 +233,7 @@
 The Old Way
 ...........
 
-a series of compatability functions have been created to make it easy to convert 
+a series of compatibility functions have been created to make it easy to convert 
 
 ISAPNP drivers.  They should serve as a temporary solution only.
 
diff -ur linux-2.5.62-1104-orig/Documentation/rpc-cache.txt linux-2.5.62-1104/Documentation/rpc-cache.txt
--- linux-2.5.62-1104-orig/Documentation/rpc-cache.txt	Thu Jan 16 19:21:43 2003
+++ linux-2.5.62-1104/Documentation/rpc-cache.txt	Tue Feb 18 18:25:13 2003
@@ -146,7 +146,7 @@
 Note: If a cache has no active readers on the channel, and has had not
 active readers for more than 60 seconds, further requests will not be
 added to the channel but instead all looks that do not find a valid
-entry will fail.  This is partly for backward compatability: The
+entry will fail.  This is partly for backward compatibility: The
 previous nfs exports table was deemed to be authoritative and a
 failed lookup meant a definite 'no'.
 
diff -ur linux-2.5.62-1104-orig/Documentation/sound/oss/PSS-updates linux-2.5.62-1104/Documentation/sound/oss/PSS-updates
--- linux-2.5.62-1104-orig/Documentation/sound/oss/PSS-updates	Thu Jan 16 19:22:59 2003
+++ linux-2.5.62-1104/Documentation/sound/oss/PSS-updates	Tue Feb 18 18:25:13 2003
@@ -10,7 +10,7 @@
 
 	This parameter is basically a flag.  A 0 will leave the joystick port 
 disabled, while a non-zero value would enable the joystick port.  The default 
-setting is pss_enable_joystick=0 as this keeps this driver fully compatable 
+setting is pss_enable_joystick=0 as this keeps this driver fully compatible 
 with systems that were using previous versions of this driver.  If you wish to 
 enable the joystick port you will have to add pss_enable_joystick=1 as an 
 argument to the driver.  To actually use the joystick port you will then have 
@@ -31,7 +31,7 @@
 assigned to the CDROM port when you loaded your pss sound driver.  (ex. 
 modprobe pss pss_cdrom_port=0x340 && modprobe aztcd aztcd=0x340)  The default 
 setting of this parameter leaves the CDROM port disabled to maintain full 
-compatability with systems using previous versions of this driver.
+compatibility with systems using previous versions of this driver.
 
 	Other options have also been added for the added convenience and utility 
 of the user.  These options are only available if this driver is loaded as a 
@@ -49,7 +49,7 @@
 mpu401 && rmmod sound && rmmod soundcore" and retain the full functionality of 
 his CDROM and/or joystick port(s) while gaining back the memory previously used 
 by the sound drivers.  This default setting of this parameter is 0 to retain 
-full behavioral compatability with previous versions of this driver.
+full behavioral compatibility with previous versions of this driver.
 
 pss_keep_settings
 
@@ -60,7 +60,7 @@
 emulations by default on the driver's unloading (as it probably should), so 
 specifying it now will ensure that all future versions of this driver will 
 continue to work as expected.  The default value of this parameter is 1 to 
-retain full behavioral compatability with previous versions of this driver.
+retain full behavioral compatibility with previous versions of this driver.
 
 pss_firmware
 
diff -ur linux-2.5.62-1104-orig/arch/alpha/lib/ev6-memcpy.S linux-2.5.62-1104/arch/alpha/lib/ev6-memcpy.S
--- linux-2.5.62-1104-orig/arch/alpha/lib/ev6-memcpy.S	Thu Jan 16 19:21:39 2003
+++ linux-2.5.62-1104/arch/alpha/lib/ev6-memcpy.S	Tue Feb 18 18:25:13 2003
@@ -243,6 +243,6 @@
 
 	.end memcpy
 
-/* For backwards module compatability.  */
+/* For backwards module compatibility.  */
 __memcpy = memcpy
 .globl __memcpy
diff -ur linux-2.5.62-1104-orig/arch/i386/kernel/cpu/cyrix.c linux-2.5.62-1104/arch/i386/kernel/cpu/cyrix.c
--- linux-2.5.62-1104-orig/arch/i386/kernel/cpu/cyrix.c	Thu Jan 16 19:21:44 2003
+++ linux-2.5.62-1104/arch/i386/kernel/cpu/cyrix.c	Tue Feb 18 18:25:13 2003
@@ -74,7 +74,7 @@
 
 /*
  * Reset the slow-loop (SLOP) bit on the 686(L) which is set by some old
- * BIOSes for compatability with DOS games.  This makes the udelay loop
+ * BIOSes for compatibility with DOS games.  This makes the udelay loop
  * work correctly, and improves performance.
  *
  * FIXME: our newer udelay uses the tsc. We dont need to frob with SLOP
diff -ur linux-2.5.62-1104-orig/arch/ia64/ia32/sys_ia32.c linux-2.5.62-1104/arch/ia64/ia32/sys_ia32.c
--- linux-2.5.62-1104-orig/arch/ia64/ia32/sys_ia32.c	Mon Feb 10 12:22:53 2003
+++ linux-2.5.62-1104/arch/ia64/ia32/sys_ia32.c	Tue Feb 18 18:25:13 2003
@@ -4063,7 +4063,7 @@
 	return err;
 }
 
-/* Handle adjtimex compatability. */
+/* Handle adjtimex compatibility. */
 
 struct timex32 {
 	u32 modes;
diff -ur linux-2.5.62-1104-orig/arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c linux-2.5.62-1104/arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c
--- linux-2.5.62-1104-orig/arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c	Thu Jan 16 19:22:56 2003
+++ linux-2.5.62-1104/arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c	Tue Feb 18 18:25:13 2003
@@ -272,7 +272,7 @@
 	    * the old do_pcibr_rrb_free() code only clears the enable bit
 	    * but I say we should clear the whole rrb (ie):
 	    *	  reg = reg & ~(RRB_MASK << (RRB_SIZE * rrb_index));
-	    * But to be compatable with old code we'll only clear enable.
+	    * But to be compatible with old code we'll only clear enable.
 	    */
 	    reg = reg & ~(RRB_ENABLE_BIT(bridge) << (RRB_SIZE * rrb_index));
 	    clr = clr | (enable_bit << (RRB_SIZE * rrb_index));
diff -ur linux-2.5.62-1104-orig/arch/m68k/ifpsp060/src/isp.S linux-2.5.62-1104/arch/m68k/ifpsp060/src/isp.S
--- linux-2.5.62-1104-orig/arch/m68k/ifpsp060/src/isp.S	Thu Jan 16 19:21:44 2003
+++ linux-2.5.62-1104/arch/m68k/ifpsp060/src/isp.S	Tue Feb 18 18:25:13 2003
@@ -2625,7 +2625,7 @@
 	addx.l		%d7, %d4		# add carry to hi(result)
 
 # the result is saved to the register file.
-# for '040 compatability, if Dl == Dh then only the hi(result) is
+# for '040 compatibility, if Dl == Dh then only the hi(result) is
 # saved. so, saving hi after lo accomplishes this without need to
 # check Dl,Dh equality.
 mul64_done:
diff -ur linux-2.5.62-1104-orig/arch/mips/kernel/irixsig.c linux-2.5.62-1104/arch/mips/kernel/irixsig.c
--- linux-2.5.62-1104-orig/arch/mips/kernel/irixsig.c	Mon Feb 17 17:35:59 2003
+++ linux-2.5.62-1104/arch/mips/kernel/irixsig.c	Tue Feb 18 18:25:13 2003
@@ -1,5 +1,5 @@
 /*
- * irixsig.c: WHEEE, IRIX signals!  YOW, am I compatable or what?!?!
+ * irixsig.c: WHEEE, IRIX signals!  YOW, am I compatible or what?!?!
  *
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  * Copyright (C) 1997 - 2000 Ralf Baechle (ralf@gnu.org)
diff -ur linux-2.5.62-1104-orig/arch/mips64/kernel/linux32.c linux-2.5.62-1104/arch/mips64/kernel/linux32.c
--- linux-2.5.62-1104-orig/arch/mips64/kernel/linux32.c	Thu Jan 16 19:22:19 2003
+++ linux-2.5.62-1104/arch/mips64/kernel/linux32.c	Tue Feb 18 18:25:13 2003
@@ -1800,7 +1800,7 @@
 	return ret;
 }
 
-/* Handle adjtimex compatability. */
+/* Handle adjtimex compatibility. */
 
 struct timex32 {
 	u32 modes;
diff -ur linux-2.5.62-1104-orig/arch/parisc/kernel/ioctl32.c linux-2.5.62-1104/arch/parisc/kernel/ioctl32.c
--- linux-2.5.62-1104-orig/arch/parisc/kernel/ioctl32.c	Thu Jan 16 19:21:35 2003
+++ linux-2.5.62-1104/arch/parisc/kernel/ioctl32.c	Tue Feb 18 18:25:13 2003
@@ -2892,7 +2892,7 @@
 
 IOCTL_TABLE_START
 /* List here exlicitly which ioctl's are known to have
- * compatable types passed or none at all...
+ * compatible types passed or none at all...
  */
 /* Big T */
 COMPATIBLE_IOCTL(TCGETA)
diff -ur linux-2.5.62-1104-orig/arch/ppc/xmon/ansidecl.h linux-2.5.62-1104/arch/ppc/xmon/ansidecl.h
--- linux-2.5.62-1104-orig/arch/ppc/xmon/ansidecl.h	Thu Jan 16 19:22:58 2003
+++ linux-2.5.62-1104/arch/ppc/xmon/ansidecl.h	Tue Feb 18 18:25:13 2003
@@ -1,4 +1,4 @@
-/* ANSI and traditional C compatability macros
+/* ANSI and traditional C compatibility macros
    Copyright 1991, 1992 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
diff -ur linux-2.5.62-1104-orig/arch/ppc64/kernel/sys32.S linux-2.5.62-1104/arch/ppc64/kernel/sys32.S
--- linux-2.5.62-1104-orig/arch/ppc64/kernel/sys32.S	Mon Feb 17 17:36:00 2003
+++ linux-2.5.62-1104/arch/ppc64/kernel/sys32.S	Tue Feb 18 18:25:13 2003
@@ -1,5 +1,5 @@
 /* 
- * sys32.S: I-cache tricks for 32-bit compatability layer simple
+ * sys32.S: I-cache tricks for 32-bit compatibility layer simple
  *          conversions.
  *
  * Copyright (C) 1997 David S. Miller (davem@caip.rutgers.edu)
diff -ur linux-2.5.62-1104-orig/arch/ppc64/kernel/sys_ppc32.c linux-2.5.62-1104/arch/ppc64/kernel/sys_ppc32.c
--- linux-2.5.62-1104-orig/arch/ppc64/kernel/sys_ppc32.c	Mon Feb 17 17:36:00 2003
+++ linux-2.5.62-1104/arch/ppc64/kernel/sys_ppc32.c	Tue Feb 18 18:25:13 2003
@@ -812,7 +812,7 @@
 	return sys_sysfs((int)option, arg1, arg2);
 }
 
-/* Handle adjtimex compatability. */
+/* Handle adjtimex compatibility. */
 struct timex32 {
 	u32 modes;
 	s32 offset, freq, maxerror, esterror;
diff -ur linux-2.5.62-1104-orig/arch/ppc64/xmon/ansidecl.h linux-2.5.62-1104/arch/ppc64/xmon/ansidecl.h
--- linux-2.5.62-1104-orig/arch/ppc64/xmon/ansidecl.h	Thu Jan 16 19:22:02 2003
+++ linux-2.5.62-1104/arch/ppc64/xmon/ansidecl.h	Tue Feb 18 18:25:13 2003
@@ -1,4 +1,4 @@
-/* ANSI and traditional C compatability macros
+/* ANSI and traditional C compatibility macros
    Copyright 1991, 1992 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
diff -ur linux-2.5.62-1104-orig/arch/s390x/kernel/linux32.c linux-2.5.62-1104/arch/s390x/kernel/linux32.c
--- linux-2.5.62-1104-orig/arch/s390x/kernel/linux32.c	Mon Feb 17 17:36:00 2003
+++ linux-2.5.62-1104/arch/s390x/kernel/linux32.c	Tue Feb 18 18:25:13 2003
@@ -3578,7 +3578,7 @@
 	return ret;
 }
 
-/* Handle adjtimex compatability. */
+/* Handle adjtimex compatibility. */
 
 struct timex32 {
 	u32 modes;
diff -ur linux-2.5.62-1104-orig/arch/sparc64/kernel/ioctl32.c linux-2.5.62-1104/arch/sparc64/kernel/ioctl32.c
--- linux-2.5.62-1104-orig/arch/sparc64/kernel/ioctl32.c	Fri Feb 14 20:11:48 2003
+++ linux-2.5.62-1104/arch/sparc64/kernel/ioctl32.c	Tue Feb 18 18:25:13 2003
@@ -4277,7 +4277,7 @@
 
 IOCTL_TABLE_START
 /* List here exlicitly which ioctl's are known to have
- * compatable types passed or none at all...
+ * compatible types passed or none at all...
  */
 /* Big T */
 COMPATIBLE_IOCTL(TCGETA)
diff -ur linux-2.5.62-1104-orig/arch/sparc64/kernel/sunos_ioctl32.c linux-2.5.62-1104/arch/sparc64/kernel/sunos_ioctl32.c
--- linux-2.5.62-1104-orig/arch/sparc64/kernel/sunos_ioctl32.c	Thu Jan 16 19:22:44 2003
+++ linux-2.5.62-1104/arch/sparc64/kernel/sunos_ioctl32.c	Tue Feb 18 18:25:13 2003
@@ -1,5 +1,5 @@
 /* $Id: sunos_ioctl32.c,v 1.11 2000/07/30 23:12:24 davem Exp $
- * sunos_ioctl32.c: SunOS ioctl compatability on sparc64.
+ * sunos_ioctl32.c: SunOS ioctl compatibility on sparc64.
  *
  * Copyright (C) 1995 Miguel de Icaza (miguel@nuclecu.unam.mx)
  * Copyright (C) 1995, 1996, 1997 David S. Miller (davem@caip.rutgers.edu)
diff -ur linux-2.5.62-1104-orig/arch/sparc64/kernel/sys32.S linux-2.5.62-1104/arch/sparc64/kernel/sys32.S
--- linux-2.5.62-1104-orig/arch/sparc64/kernel/sys32.S	Thu Jan 16 19:21:41 2003
+++ linux-2.5.62-1104/arch/sparc64/kernel/sys32.S	Tue Feb 18 18:25:13 2003
@@ -1,5 +1,5 @@
 /* $Id: sys32.S,v 1.12 2000/03/24 04:17:37 davem Exp $
- * sys32.S: I-cache tricks for 32-bit compatability layer simple
+ * sys32.S: I-cache tricks for 32-bit compatibility layer simple
  *          conversions.
  *
  * Copyright (C) 1997 David S. Miller (davem@caip.rutgers.edu)
diff -ur linux-2.5.62-1104-orig/arch/sparc64/kernel/sys_sparc32.c linux-2.5.62-1104/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.5.62-1104-orig/arch/sparc64/kernel/sys_sparc32.c	Mon Feb 17 17:36:00 2003
+++ linux-2.5.62-1104/arch/sparc64/kernel/sys_sparc32.c	Tue Feb 18 18:25:13 2003
@@ -3528,7 +3528,7 @@
 	return ret;
 }
 
-/* Handle adjtimex compatability. */
+/* Handle adjtimex compatibility. */
 
 struct timex32 {
 	u32 modes;
diff -ur linux-2.5.62-1104-orig/arch/sparc64/kernel/sys_sunos32.c linux-2.5.62-1104/arch/sparc64/kernel/sys_sunos32.c
--- linux-2.5.62-1104-orig/arch/sparc64/kernel/sys_sunos32.c	Mon Feb 10 12:22:57 2003
+++ linux-2.5.62-1104/arch/sparc64/kernel/sys_sunos32.c	Tue Feb 18 18:25:13 2003
@@ -1,5 +1,5 @@
 /* $Id: sys_sunos32.c,v 1.64 2002/02/09 19:49:31 davem Exp $
- * sys_sunos32.c: SunOS binary compatability layer on sparc64.
+ * sys_sunos32.c: SunOS binary compatibility layer on sparc64.
  *
  * Copyright (C) 1995, 1996, 1997 David S. Miller (davem@caip.rutgers.edu)
  * Copyright (C) 1995 Miguel de Icaza (miguel@nuclecu.unam.mx)
diff -ur linux-2.5.62-1104-orig/arch/x86_64/ia32/ia32_ioctl.c linux-2.5.62-1104/arch/x86_64/ia32/ia32_ioctl.c
--- linux-2.5.62-1104-orig/arch/x86_64/ia32/ia32_ioctl.c	Thu Jan 16 19:22:13 2003
+++ linux-2.5.62-1104/arch/x86_64/ia32/ia32_ioctl.c	Tue Feb 18 18:25:13 2003
@@ -3593,7 +3593,7 @@
 
 IOCTL_TABLE_START
 /* List here explicitly which ioctl's are known to have
- * compatable types passed or none at all...
+ * compatible types passed or none at all...
  */
 /* Big T */
 COMPATIBLE_IOCTL(TCGETA)
diff -ur linux-2.5.62-1104-orig/arch/x86_64/ia32/sys_ia32.c linux-2.5.62-1104/arch/x86_64/ia32/sys_ia32.c
--- linux-2.5.62-1104-orig/arch/x86_64/ia32/sys_ia32.c	Mon Feb 17 17:36:00 2003
+++ linux-2.5.62-1104/arch/x86_64/ia32/sys_ia32.c	Tue Feb 18 18:25:13 2003
@@ -1573,7 +1573,7 @@
 	return ret;
 }
 
-/* Handle adjtimex compatability. */
+/* Handle adjtimex compatibility. */
 
 struct timex32 {
 	u32 modes;
diff -ur linux-2.5.62-1104-orig/drivers/char/agp/via-agp.c linux-2.5.62-1104/drivers/char/agp/via-agp.c
--- linux-2.5.62-1104-orig/drivers/char/agp/via-agp.c	Fri Feb 14 20:11:52 2003
+++ linux-2.5.62-1104/drivers/char/agp/via-agp.c	Tue Feb 18 18:25:13 2003
@@ -227,7 +227,7 @@
 
 			printk (KERN_INFO PFX "Found KT400 in disguise as a KT266.\n");
 
-			/* Check AGP compatability mode. */
+			/* Check AGP compatibility mode. */
 			pci_read_config_byte(pdev, VIA_AGPSEL, &reg);
 			if ((reg & (1<<1))==0)
 				return via_generic_agp3_setup(pdev);
@@ -271,7 +271,7 @@
 {
 	u8 reg;
 	pci_read_config_byte(pdev, VIA_AGPSEL, &reg);
-	/* Check AGP 2.0 compatability mode. */
+	/* Check AGP 2.0 compatibility mode. */
 	if ((reg & (1<<1))==0)
 		return via_generic_agp3_setup(pdev);
 	return via_generic_setup(pdev);
diff -ur linux-2.5.62-1104-orig/drivers/char/ftape/zftape/zftape-ctl.c linux-2.5.62-1104/drivers/char/ftape/zftape/zftape-ctl.c
--- linux-2.5.62-1104-orig/drivers/char/ftape/zftape/zftape-ctl.c	Thu Jan 16 19:22:01 2003
+++ linux-2.5.62-1104/drivers/char/ftape/zftape/zftape-ctl.c	Tue Feb 18 18:25:13 2003
@@ -717,7 +717,7 @@
 			    ftape_disable());
 	}
 	/* zft_seg_pos should be greater than the vtbl segpos but not
-	 * if in compatability mode and only after we read in the
+	 * if in compatibility mode and only after we read in the
 	 * header segments
 	 *
 	 * might also be a problem if the user makes a backup with a
diff -ur linux-2.5.62-1104-orig/drivers/char/ftape/zftape/zftape-eof.c linux-2.5.62-1104/drivers/char/ftape/zftape/zftape-eof.c
--- linux-2.5.62-1104-orig/drivers/char/ftape/zftape/zftape-eof.c	Thu Jan 16 19:23:01 2003
+++ linux-2.5.62-1104/drivers/char/ftape/zftape/zftape-eof.c	Tue Feb 18 18:25:13 2003
@@ -1,6 +1,6 @@
 /*
  *   I use these routines just to decide when I have to fake a 
- *   volume-table to preserve compatability to original ftape.
+ *   volume-table to preserve compatibility to original ftape.
  */
 /*
  *      Copyright (C) 1994-1995 Bas Laarhoven.
diff -ur linux-2.5.62-1104-orig/drivers/char/ftape/zftape/zftape-vtbl.c linux-2.5.62-1104/drivers/char/ftape/zftape/zftape-vtbl.c
--- linux-2.5.62-1104-orig/drivers/char/ftape/zftape/zftape-vtbl.c	Thu Jan 16 19:22:04 2003
+++ linux-2.5.62-1104/drivers/char/ftape/zftape/zftape-vtbl.c	Tue Feb 18 18:25:13 2003
@@ -143,7 +143,7 @@
  * using the keyword "blocksize". The blocksize written to the
  * volume-label is in bytes.
  *
- * We use this now only for compatability with old zftape version. We
+ * We use this now only for compatibility with old zftape version. We
  * store the blocksize directly as binary number in the vendor
  * extension part of the volume entry.
  */
diff -ur linux-2.5.62-1104-orig/drivers/char/ftape/zftape/zftape-vtbl.h linux-2.5.62-1104/drivers/char/ftape/zftape/zftape-vtbl.h
--- linux-2.5.62-1104-orig/drivers/char/ftape/zftape/zftape-vtbl.h	Thu Jan 16 19:22:02 2003
+++ linux-2.5.62-1104/drivers/char/ftape/zftape/zftape-vtbl.h	Tue Feb 18 18:25:13 2003
@@ -72,7 +72,7 @@
 #define VTBL_FMT        125
 #define VTBL_RESERVED_2 126
 #define VTBL_RESERVED_3 127
-/* compatability with pre revision K */
+/* compatibility with pre revision K */
 #define VTBL_K_CMPR     120 
 
 /*  the next is used by QIC-3020 tapes with format code 6 (>2^16
diff -ur linux-2.5.62-1104-orig/drivers/char/ppdev.c linux-2.5.62-1104/drivers/char/ppdev.c
--- linux-2.5.62-1104-orig/drivers/char/ppdev.c	Thu Jan 16 19:22:50 2003
+++ linux-2.5.62-1104/drivers/char/ppdev.c	Tue Feb 18 18:25:13 2003
@@ -676,7 +676,7 @@
 	    (pp->state.mode != IEEE1284_MODE_COMPAT)) {
 	    	struct ieee1284_info *info;
 
-		/* parport released, but not in compatability mode */
+		/* parport released, but not in compatibility mode */
 		parport_claim_or_block (pp->pdev);
 		pp->flags |= PP_CLAIMED;
 		info = &pp->pdev->port->ieee1284;
diff -ur linux-2.5.62-1104-orig/drivers/ide/pci/serverworks.c linux-2.5.62-1104/drivers/ide/pci/serverworks.c
--- linux-2.5.62-1104-orig/drivers/ide/pci/serverworks.c	Tue Feb 18 18:06:18 2003
+++ linux-2.5.62-1104/drivers/ide/pci/serverworks.c	Tue Feb 18 18:25:13 2003
@@ -578,7 +578,7 @@
 			 * This is a device pin issue on CSB6.
 			 * Since there will be a future raid mode,
 			 * early versions of the chipset require the
-			 * interrupt pin to be set, and it is a compatablity
+			 * interrupt pin to be set, and it is a compatiblity
 			 * mode issue.
 			 */
 			dev->irq = 0;
diff -ur linux-2.5.62-1104-orig/drivers/md/md.c linux-2.5.62-1104/drivers/md/md.c
--- linux-2.5.62-1104-orig/drivers/md/md.c	Tue Feb 18 18:06:18 2003
+++ linux-2.5.62-1104/drivers/md/md.c	Tue Feb 18 18:25:13 2003
@@ -729,7 +729,7 @@
 		if (rdev2->raid_disk >= 0)
 			d->raid_disk = rdev2->raid_disk;
 		else
-			d->raid_disk = rdev2->desc_nr; /* compatability */
+			d->raid_disk = rdev2->desc_nr; /* compatibility */
 		if (rdev2->faulty) {
 			d->state = (1<<MD_DISK_FAULTY);
 			failed++;
diff -ur linux-2.5.62-1104-orig/drivers/net/am79c961a.c linux-2.5.62-1104/drivers/net/am79c961a.c
--- linux-2.5.62-1104-orig/drivers/net/am79c961a.c	Thu Jan 16 19:22:28 2003
+++ linux-2.5.62-1104/drivers/net/am79c961a.c	Tue Feb 18 18:25:13 2003
@@ -150,7 +150,7 @@
 	}
 }
 #else
-#error Not compatable
+#error Not compatible
 #endif
 
 static int
diff -ur linux-2.5.62-1104-orig/drivers/scsi/3w-xxxx.c linux-2.5.62-1104/drivers/scsi/3w-xxxx.c
--- linux-2.5.62-1104-orig/drivers/scsi/3w-xxxx.c	Tue Feb 18 18:06:18 2003
+++ linux-2.5.62-1104/drivers/scsi/3w-xxxx.c	Tue Feb 18 18:25:13 2003
@@ -8,7 +8,7 @@
 
    Copyright (C) 1999-2002 3ware Inc.
 
-   Kernel compatablity By: 	Andre Hedrick <andre@suse.com>
+   Kernel compatiblity By: 	Andre Hedrick <andre@suse.com>
    Non-Copyright (C) 2000	Andre Hedrick <andre@suse.com>
    
    Further tiny build fixes and trivial hoovering    Alan Cox
diff -ur linux-2.5.62-1104-orig/drivers/scsi/3w-xxxx.h linux-2.5.62-1104/drivers/scsi/3w-xxxx.h
--- linux-2.5.62-1104-orig/drivers/scsi/3w-xxxx.h	Thu Jan 16 19:21:46 2003
+++ linux-2.5.62-1104/drivers/scsi/3w-xxxx.h	Tue Feb 18 18:25:13 2003
@@ -8,7 +8,7 @@
 
    Copyright (C) 1999-2002 3ware Inc.
 
-   Kernel compatablity By:	Andre Hedrick <andre@suse.com>
+   Kernel compatiblity By:	Andre Hedrick <andre@suse.com>
    Non-Copyright (C) 2000	Andre Hedrick <andre@suse.com>
 
    This program is free software; you can redistribute it and/or modify
diff -ur linux-2.5.62-1104-orig/drivers/scsi/pci2220i.c linux-2.5.62-1104/drivers/scsi/pci2220i.c
--- linux-2.5.62-1104-orig/drivers/scsi/pci2220i.c	Tue Feb 18 18:06:18 2003
+++ linux-2.5.62-1104/drivers/scsi/pci2220i.c	Tue Feb 18 18:25:13 2003
@@ -1439,14 +1439,14 @@
 				break;
 				}
 
-	        // test LBA and multiper sector transfer compatability
+	        // test LBA and multiper sector transfer compatibility
 			if (!pid->SupportLBA || (pid->NumSectorsPerInt < SECTORSXFER) || !pid->Valid_64_70 )
 				{
 				DEB (printk ("\npci2220i: sub 3"));
 				break;
 				}
 
-	        // test PIO/bus matering mode compatability
+	        // test PIO/bus matering mode compatibility
 			if ( (pid->MinPIOCycleWithoutFlow > 240) && !pid->SupportIORDYDisable && !padapter->timingPIO )
 				{
 				DEB (printk ("\npci2220i: sub 4"));
diff -ur linux-2.5.62-1104-orig/drivers/serial/amba.c linux-2.5.62-1104/drivers/serial/amba.c
--- linux-2.5.62-1104-orig/drivers/serial/amba.c	Thu Jan 16 19:21:39 2003
+++ linux-2.5.62-1104/drivers/serial/amba.c	Tue Feb 18 18:25:13 2003
@@ -25,7 +25,7 @@
  *  $Id: amba.c,v 1.41 2002/07/28 10:03:27 rmk Exp $
  *
  * This is a generic driver for ARM AMBA-type serial ports.  They
- * have a lot of 16550-like features, but are not register compatable.
+ * have a lot of 16550-like features, but are not register compatible.
  * Note that although they do have CTS, DCD and DSR inputs, they do
  * not have an RI input, nor do they have DTR or RTS outputs.  If
  * required, these have to be supplied via some other means (eg, GPIO)
diff -ur linux-2.5.62-1104-orig/fs/befs/ChangeLog linux-2.5.62-1104/fs/befs/ChangeLog
--- linux-2.5.62-1104-orig/fs/befs/ChangeLog	Mon Feb 17 17:36:01 2003
+++ linux-2.5.62-1104/fs/befs/ChangeLog	Tue Feb 18 18:25:13 2003
@@ -32,7 +32,7 @@
 * Andrew Farnham <andrewfarnham@uq.net.au> pointed out that the module
 	wouldn't work on older (<2.4.10) kernels due to an unresolved symbol.
 	This is bad, since 2.4.9 is still the current RedHat kernel. I added
-	a workaround for this problem (compatability.h) [WD]
+	a workaround for this problem (compatibility.h) [WD]
 
 * Sergey S. Kostyliov made befs_find_key() use a binary search to find 
 	keys within btree nodes, rather than the linear search we were using 
diff -ur linux-2.5.62-1104-orig/fs/cifs/CHANGES linux-2.5.62-1104/fs/cifs/CHANGES
--- linux-2.5.62-1104-orig/fs/cifs/CHANGES	Mon Feb 17 17:36:01 2003
+++ linux-2.5.62-1104/fs/cifs/CHANGES	Tue Feb 18 18:25:13 2003
@@ -128,7 +128,7 @@
 Version 0.42
 ------------
 SessionSetup and NegotiateProtocol now work from Big Endian machines.
-Various Big Endian fixes found during testing on the Linux on 390.  Various fixes for compatability with older
+Various Big Endian fixes found during testing on the Linux on 390.  Various fixes for compatibility with older
 versions of 2.4 kernel (now builds and works again on kernels at least as early as 2.4.7).
 
 Version 0.41
diff -ur linux-2.5.62-1104-orig/include/asm-arm/hardware/iomd.h linux-2.5.62-1104/include/asm-arm/hardware/iomd.h
--- linux-2.5.62-1104-orig/include/asm-arm/hardware/iomd.h	Thu Jan 16 19:22:57 2003
+++ linux-2.5.62-1104/include/asm-arm/hardware/iomd.h	Tue Feb 18 18:25:13 2003
@@ -203,7 +203,7 @@
 #define DMA_ST_AB	1
 
 /*
- * DMA (MEMC) compatability
+ * DMA (MEMC) compatibility
  */
 #define HALF_SAM	vram_half_sam
 #define VDMA_ALIGNMENT	(HALF_SAM * 2)
diff -ur linux-2.5.62-1104-orig/include/asm-ia64/sn/eeprom.h linux-2.5.62-1104/include/asm-ia64/sn/eeprom.h
--- linux-2.5.62-1104-orig/include/asm-ia64/sn/eeprom.h	Thu Jan 16 19:22:13 2003
+++ linux-2.5.62-1104/include/asm-ia64/sn/eeprom.h	Tue Feb 18 18:25:13 2003
@@ -371,7 +371,7 @@
 


-/* macros for NIC compatability */
+/* macros for NIC compatibility */
 /* always invoked on "this" cbrick */
 #define HUB_VERTEX_MFG_INFO(v) \
     eeprom_vertex_info_set( C_BRICK, get_nasid(), (v), 0 )
diff -ur linux-2.5.62-1104-orig/include/asm-ppc64/iSeries/ItLpNaca.h linux-2.5.62-1104/include/asm-ppc64/iSeries/ItLpNaca.h
--- linux-2.5.62-1104-orig/include/asm-ppc64/iSeries/ItLpNaca.h	Thu Jan 16 19:21:38 2003
+++ linux-2.5.62-1104/include/asm-ppc64/iSeries/ItLpNaca.h	Tue Feb 18 18:25:13 2003
@@ -57,7 +57,7 @@
 	u16	xRsvd1_3;		// Reserved			x20-x21
 	u16	xPlicVrmIndex;		// VRM index of PLIC		x22-x23
 	u16	xMinSupportedSlicVrmInd;// Min supported OS VRM index	x24-x25
-	u16	xMinCompatableSlicVrmInd;// Min compatable OS VRM index x26-x27
+	u16	xMinCompatableSlicVrmInd;// Min compatible OS VRM index x26-x27
 	u64	xLoadAreaAddr;		// ER address of load area	x28-x2F
 	u32	xLoadAreaChunks;	// Chunks for the load area	x30-x33
 	u32	xPaseSysCallCRMask;	// Mask used to test CR before  x34-x37
diff -ur linux-2.5.62-1104-orig/include/asm-sparc64/psrcompat.h linux-2.5.62-1104/include/asm-sparc64/psrcompat.h
--- linux-2.5.62-1104-orig/include/asm-sparc64/psrcompat.h	Thu Jan 16 19:21:38 2003
+++ linux-2.5.62-1104/include/asm-sparc64/psrcompat.h	Tue Feb 18 18:25:13 2003
@@ -4,7 +4,7 @@
 
 #include <asm/pstate.h>
 
-/* Old 32-bit PSR fields for the compatability conversion code. */
+/* Old 32-bit PSR fields for the compatibility conversion code. */
 #define PSR_CWP     0x0000001f         /* current window pointer     */
 #define PSR_ET      0x00000020         /* enable traps field         */
 #define PSR_PS      0x00000040         /* previous privilege level   */
diff -ur linux-2.5.62-1104-orig/include/linux/cdrom.h linux-2.5.62-1104/include/linux/cdrom.h
--- linux-2.5.62-1104-orig/include/linux/cdrom.h	Thu Jan 16 19:21:34 2003
+++ linux-2.5.62-1104/include/linux/cdrom.h	Tue Feb 18 18:25:13 2003
@@ -77,7 +77,7 @@
 #define CDROM_GET_MCN		0x5311 /* Obtain the "Universal Product Code" 
                                            if available (struct cdrom_mcn) */
 #define CDROM_GET_UPC		CDROM_GET_MCN  /* This one is depricated, 
-                                          but here anyway for compatability */
+                                          but here anyway for compatibility */
 #define CDROMRESET		0x5312 /* hard-reset the drive */
 #define CDROMVOLREAD		0x5313 /* Get the drive's volume setting 
                                           (struct cdrom_volctrl) */
diff -ur linux-2.5.62-1104-orig/include/linux/init.h linux-2.5.62-1104/include/linux/init.h
--- linux-2.5.62-1104-orig/include/linux/init.h	Thu Jan 16 19:21:37 2003
+++ linux-2.5.62-1104/include/linux/init.h	Tue Feb 18 18:25:13 2003
@@ -71,7 +71,7 @@
 /* initcalls are now grouped by functionality into separate 
  * subsections. Ordering inside the subsections is determined
  * by link order. 
- * For backwards compatability, initcall() puts the call in 
+ * For backwards compatibility, initcall() puts the call in 
  * the device init subsection.
  */
 
diff -ur linux-2.5.62-1104-orig/sound/oss/mad16.c linux-2.5.62-1104/sound/oss/mad16.c
--- linux-2.5.62-1104-orig/sound/oss/mad16.c	Thu Jan 16 19:22:27 2003
+++ linux-2.5.62-1104/sound/oss/mad16.c	Tue Feb 18 18:25:13 2003
@@ -17,7 +17,7 @@
  * to the PC bus and perform I/O, DMA and IRQ address decoding. There is
  * also a UART for the MPU-401 mode (not 82C928/Mozart).
  * The Mozart chip appears to be compatible with the 82C928, although later
- * issues of the card, using the OTI-605 chip, have an MPU-401 compatable Midi
+ * issues of the card, using the OTI-605 chip, have an MPU-401 compatible Midi
  * port. This port is configured differently to that of the OPTi audio chips.
  *
  *	Changes


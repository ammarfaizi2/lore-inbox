Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWGZXVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWGZXVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 19:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWGZXVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 19:21:19 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:11530 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751237AbWGZXVS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 19:21:18 -0400
Date: Wed, 26 Jul 2006 19:20:29 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH 18-rc2] Fix "can not" in Documentation and Kconfig
Message-Id: <20060726192029.173c89b6.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Spam-Processed: mail.cyberdogtech.com, Wed, 26 Jul 2006 19:20:33 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Wed, 26 Jul 2006 19:20:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy brought it to my attention that in proper english "can not" should always be written "cannot". I donot see any reason to argue, even if I mightnot understand why this rule exists.  This patch fixes "can not" in several Documentation files as well as three Kconfigs.

Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>
--

diff -ru a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig	2006-07-16 22:07:04.000000000 -0400
+++ b/arch/arm/Kconfig	2006-07-26 19:14:22.000000000 -0400
@@ -604,7 +604,7 @@
 	bool
 	default y if !ARCH_EBSA110
 	help
-	  ARM processors can not fetch/store information which is not
+	  ARM processors cannot fetch/store information which is not
 	  naturally aligned on the bus, i.e., a 4 byte fetch must start at an
 	  address divisible by 4. On 32-bit ARM processors, these non-aligned
 	  fetch/store instructions will be emulated in software if you say
diff -ru a/Documentation/DMA-mapping.txt b/Documentation/DMA-mapping.txt
--- a/Documentation/DMA-mapping.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/DMA-mapping.txt	2006-07-26 18:54:52.000000000 -0400
@@ -117,7 +117,7 @@
 device supports.  It returns zero if your card can perform DMA
 properly on the machine given the address mask you provided.
 
-If it returns non-zero, your device can not perform DMA properly on
+If it returns non-zero, your device cannot perform DMA properly on
 this platform, and attempting to do so will result in undefined
 behavior.  You must either use a different mask, or not use DMA.
 
diff -ru a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/filesystems/proc.txt	2006-07-26 19:09:52.000000000 -0400
@@ -1727,7 +1727,7 @@
 
 These  parameters  are used to limit how many ICMP destination unreachable to 
 send  from  the  host  in question. ICMP destination unreachable messages are 
-sent  when  we can not reach the next hop, while trying to transmit a packet. 
+sent  when  we  cannot reach  the next hop while trying to transmit a packet. 
 It  will also print some error messages to kernel logs if someone is ignoring 
 our   ICMP  redirects.  The  higher  the  error_cost  factor  is,  the  fewer 
 destination  unreachable  and error messages will be let through. Error_burst 
diff -ru a/Documentation/highuid.txt b/Documentation/highuid.txt
--- a/Documentation/highuid.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/highuid.txt	2006-07-26 18:52:30.000000000 -0400
@@ -57,7 +57,7 @@
 
   Other filesystems have not been checked yet.
 
-- The ncpfs and smpfs filesystems can not presently use 32-bit UIDs in
+- The ncpfs and smpfs filesystems cannot presently use 32-bit UIDs in
   all ioctl()s. Some new ioctl()s have been added with 32-bit UIDs, but
   more are needed. (as well as new user<->kernel data structures)
 
diff -ru a/Documentation/input/ff.txt b/Documentation/input/ff.txt
--- a/Documentation/input/ff.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/input/ff.txt	2006-07-26 18:58:30.000000000 -0400
@@ -12,7 +12,7 @@
 effects.
 At the moment, only I-Force devices are supported, and not officially. That
 means I had to find out how the protocol works on my own. Of course, the
-information I managed to grasp is far from being complete, and I can not
+information I managed to grasp is far from being complete, and I cannot
 guarranty that this driver will work for you.
 This document only describes the force feedback part of the driver for I-Force
 devices. Please read joystick.txt before reading further this document.
diff -ru a/Documentation/ioctl/hdio.txt b/Documentation/ioctl/hdio.txt
--- a/Documentation/ioctl/hdio.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/ioctl/hdio.txt	2006-07-26 19:04:18.000000000 -0400
@@ -203,7 +203,7 @@
 
 	  Source code comments read:
 
-	    This is tightly woven into the driver->do_special can not
+	    This is tightly woven into the driver->do_special cannot
 	    touch.  DON'T do it again until a total personality rewrite
 	    is committed.
 
diff -ru a/Documentation/java.txt b/Documentation/java.txt
--- a/Documentation/java.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/java.txt	2006-07-26 18:50:44.000000000 -0400
@@ -22,7 +22,7 @@
    the kernel (CONFIG_BINFMT_MISC) and set it up properly.
    If you choose to compile it as a module, you will have
    to insert it manually with modprobe/insmod, as kmod
-   can not easily be supported with binfmt_misc. 
+   cannot easily be supported with binfmt_misc. 
    Read the file 'binfmt_misc.txt' in this directory to know
    more about the configuration process.
 
diff -ru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/kernel-parameters.txt	2006-07-26 19:02:24.000000000 -0400
@@ -608,8 +608,8 @@
 	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
 
 	i8042.direct	[HW] Put keyboard port into non-translated mode
-	i8042.dumbkbd	[HW] Pretend that controlled can only read data from
-			     keyboard and can not control its state
+	i8042.dumbkbd	[HW] Pretend that controller can only read data from
+			     keyboard and cannot control its state
 			     (Don't attempt to blink the leds)
 	i8042.noaux	[HW] Don't check for auxiliary (== mouse) port
 	i8042.nokbd	[HW] Don't check/create keyboard port
diff -ru a/Documentation/mono.txt b/Documentation/mono.txt
--- a/Documentation/mono.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/mono.txt	2006-07-26 18:55:09.000000000 -0400
@@ -26,7 +26,7 @@
    the kernel (CONFIG_BINFMT_MISC) and set it up properly.
    If you choose to compile it as a module, you will have
    to insert it manually with modprobe/insmod, as kmod
-   can not be easily supported with binfmt_misc. 
+   cannot be easily supported with binfmt_misc. 
    Read the file 'binfmt_misc.txt' in this directory to know
    more about the configuration process.
 
diff -ru a/Documentation/networking/arcnet-hardware.txt b/Documentation/networking/arcnet-hardware.txt
--- a/Documentation/networking/arcnet-hardware.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/arcnet-hardware.txt	2006-07-26 18:54:28.000000000 -0400
@@ -139,7 +139,7 @@
 
 5. An active hub to passive hub.
 
-Remember, that you can not connect two passive hubs together.  The power loss
+Remember that you cannot connect two passive hubs together.  The power loss
 implied by such a connection is too high for the net to operate reliably.
 
 An example of a typical ARCnet network:
diff -ru a/Documentation/networking/cs89x0.txt b/Documentation/networking/cs89x0.txt
--- a/Documentation/networking/cs89x0.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/cs89x0.txt	2006-07-26 18:56:05.000000000 -0400
@@ -584,7 +584,7 @@
 
     1.) The system does not boot properly (or at all).
 
-    2.) The driver can not communicate with the adapter, reporting an "Adapter
+    2.) The driver cannot communicate with the adapter, reporting an "Adapter
         not found" error message.
 
     3.) You cannot connect to the network or the driver will not load.
diff -ru a/Documentation/networking/netconsole.txt b/Documentation/networking/netconsole.txt
--- a/Documentation/networking/netconsole.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/netconsole.txt	2006-07-26 19:10:36.000000000 -0400
@@ -52,6 +52,6 @@
 Netconsole was designed to be as instantaneous as possible, to
 enable the logging of even the most critical kernel bugs. It works
 from IRQ contexts as well, and does not enable interrupts while
-sending packets. Due to these unique needs, configuration can not
+sending packets. Due to these unique needs, configuration cannot
 be more automatic, and some fundamental limitations will remain:
 only IP networks, UDP packets and ethernet devices are supported.
diff -ru a/Documentation/networking/sk98lin.txt b/Documentation/networking/sk98lin.txt
--- a/Documentation/networking/sk98lin.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/sk98lin.txt	2006-07-26 19:01:16.000000000 -0400
@@ -484,7 +484,7 @@
 following list:
 
 
-Problem:  The SK-98xx adapter can not be found by the driver.
+Problem:  The SK-98xx adapter cannot be found by the driver.
 Solution: In /proc/pci search for the following entry:
              'Ethernet controller: SysKonnect SK-98xx ...'
           If this entry exists, the SK-98xx or SK-98xx V2.0 adapter has 
@@ -502,7 +502,7 @@
           web, e.g. at 'www.linux.org'). 
 
 
-Problem:  Programs such as 'ifconfig' or 'route' can not be found or the 
+Problem:  Programs such as 'ifconfig' or 'route' cannot be found or the 
           error message 'Operation not permitted' is displayed.
 Reason:   You are not logged in as user 'root'.
 Solution: Logout and login as 'root' or change to 'root' via 'su'.
diff -ru a/Documentation/networking/skfp.txt b/Documentation/networking/skfp.txt
--- a/Documentation/networking/skfp.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/skfp.txt	2006-07-26 18:57:51.000000000 -0400
@@ -81,7 +81,7 @@
 
 If you run into problems during installation, check those items:
 
-Problem:  The FDDI adapter can not be found by the driver.
+Problem:  The FDDI adapter cannot be found by the driver.
 Reason:   Look in /proc/pci for the following entry:
              'FDDI network controller: SysKonnect SK-FDDI-PCI ...'
 	  If this entry exists, then the FDDI adapter has been
@@ -99,7 +99,7 @@
 
 Problem:  You want to use your computer as a router between
           multiple IP subnetworks (using multiple adapters), but
-	  you can not reach computers in other subnetworks.
+	  you cannot reach computers in other subnetworks.
 Reason:   Either the router's kernel is not configured for IP
 	  forwarding or there is a problem with the routing table
 	  and gateway configuration in at least one of the
diff -ru a/Documentation/networking/tcp.txt b/Documentation/networking/tcp.txt
--- a/Documentation/networking/tcp.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/tcp.txt	2006-07-26 18:57:05.000000000 -0400
@@ -62,7 +62,7 @@
 unknown congestion method, then the sysctl attempt will fail.
 
 If you remove a tcp congestion control module, then you will get the next
-available one. Since reno can not be built as a module, and can not be
+available one. Since reno cannot be built as a module, and cannot be
 deleted, it will always be available.
 
 How the new TCP output machine [nyi] works.
diff -ru a/Documentation/pm.txt b/Documentation/pm.txt
--- a/Documentation/pm.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/pm.txt	2006-07-26 19:00:17.000000000 -0400
@@ -18,10 +18,10 @@
 ACPI driver will override and disable APM, otherwise the APM driver
 will be used.
 
-No sorry, you can not have both ACPI and APM enabled and running at
+No, sorry, you cannot have both ACPI and APM enabled and running at
 once.  Some people with broken ACPI or broken APM implementations
 would like to use both to get a full set of working features, but you
-simply can not mix and match the two.  Only one power management
+simply cannot mix and match the two.  Only one power management
 interface can be in control of the machine at once.  Think about it..
 
 User-space Daemons
@@ -106,7 +106,7 @@
  *
  * Returns: 0 if the request is successful
  *          EINVAL if the request is not supported
- *          EBUSY if the device is now busy and can not handle the request
+ *          EBUSY if the device is now busy and cannot handle the request
  *          ENOMEM if the device was unable to handle the request due to memory
  *          
  * Details: The device request callback will be called before the
diff -ru a/Documentation/pnp.txt b/Documentation/pnp.txt
--- a/Documentation/pnp.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/pnp.txt	2006-07-26 18:52:06.000000000 -0400
@@ -222,7 +222,7 @@
 	.remove		= serial_pnp_remove,
 };
 
-* name and id_table can not be NULL.
+* name and id_table cannot be NULL.
 
 4.) register the driver
 ex:
diff -ru a/Documentation/power/devices.txt b/Documentation/power/devices.txt
--- a/Documentation/power/devices.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/power/devices.txt	2006-07-26 18:55:35.000000000 -0400
@@ -148,7 +148,7 @@
 
 Transitions are only from a resumed state to a suspended state, never
 between 2 suspended states. (ON -> FREEZE or ON -> SUSPEND can happen,
-FREEZE -> SUSPEND or SUSPEND -> FREEZE can not).
+FREEZE -> SUSPEND or SUSPEND -> FREEZE cannot).
 
 All events are:
 
diff -ru a/Documentation/s390/cds.txt b/Documentation/s390/cds.txt
--- a/Documentation/s390/cds.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/s390/cds.txt	2006-07-26 19:12:16.000000000 -0400
@@ -143,7 +143,7 @@
 of those devices is uniquely defined by a so called subchannel by the ESA/390
 channel subsystem. While the subchannel numbers are system generated, each
 subchannel also takes a user defined attribute, the so called device number.
-Both subchannel number and device number can not exceed 65535. During driverfs
+Both subchannel number and device number cannot exceed 65535. During driverfs
 initialisation, the information about control unit type and device types that 
 imply specific I/O commands (channel command words - CCWs) in order to operate
 the device are gathered. Device drivers can retrieve this set of hardware
diff -ru a/Documentation/scsi/aic7xxx_old.txt b/Documentation/scsi/aic7xxx_old.txt
--- a/Documentation/scsi/aic7xxx_old.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/aic7xxx_old.txt	2006-07-26 19:03:31.000000000 -0400
@@ -102,7 +102,7 @@
     The hardware RAID devices sold by Adaptec are *NOT* supported by this
     driver (and will people please stop emailing me about them, they are
     a totally separate beast from the bare SCSI controllers and this driver
-    can not be retrofitted in any sane manner to support the hardware RAID
+    cannot be retrofitted in any sane manner to support the hardware RAID
     features on those cards - Doug Ledford).
     
 
diff -ru a/Documentation/stable_kernel_rules.txt b/Documentation/stable_kernel_rules.txt
--- a/Documentation/stable_kernel_rules.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/stable_kernel_rules.txt	2006-07-26 18:51:54.000000000 -0400
@@ -4,7 +4,7 @@
 "-stable" tree:
 
  - It must be obviously correct and tested.
- - It can not be bigger than 100 lines, with context.
+ - It cannot be bigger than 100 lines, with context.
  - It must fix only one thing.
  - It must fix a real bug that bothers people (not a, "This could be a
    problem..." type thing).
@@ -14,7 +14,7 @@
    critical.
  - No "theoretical race condition" issues, unless an explanation of how the
    race can be exploited is also provided.
- - It can not contain any "trivial" fixes in it (spelling changes,
+ - It cannot contain any "trivial" fixes in it (spelling changes,
    whitespace cleanups, etc).
  - It must be accepted by the relevant subsystem maintainer.
  - It must follow the Documentation/SubmittingPatches rules.
diff -ru a/Documentation/uml/UserModeLinux-HOWTO.txt b/Documentation/uml/UserModeLinux-HOWTO.txt
--- a/Documentation/uml/UserModeLinux-HOWTO.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/uml/UserModeLinux-HOWTO.txt	2006-07-26 18:49:01.000000000 -0400
@@ -4022,7 +4022,7 @@
   nneett
 
   If you can connect to the host, and the host can connect to UML, but
-  you can not connect to any other machines, then you may need to enable
+  you cannot connect to any other machines, then you may need to enable
   IP Masquerading on the host.  Usually this is only experienced when
   using private IP addresses (192.168.x.x or 10.x.x.x) for host/UML
   networking, rather than the public address space that your host is
diff -ru a/Documentation/video4linux/et61x251.txt b/Documentation/video4linux/et61x251.txt
--- a/Documentation/video4linux/et61x251.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/video4linux/et61x251.txt	2006-07-26 18:53:32.000000000 -0400
@@ -222,7 +222,7 @@
 	[root@localhost #] echo 1 > i2c_reg
 	[root@localhost #] cat i2c_val
 
-Note that if the sensor registers can not be read, "cat" will fail.
+Note that if the sensor registers cannot be read, "cat" will fail.
 To avoid race conditions, all the I/O accesses to the files are serialized.
 
 
diff -ru a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
--- a/Documentation/watchdog/watchdog-api.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/watchdog/watchdog-api.txt	2006-07-26 18:59:14.000000000 -0400
@@ -258,13 +258,13 @@
 	Timeout default varies according to frequency, supports
 	SETTIMEOUT
 
-	Watchdog can not be turned off, CONFIG_WATCHDOG_NOWAYOUT
+	Watchdog cannot be turned off, CONFIG_WATCHDOG_NOWAYOUT
 	does not make sense
 
 	GETSUPPORT returns the watchdog_info struct, and
 	GETSTATUS returns the supported options. GETBOOTSTATUS
 	returns a 1 if the last reset was caused by the
-	watchdog and a 0 otherwise. This watchdog can not be
+	watchdog and a 0 otherwise. This watchdog cannot be
 	disabled once it has been started. The wdt_period kernel
 	parameter selects which bit of the time base changing
 	from 0->1 will trigger the watchdog exception. Changing
diff -ru a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig	2006-07-16 22:07:20.000000000 -0400
+++ b/drivers/scsi/Kconfig	2006-07-26 19:15:43.000000000 -0400
@@ -78,7 +78,7 @@
 	tristate "SCSI OnStream SC-x0 tape support"
 	depends on SCSI
 	---help---
-	  The OnStream SC-x0 SCSI tape drives can not be driven by the
+	  The OnStream SC-x0 SCSI tape drives cannot be driven by the
 	  standard st driver, but instead need this special osst driver and
 	  use the  /dev/osstX char device nodes (major 206).  Via usb-storage
 	  and ide-scsi, you may be able to drive the USB-x0 and DI-x0 drives
diff -ru a/mm/Kconfig b/mm/Kconfig
--- a/mm/Kconfig	2006-07-16 22:07:41.000000000 -0400
+++ b/mm/Kconfig	2006-07-26 19:15:01.000000000 -0400
@@ -92,7 +92,7 @@
 
 #
 # SPARSEMEM_EXTREME (which is the default) does some bootmem
-# allocations when memory_present() is called.  If this can not
+# allocations when memory_present() is called.  If this cannot
 # be done on your architecture, select this option.  However,
 # statically allocating the mem_section[] array can potentially
 # consume vast quantities of .bss, so be careful.


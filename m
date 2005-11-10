Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVKJUnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVKJUnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVKJUnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:43:04 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:25945 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932094AbVKJUnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:43:00 -0500
Subject: [PATCH] cleanup module metadata declerations
From: Redeeman <redeeman@metanurb.dk>
Reply-To: redeeman@metanurb.dk
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-OgMKXyCTfWEKqGaPOjKG"
Date: Thu, 10 Nov 2005 21:42:52 +0100
Message-Id: <1131655372.2185.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OgMKXyCTfWEKqGaPOjKG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello.. i noticed that it looks different, but the vast majority of the
declerations had no whitespace, so i created this patch to make the rest
look like what the majority does..

ef452bf0a84b3d4f2aca8a4e10c6f194  Cleanup_module_metadata.patch

i dont know if this is nessecary:
Signed-off-by: Kasper Sandberg

-----
diffstat:
 arch/arm/mach-integrator/cpu.c                    |    6 +++---
 arch/i386/kernel/cpu/cpufreq/gx-suspmod.c         |    6 +++---
 arch/i386/kernel/cpu/cpufreq/longhaul.c           |    6 +++---
 arch/i386/kernel/cpu/cpufreq/longrun.c            |    6 +++---
 arch/i386/kernel/cpu/cpufreq/p4-clockmod.c        |    6 +++---
 arch/i386/kernel/cpu/cpufreq/powernow-k6.c        |    6 +++---
 arch/i386/kernel/cpu/cpufreq/powernow-k7.c        |    6 +++---
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    6 +++---
 arch/i386/kernel/cpu/cpufreq/speedstep-ich.c      |    6 +++---
 arch/i386/kernel/cpu/cpufreq/speedstep-lib.c      |    6 +++---
 arch/i386/kernel/cpu/cpufreq/speedstep-smi.c      |    6 +++---
 crypto/twofish.c                                  |    2 +-
 drivers/cpufreq/cpufreq_conservative.c            |    6 +++---
 drivers/cpufreq/cpufreq_ondemand.c                |    6 +++---
 drivers/cpufreq/cpufreq_stats.c                   |    6 +++---
 drivers/cpufreq/cpufreq_userspace.c               |    6 +++---
 drivers/cpufreq/freq_table.c                      |    6 +++---
 drivers/hwmon/adm1021.c                           |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c                  |    2 +-
 drivers/i2c/busses/i2c-amd8111.c                  |    2 +-
 drivers/i2c/busses/i2c-frodo.c                    |    6 +++---
 drivers/i2c/busses/i2c-i801.c                     |    2 +-
 drivers/i2c/busses/i2c-ixp2000.c                  |    2 +-
 drivers/i2c/busses/i2c-nforce2.c                  |    2 +-
 drivers/input/keyboard/lkkbd.c                    |   14 +++++++-------
 drivers/input/mouse/vsxxxaa.c                     |    6 +++---
 drivers/mtd/maps/sbc8240.c                        |    6 +++---
 drivers/mtd/nand/nand_base.c                      |    6 +++---
 drivers/mtd/nand/nand_ids.c                       |    6 +++---
 drivers/mtd/nand/nandsim.c                        |    6 +++---
 drivers/net/8139cp.c                              |    4 ++--
 drivers/net/8139too.c                             |   12 ++++++------
 drivers/net/amd8111e.c                            |    2 +-
 drivers/net/dl2k.c                                |    4 ++--
 drivers/net/mii.c                                 |    4 ++--
 drivers/net/pci-skeleton.c                        |   10 +++++-----
 drivers/net/tulip/de2104x.c                       |    4 ++--
 drivers/net/znet.c                                |    2 +-
 drivers/pci/hotplug/ibmphp_core.c                 |    6 +++---
 drivers/pcmcia/yenta_socket.c                     |    2 +-
 drivers/s390/char/vmlogrdr.c                      |    2 +-
 drivers/s390/net/netiucv.c                        |    2 +-
 drivers/s390/net/smsgiucv.c                       |    2 +-
 drivers/scsi/3w-9xxx.c                            |    4 ++--
 drivers/scsi/megaraid.c                           |    6 +++---
 drivers/serial/serial_lh7a40x.c                   |    6 +++---
 drivers/serial/v850e_uart.c                       |    6 +++---
 drivers/usb/core/devio.c                          |    2 +-
 drivers/usb/core/hub.c                            |    2 +-
 drivers/usb/gadget/dummy_hcd.c                    |    6 +++---
 drivers/usb/gadget/ether.c                        |    6 +++---
 drivers/usb/gadget/inode.c                        |    6 +++---
 drivers/usb/gadget/net2280.c                      |    6 +++---
 drivers/usb/gadget/omap_udc.c                     |    4 ++--
 drivers/usb/gadget/pxa2xx_udc.c                   |    4 ++--
 drivers/usb/gadget/rndis.c                        |    2 +-
 drivers/usb/gadget/zero.c                         |    4 ++--
 drivers/usb/host/ehci-hcd.c                       |   10 +++++-----
 drivers/usb/host/ohci-hcd.c                       |   10 +++++-----
 drivers/usb/media/dabusb.c                        |    2 +-
 drivers/usb/media/ibmcam.c                        |    4 ++--
 drivers/usb/media/stv680.c                        |   10 +++++-----
 drivers/usb/misc/auerswald.c                      |    6 +++---
 drivers/usb/misc/usbtest.c                        |   14 +++++++-------
 drivers/usb/net/pegasus.c                         |    2 +-
 drivers/usb/net/usbnet.c                          |    2 +-
 drivers/usb/serial/safe_serial.c                  |    4 ++--
 sound/oss/wavfront.c                              |    2 +-
 68 files changed, 173 insertions(+), 173 deletions(-)


--=-OgMKXyCTfWEKqGaPOjKG
Content-Disposition: attachment; filename=Cleanup_module_metadata.patch
Content-Type: text/x-patch; name=Cleanup_module_metadata.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.6.14-a/arch/arm/mach-integrator/cpu.c linux-2.6.14-b/arch/arm/mach-integrator/cpu.c
--- linux-2.6.14-a/arch/arm/mach-integrator/cpu.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/arch/arm/mach-integrator/cpu.c	2005-11-10 21:32:34.134517160 +0100
@@ -213,9 +213,9 @@
 	cpufreq_unregister_driver(&integrator_driver);
 }
 
-MODULE_AUTHOR ("Russell M. King");
-MODULE_DESCRIPTION ("cpufreq driver for ARM Integrator CPUs");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Russell M. King");
+MODULE_DESCRIPTION("cpufreq driver for ARM Integrator CPUs");
+MODULE_LICENSE("GPL");
 
 module_init(integrator_cpu_init);
 module_exit(integrator_cpu_exit);
diff -Naur linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
--- linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2005-11-10 21:32:34.497461984 +0100
@@ -493,9 +493,9 @@
 	kfree(gx_params);
 }
 
-MODULE_AUTHOR ("Hiroshi Miura <miura@da-cha.org>");
-MODULE_DESCRIPTION ("Cpufreq driver for Cyrix MediaGX and NatSemi Geode");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Hiroshi Miura <miura@da-cha.org>");
+MODULE_DESCRIPTION("Cpufreq driver for Cyrix MediaGX and NatSemi Geode");
+MODULE_LICENSE("GPL");
 
 module_init(cpufreq_gx_init);
 module_exit(cpufreq_gx_exit);
diff -Naur linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/longhaul.c linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/longhaul.c	2005-11-10 21:16:22.225269824 +0100
+++ linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/longhaul.c	2005-11-10 21:32:34.489463200 +0100
@@ -691,9 +691,9 @@
 module_param (dont_scale_voltage, int, 0644);
 MODULE_PARM_DESC(dont_scale_voltage, "Don't scale voltage of processor");
 
-MODULE_AUTHOR ("Dave Jones <davej@codemonkey.org.uk>");
-MODULE_DESCRIPTION ("Longhaul driver for VIA Cyrix processors.");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Dave Jones <davej@codemonkey.org.uk>");
+MODULE_DESCRIPTION("Longhaul driver for VIA Cyrix processors.");
+MODULE_LICENSE("GPL");
 
 module_init(longhaul_init);
 module_exit(longhaul_exit);
diff -Naur linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/longrun.c linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/longrun.c
--- linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/longrun.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/longrun.c	2005-11-10 21:32:34.496462136 +0100
@@ -318,9 +318,9 @@
 }
 
 
-MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>");
-MODULE_DESCRIPTION ("LongRun driver for Transmeta Crusoe and Efficeon processors.");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
+MODULE_DESCRIPTION("LongRun driver for Transmeta Crusoe and Efficeon processors.");
+MODULE_LICENSE("GPL");
 
 module_init(longrun_init);
 module_exit(longrun_exit);
diff -Naur linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2005-11-10 21:32:34.495462288 +0100
@@ -329,9 +329,9 @@
 }
 
 
-MODULE_AUTHOR ("Zwane Mwaikambo <zwane@commfireservices.com>");
-MODULE_DESCRIPTION ("cpufreq driver for Pentium(TM) 4/Xeon(TM)");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Zwane Mwaikambo <zwane@commfireservices.com>");
+MODULE_DESCRIPTION("cpufreq driver for Pentium(TM) 4/Xeon(TM)");
+MODULE_LICENSE("GPL");
 
 late_initcall(cpufreq_p4_init);
 module_exit(cpufreq_p4_exit);
diff -Naur linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2005-11-10 21:32:34.494462440 +0100
@@ -248,9 +248,9 @@
 }
 
 
-MODULE_AUTHOR ("Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@codemonkey.org.uk>, Dominik Brodowski <linux@brodo.de>");
-MODULE_DESCRIPTION ("PowerNow! driver for AMD K6-2+ / K6-3+ processors.");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@codemonkey.org.uk>, Dominik Brodowski <linux@brodo.de>");
+MODULE_DESCRIPTION("PowerNow! driver for AMD K6-2+ / K6-3+ processors.");
+MODULE_LICENSE("GPL");
 
 module_init(powernow_k6_init);
 module_exit(powernow_k6_exit);
diff -Naur linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/powernow-k7.c linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
--- linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2005-11-10 21:32:34.494462440 +0100
@@ -684,9 +684,9 @@
 module_param(acpi_force,  int, 0444);
 MODULE_PARM_DESC(acpi_force, "Force ACPI to be used.");
 
-MODULE_AUTHOR ("Dave Jones <davej@codemonkey.org.uk>");
-MODULE_DESCRIPTION ("Powernow driver for AMD K7 processors.");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Dave Jones <davej@codemonkey.org.uk>");
+MODULE_DESCRIPTION("Powernow driver for AMD K7 processors.");
+MODULE_LICENSE("GPL");
 
 late_initcall(powernow_init);
 module_exit(powernow_exit);
diff -Naur linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
--- linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-11-10 21:16:22.227269520 +0100
+++ linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-11-10 21:32:34.484463960 +0100
@@ -713,9 +713,9 @@
 	cpufreq_unregister_driver(&centrino_driver);
 }
 
-MODULE_AUTHOR ("Jeremy Fitzhardinge <jeremy@goop.org>");
-MODULE_DESCRIPTION ("Enhanced SpeedStep driver for Intel Pentium M processors.");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Jeremy Fitzhardinge <jeremy@goop.org>");
+MODULE_DESCRIPTION("Enhanced SpeedStep driver for Intel Pentium M processors.");
+MODULE_LICENSE("GPL");
 
 late_initcall(centrino_init);
 module_exit(centrino_exit);
diff -Naur linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c
--- linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c	2005-11-10 21:32:34.492462744 +0100
@@ -416,9 +416,9 @@
 }
 
 
-MODULE_AUTHOR ("Dave Jones <davej@codemonkey.org.uk>, Dominik Brodowski <linux@brodo.de>");
-MODULE_DESCRIPTION ("Speedstep driver for Intel mobile processors on chipsets with ICH-M southbridges.");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Dave Jones <davej@codemonkey.org.uk>, Dominik Brodowski <linux@brodo.de>");
+MODULE_DESCRIPTION("Speedstep driver for Intel mobile processors on chipsets with ICH-M southbridges.");
+MODULE_LICENSE("GPL");
 
 module_init(speedstep_init);
 module_exit(speedstep_exit);
diff -Naur linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c
--- linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c	2005-11-10 21:32:34.491462896 +0100
@@ -380,6 +380,6 @@
 MODULE_PARM_DESC(relaxed_check, "Don't do all checks for speedstep capability.");
 #endif
 
-MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>");
-MODULE_DESCRIPTION ("Library for Intel SpeedStep 1 or 2 cpufreq drivers.");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
+MODULE_DESCRIPTION("Library for Intel SpeedStep 1 or 2 cpufreq drivers.");
+MODULE_LICENSE("GPL");
diff -Naur linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/speedstep-smi.c linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/speedstep-smi.c
--- linux-2.6.14-a/arch/i386/kernel/cpu/cpufreq/speedstep-smi.c	2005-11-10 21:16:22.228269368 +0100
+++ linux-2.6.14-b/arch/i386/kernel/cpu/cpufreq/speedstep-smi.c	2005-11-10 21:32:34.483464112 +0100
@@ -419,9 +419,9 @@
 MODULE_PARM_DESC(smi_cmd, "Override the BIOS-given IST command with this value -- Intel's default setting is 0x82");
 MODULE_PARM_DESC(smi_sig, "Set to 1 to fake the IST signature when using the SMI interface.");
 
-MODULE_AUTHOR ("Hiroshi Miura");
-MODULE_DESCRIPTION ("Speedstep driver for IST applet SMI interface.");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Hiroshi Miura");
+MODULE_DESCRIPTION("Speedstep driver for IST applet SMI interface.");
+MODULE_LICENSE("GPL");
 
 module_init(speedstep_init);
 module_exit(speedstep_exit);
diff -Naur linux-2.6.14-a/crypto/twofish.c linux-2.6.14-b/crypto/twofish.c
--- linux-2.6.14-a/crypto/twofish.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/crypto/twofish.c	2005-11-10 21:32:36.016231096 +0100
@@ -899,4 +899,4 @@
 module_exit(fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION ("Twofish Cipher Algorithm");
+MODULE_DESCRIPTION("Twofish Cipher Algorithm");
diff -Naur linux-2.6.14-a/drivers/cpufreq/cpufreq_conservative.c linux-2.6.14-b/drivers/cpufreq/cpufreq_conservative.c
--- linux-2.6.14-a/drivers/cpufreq/cpufreq_conservative.c	2005-11-10 21:16:23.480079064 +0100
+++ linux-2.6.14-b/drivers/cpufreq/cpufreq_conservative.c	2005-11-10 21:32:37.074070280 +0100
@@ -576,11 +576,11 @@
 }
 
 
-MODULE_AUTHOR ("Alexander Clouter <alex-kernel@digriz.org.uk>");
-MODULE_DESCRIPTION ("'cpufreq_conservative' - A dynamic cpufreq governor for "
+MODULE_AUTHOR("Alexander Clouter <alex-kernel@digriz.org.uk>");
+MODULE_DESCRIPTION("'cpufreq_conservative' - A dynamic cpufreq governor for "
 		"Low Latency Frequency Transition capable processors "
 		"optimised for use in a battery environment");
-MODULE_LICENSE ("GPL");
+MODULE_LICENSE("GPL");
 
 module_init(cpufreq_gov_dbs_init);
 module_exit(cpufreq_gov_dbs_exit);
diff -Naur linux-2.6.14-a/drivers/cpufreq/cpufreq_ondemand.c linux-2.6.14-b/drivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.14-a/drivers/cpufreq/cpufreq_ondemand.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/cpufreq/cpufreq_ondemand.c	2005-11-10 21:32:37.080069368 +0100
@@ -484,10 +484,10 @@
 }
 
 
-MODULE_AUTHOR ("Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>");
-MODULE_DESCRIPTION ("'cpufreq_ondemand' - A dynamic cpufreq governor for "
+MODULE_AUTHOR("Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>");
+MODULE_DESCRIPTION("'cpufreq_ondemand' - A dynamic cpufreq governor for "
 		"Low Latency Frequency Transition capable processors");
-MODULE_LICENSE ("GPL");
+MODULE_LICENSE("GPL");
 
 module_init(cpufreq_gov_dbs_init);
 module_exit(cpufreq_gov_dbs_exit);
diff -Naur linux-2.6.14-a/drivers/cpufreq/cpufreq_stats.c linux-2.6.14-b/drivers/cpufreq/cpufreq_stats.c
--- linux-2.6.14-a/drivers/cpufreq/cpufreq_stats.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/cpufreq/cpufreq_stats.c	2005-11-10 21:32:37.079069520 +0100
@@ -339,9 +339,9 @@
 		cpufreq_stats_free_table(cpu);
 }
 
-MODULE_AUTHOR ("Zou Nan hai <nanhai.zou@intel.com>");
-MODULE_DESCRIPTION ("'cpufreq_stats' - A driver to export cpufreq stats through sysfs filesystem");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Zou Nan hai <nanhai.zou@intel.com>");
+MODULE_DESCRIPTION("'cpufreq_stats' - A driver to export cpufreq stats through sysfs filesystem");
+MODULE_LICENSE("GPL");
 
 module_init(cpufreq_stats_init);
 module_exit(cpufreq_stats_exit);
diff -Naur linux-2.6.14-a/drivers/cpufreq/cpufreq_userspace.c linux-2.6.14-b/drivers/cpufreq/cpufreq_userspace.c
--- linux-2.6.14-a/drivers/cpufreq/cpufreq_userspace.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/cpufreq/cpufreq_userspace.c	2005-11-10 21:32:37.078069672 +0100
@@ -199,9 +199,9 @@
 }
 
 
-MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>, Russell King <rmk@arm.linux.org.uk>");
-MODULE_DESCRIPTION ("CPUfreq policy governor 'userspace'");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>, Russell King <rmk@arm.linux.org.uk>");
+MODULE_DESCRIPTION("CPUfreq policy governor 'userspace'");
+MODULE_LICENSE("GPL");
 
 fs_initcall(cpufreq_gov_userspace_init);
 module_exit(cpufreq_gov_userspace_exit);
diff -Naur linux-2.6.14-a/drivers/cpufreq/freq_table.c linux-2.6.14-b/drivers/cpufreq/freq_table.c
--- linux-2.6.14-a/drivers/cpufreq/freq_table.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/cpufreq/freq_table.c	2005-11-10 21:32:37.077069824 +0100
@@ -220,6 +220,6 @@
 }
 EXPORT_SYMBOL_GPL(cpufreq_frequency_get_table);
 
-MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>");
-MODULE_DESCRIPTION ("CPUfreq frequency table helpers");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
+MODULE_DESCRIPTION("CPUfreq frequency table helpers");
+MODULE_LICENSE("GPL");
diff -Naur linux-2.6.14-a/drivers/hwmon/adm1021.c linux-2.6.14-b/drivers/hwmon/adm1021.c
--- linux-2.6.14-a/drivers/hwmon/adm1021.c	2005-11-10 21:16:23.486078152 +0100
+++ linux-2.6.14-b/drivers/hwmon/adm1021.c	2005-11-10 21:32:37.160057208 +0100
@@ -391,7 +391,7 @@
 	i2c_del_driver(&adm1021_driver);
 }
 
-MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl> and "
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and "
 		"Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("adm1021 driver");
 MODULE_LICENSE("GPL");
diff -Naur linux-2.6.14-a/drivers/i2c/busses/i2c-ali15x3.c linux-2.6.14-b/drivers/i2c/busses/i2c-ali15x3.c
--- linux-2.6.14-a/drivers/i2c/busses/i2c-ali15x3.c	2005-11-10 21:16:23.532071160 +0100
+++ linux-2.6.14-b/drivers/i2c/busses/i2c-ali15x3.c	2005-11-10 21:32:37.195051888 +0100
@@ -519,7 +519,7 @@
 	pci_unregister_driver(&ali15x3_driver);
 }
 
-MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl>, "
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
 		"Philip Edelbrock <phil@netroedge.com>, "
 		"and Mark D. Studebaker <mdsxyz123@yahoo.com>");
 MODULE_DESCRIPTION("ALI15X3 SMBus driver");
diff -Naur linux-2.6.14-a/drivers/i2c/busses/i2c-amd8111.c linux-2.6.14-b/drivers/i2c/busses/i2c-amd8111.c
--- linux-2.6.14-a/drivers/i2c/busses/i2c-amd8111.c	2005-11-10 21:16:23.533071008 +0100
+++ linux-2.6.14-b/drivers/i2c/busses/i2c-amd8111.c	2005-11-10 21:32:37.192052344 +0100
@@ -20,7 +20,7 @@
 #include <asm/io.h>
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR ("Vojtech Pavlik <vojtech@suse.cz>");
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("AMD8111 SMBus 2.0 driver");
 
 struct amd_smbus {
diff -Naur linux-2.6.14-a/drivers/i2c/busses/i2c-frodo.c linux-2.6.14-b/drivers/i2c/busses/i2c-frodo.c
--- linux-2.6.14-a/drivers/i2c/busses/i2c-frodo.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/i2c/busses/i2c-frodo.c	2005-11-10 21:32:37.204050520 +0100
@@ -76,9 +76,9 @@
 	i2c_bit_del_bus(&frodo_ops);
 }
 
-MODULE_AUTHOR ("Abraham van der Merwe <abraham@2d3d.co.za>");
-MODULE_DESCRIPTION ("I2C-Bus adapter routines for Frodo");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Abraham van der Merwe <abraham@2d3d.co.za>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for Frodo");
+MODULE_LICENSE("GPL");
 
 module_init (i2c_frodo_init);
 module_exit (i2c_frodo_exit);
diff -Naur linux-2.6.14-a/drivers/i2c/busses/i2c-i801.c linux-2.6.14-b/drivers/i2c/busses/i2c-i801.c
--- linux-2.6.14-a/drivers/i2c/busses/i2c-i801.c	2005-11-10 21:16:23.535070704 +0100
+++ linux-2.6.14-b/drivers/i2c/busses/i2c-i801.c	2005-11-10 21:32:37.191052496 +0100
@@ -602,7 +602,7 @@
 	pci_unregister_driver(&i801_driver);
 }
 
-MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl>, "
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
 		"Philip Edelbrock <phil@netroedge.com>, "
 		"and Mark D. Studebaker <mdsxyz123@yahoo.com>");
 MODULE_DESCRIPTION("I801 SMBus driver");
diff -Naur linux-2.6.14-a/drivers/i2c/busses/i2c-ixp2000.c linux-2.6.14-b/drivers/i2c/busses/i2c-ixp2000.c
--- linux-2.6.14-a/drivers/i2c/busses/i2c-ixp2000.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/i2c/busses/i2c-ixp2000.c	2005-11-10 21:32:37.202050824 +0100
@@ -161,7 +161,7 @@
 module_init(ixp2000_i2c_init);
 module_exit(ixp2000_i2c_exit);
 
-MODULE_AUTHOR ("Deepak Saxena <dsaxena@plexity.net>");
+MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net>");
 MODULE_DESCRIPTION("IXP2000 GPIO-based I2C bus driver");
 MODULE_LICENSE("GPL");
 
diff -Naur linux-2.6.14-a/drivers/i2c/busses/i2c-nforce2.c linux-2.6.14-b/drivers/i2c/busses/i2c-nforce2.c
--- linux-2.6.14-a/drivers/i2c/busses/i2c-nforce2.c	2005-11-10 21:16:23.540069944 +0100
+++ linux-2.6.14-b/drivers/i2c/busses/i2c-nforce2.c	2005-11-10 21:32:37.182053864 +0100
@@ -49,7 +49,7 @@
 #include <asm/io.h>
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR ("Hans-Frieder Vogt <hfvogt@arcor.de>");
+MODULE_AUTHOR("Hans-Frieder Vogt <hfvogt@arcor.de>");
 MODULE_DESCRIPTION("nForce2 SMBus driver");
 
 
diff -Naur linux-2.6.14-a/drivers/input/keyboard/lkkbd.c linux-2.6.14-b/drivers/input/keyboard/lkkbd.c
--- linux-2.6.14-a/drivers/input/keyboard/lkkbd.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/input/keyboard/lkkbd.c	2005-11-10 21:32:37.497005984 +0100
@@ -78,9 +78,9 @@
 
 #define DRIVER_DESC	"LK keyboard driver"
 
-MODULE_AUTHOR ("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
-MODULE_DESCRIPTION (DRIVER_DESC);
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
 
 /*
  * Known parameters:
@@ -92,19 +92,19 @@
  */
 static int bell_volume = 100; /* % */
 module_param (bell_volume, int, 0);
-MODULE_PARM_DESC (bell_volume, "Bell volume (in %). default is 100%");
+MODULE_PARM_DESC(bell_volume, "Bell volume (in %). default is 100%");
 
 static int keyclick_volume = 100; /* % */
 module_param (keyclick_volume, int, 0);
-MODULE_PARM_DESC (keyclick_volume, "Keyclick volume (in %), default is 100%");
+MODULE_PARM_DESC(keyclick_volume, "Keyclick volume (in %), default is 100%");
 
 static int ctrlclick_volume = 100; /* % */
 module_param (ctrlclick_volume, int, 0);
-MODULE_PARM_DESC (ctrlclick_volume, "Ctrlclick volume (in %), default is 100%");
+MODULE_PARM_DESC(ctrlclick_volume, "Ctrlclick volume (in %), default is 100%");
 
 static int lk201_compose_is_alt = 0;
 module_param (lk201_compose_is_alt, int, 0);
-MODULE_PARM_DESC (lk201_compose_is_alt, "If set non-zero, LK201' Compose key "
+MODULE_PARM_DESC(lk201_compose_is_alt, "If set non-zero, LK201' Compose key "
 		"will act as an Alt key");
 
 
diff -Naur linux-2.6.14-a/drivers/input/mouse/vsxxxaa.c linux-2.6.14-b/drivers/input/mouse/vsxxxaa.c
--- linux-2.6.14-a/drivers/input/mouse/vsxxxaa.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/input/mouse/vsxxxaa.c	2005-11-10 21:32:37.510004008 +0100
@@ -87,9 +87,9 @@
 
 #define DRIVER_DESC "Driver for DEC VSXXX-AA and -GA mice and VSXXX-AB tablet"
 
-MODULE_AUTHOR ("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
-MODULE_DESCRIPTION (DRIVER_DESC);
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
 
 #undef VSXXXAA_DEBUG
 #ifdef VSXXXAA_DEBUG
diff -Naur linux-2.6.14-a/drivers/mtd/maps/sbc8240.c linux-2.6.14-b/drivers/mtd/maps/sbc8240.c
--- linux-2.6.14-a/drivers/mtd/maps/sbc8240.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/mtd/maps/sbc8240.c	2005-11-10 21:32:38.420865536 +0100
@@ -241,7 +241,7 @@
 module_init (init_sbc8240_mtd);
 module_exit (cleanup_sbc8240_mtd);
 
-MODULE_LICENSE ("GPL");
-MODULE_AUTHOR ("Carolyn Smith <carolyn.smith@tektronix.com>");
-MODULE_DESCRIPTION ("MTD map driver for SBC8240 boards");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Carolyn Smith <carolyn.smith@tektronix.com>");
+MODULE_DESCRIPTION("MTD map driver for SBC8240 boards");
 
diff -Naur linux-2.6.14-a/drivers/mtd/nand/nand_base.c linux-2.6.14-b/drivers/mtd/nand/nand_base.c
--- linux-2.6.14-a/drivers/mtd/nand/nand_base.c	2005-11-10 21:16:23.942008840 +0100
+++ linux-2.6.14-b/drivers/mtd/nand/nand_base.c	2005-11-10 21:32:38.451860824 +0100
@@ -2690,6 +2690,6 @@
 EXPORT_SYMBOL_GPL (nand_scan);
 EXPORT_SYMBOL_GPL (nand_release);
 
-MODULE_LICENSE ("GPL");
-MODULE_AUTHOR ("Steven J. Hill <sjhill@realitydiluted.com>, Thomas Gleixner <tglx@linutronix.de>");
-MODULE_DESCRIPTION ("Generic NAND flash driver code");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Steven J. Hill <sjhill@realitydiluted.com>, Thomas Gleixner <tglx@linutronix.de>");
+MODULE_DESCRIPTION("Generic NAND flash driver code");
diff -Naur linux-2.6.14-a/drivers/mtd/nand/nand_ids.c linux-2.6.14-b/drivers/mtd/nand/nand_ids.c
--- linux-2.6.14-a/drivers/mtd/nand/nand_ids.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/mtd/nand/nand_ids.c	2005-11-10 21:32:38.458859760 +0100
@@ -132,6 +132,6 @@
 EXPORT_SYMBOL (nand_manuf_ids);
 EXPORT_SYMBOL (nand_flash_ids);
 
-MODULE_LICENSE ("GPL");
-MODULE_AUTHOR ("Thomas Gleixner <tglx@linutronix.de>");
-MODULE_DESCRIPTION ("Nand device & manufacturer ID's");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Thomas Gleixner <tglx@linutronix.de>");
+MODULE_DESCRIPTION("Nand device & manufacturer ID's");
diff -Naur linux-2.6.14-a/drivers/mtd/nand/nandsim.c linux-2.6.14-b/drivers/mtd/nand/nandsim.c
--- linux-2.6.14-a/drivers/mtd/nand/nandsim.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/mtd/nand/nandsim.c	2005-11-10 21:32:38.458859760 +0100
@@ -1590,7 +1590,7 @@
 
 module_exit(ns_cleanup_module);
 
-MODULE_LICENSE ("GPL");
-MODULE_AUTHOR ("Artem B. Bityuckiy");
-MODULE_DESCRIPTION ("The NAND flash simulator");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Artem B. Bityuckiy");
+MODULE_DESCRIPTION("The NAND flash simulator");
 
diff -Naur linux-2.6.14-a/drivers/net/8139cp.c linux-2.6.14-b/drivers/net/8139cp.c
--- linux-2.6.14-a/drivers/net/8139cp.c	2005-11-10 21:16:23.947008080 +0100
+++ linux-2.6.14-b/drivers/net/8139cp.c	2005-11-10 21:32:38.677826472 +0100
@@ -98,13 +98,13 @@
 
 static int debug = -1;
 module_param(debug, int, 0);
-MODULE_PARM_DESC (debug, "8139cp: bitmapped message enable number");
+MODULE_PARM_DESC(debug, "8139cp: bitmapped message enable number");
 
 /* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
    The RTL chips use a 64 element hash table based on the Ethernet CRC.  */
 static int multicast_filter_limit = 32;
 module_param(multicast_filter_limit, int, 0);
-MODULE_PARM_DESC (multicast_filter_limit, "8139cp: maximum number of filtered multicast addresses");
+MODULE_PARM_DESC(multicast_filter_limit, "8139cp: maximum number of filtered multicast addresses");
 
 #define PFX			DRV_NAME ": "
 
diff -Naur linux-2.6.14-a/drivers/net/8139too.c linux-2.6.14-b/drivers/net/8139too.c
--- linux-2.6.14-a/drivers/net/8139too.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/net/8139too.c	2005-11-10 21:32:38.993778440 +0100
@@ -600,8 +600,8 @@
 	unsigned long fifo_copy_timeout;
 };
 
-MODULE_AUTHOR ("Jeff Garzik <jgarzik@pobox.com>");
-MODULE_DESCRIPTION ("RealTek RTL-8139 Fast Ethernet driver");
+MODULE_AUTHOR("Jeff Garzik <jgarzik@pobox.com>");
+MODULE_DESCRIPTION("RealTek RTL-8139 Fast Ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
@@ -609,10 +609,10 @@
 module_param_array(media, int, NULL, 0);
 module_param_array(full_duplex, int, NULL, 0);
 module_param(debug, int, 0);
-MODULE_PARM_DESC (debug, "8139too bitmapped message enable number");
-MODULE_PARM_DESC (multicast_filter_limit, "8139too maximum number of filtered multicast addresses");
-MODULE_PARM_DESC (media, "8139too: Bits 4+9: force full duplex, bit 5: 100Mbps");
-MODULE_PARM_DESC (full_duplex, "8139too: Force full duplex for board(s) (1)");
+MODULE_PARM_DESC(debug, "8139too bitmapped message enable number");
+MODULE_PARM_DESC(multicast_filter_limit, "8139too maximum number of filtered multicast addresses");
+MODULE_PARM_DESC(media, "8139too: Bits 4+9: force full duplex, bit 5: 100Mbps");
+MODULE_PARM_DESC(full_duplex, "8139too: Force full duplex for board(s) (1)");
 
 static int read_eeprom (void __iomem *ioaddr, int location, int addr_len);
 static int rtl8139_open (struct net_device *dev);
diff -Naur linux-2.6.14-a/drivers/net/amd8111e.c linux-2.6.14-b/drivers/net/amd8111e.c
--- linux-2.6.14-a/drivers/net/amd8111e.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/net/amd8111e.c	2005-11-10 21:32:38.974781328 +0100
@@ -104,7 +104,7 @@
 #define MODULE_NAME	"amd8111e"
 #define MODULE_VERS	"3.0.5"
 MODULE_AUTHOR("Advanced Micro Devices, Inc.");
-MODULE_DESCRIPTION ("AMD8111 based 10/100 Ethernet Controller. Driver Version 3.0.3");
+MODULE_DESCRIPTION("AMD8111 based 10/100 Ethernet Controller. Driver Version 3.0.3");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, amd8111e_pci_tbl);
 module_param_array(speed_duplex, int, NULL, 0);
diff -Naur linux-2.6.14-a/drivers/net/dl2k.c linux-2.6.14-b/drivers/net/dl2k.c
--- linux-2.6.14-a/drivers/net/dl2k.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/net/dl2k.c	2005-11-10 21:32:38.906791664 +0100
@@ -69,8 +69,8 @@
 static int tx_coalesce=16;	/* HW xmit count each TxDMAComplete */
 
 
-MODULE_AUTHOR ("Edward Peng");
-MODULE_DESCRIPTION ("D-Link DL2000-based Gigabit Ethernet Adapter");
+MODULE_AUTHOR("Edward Peng");
+MODULE_DESCRIPTION("D-Link DL2000-based Gigabit Ethernet Adapter");
 MODULE_LICENSE("GPL");
 module_param_array(mtu, int, NULL, 0);
 module_param_array(media, charp, NULL, 0);
diff -Naur linux-2.6.14-a/drivers/net/mii.c linux-2.6.14-b/drivers/net/mii.c
--- linux-2.6.14-a/drivers/net/mii.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/net/mii.c	2005-11-10 21:32:38.825803976 +0100
@@ -384,8 +384,8 @@
 	return rc;
 }
 
-MODULE_AUTHOR ("Jeff Garzik <jgarzik@pobox.com>");
-MODULE_DESCRIPTION ("MII hardware support library");
+MODULE_AUTHOR("Jeff Garzik <jgarzik@pobox.com>");
+MODULE_DESCRIPTION("MII hardware support library");
 MODULE_LICENSE("GPL");
 
 EXPORT_SYMBOL(mii_link_ok);
diff -Naur linux-2.6.14-a/drivers/net/pci-skeleton.c linux-2.6.14-b/drivers/net/pci-skeleton.c
--- linux-2.6.14-a/drivers/net/pci-skeleton.c	2005-11-10 21:16:24.066989840 +0100
+++ linux-2.6.14-b/drivers/net/pci-skeleton.c	2005-11-10 21:32:38.575841976 +0100
@@ -483,15 +483,15 @@
 	chip_t chipset;
 };
 
-MODULE_AUTHOR ("Jeff Garzik <jgarzik@pobox.com>");
-MODULE_DESCRIPTION ("Skeleton for a PCI Fast Ethernet driver");
+MODULE_AUTHOR("Jeff Garzik <jgarzik@pobox.com>");
+MODULE_DESCRIPTION("Skeleton for a PCI Fast Ethernet driver");
 MODULE_LICENSE("GPL");
 module_param(multicast_filter_limit, int, 0);
 module_param(max_interrupt_work, int, 0);
 module_param_array(media, int, NULL, 0);
-MODULE_PARM_DESC (multicast_filter_limit, "pci-skeleton maximum number of filtered multicast addresses");
-MODULE_PARM_DESC (max_interrupt_work, "pci-skeleton maximum events handled per interrupt");
-MODULE_PARM_DESC (media, "pci-skeleton: Bits 0-3: media type, bit 17: full duplex");
+MODULE_PARM_DESC(multicast_filter_limit, "pci-skeleton maximum number of filtered multicast addresses");
+MODULE_PARM_DESC(max_interrupt_work, "pci-skeleton maximum events handled per interrupt");
+MODULE_PARM_DESC(media, "pci-skeleton: Bits 0-3: media type, bit 17: full duplex");
 
 static int read_eeprom (void *ioaddr, int location, int addr_len);
 static int netdrv_open (struct net_device *dev);
diff -Naur linux-2.6.14-a/drivers/net/tulip/de2104x.c linux-2.6.14-b/drivers/net/tulip/de2104x.c
--- linux-2.6.14-a/drivers/net/tulip/de2104x.c	2005-11-10 21:16:24.144977984 +0100
+++ linux-2.6.14-b/drivers/net/tulip/de2104x.c	2005-11-10 21:32:39.429712168 +0100
@@ -60,7 +60,7 @@
 
 static int debug = -1;
 module_param (debug, int, 0);
-MODULE_PARM_DESC (debug, "de2104x bitmapped message enable number");
+MODULE_PARM_DESC(debug, "de2104x bitmapped message enable number");
 
 /* Set the copy breakpoint for the copy-only-tiny-buffer Rx structure. */
 #if defined(__alpha__) || defined(__arm__) || defined(__hppa__) \
@@ -71,7 +71,7 @@
 static int rx_copybreak = 100;
 #endif
 module_param (rx_copybreak, int, 0);
-MODULE_PARM_DESC (rx_copybreak, "de2104x Breakpoint at which Rx packets are copied");
+MODULE_PARM_DESC(rx_copybreak, "de2104x Breakpoint at which Rx packets are copied");
 
 #define PFX			DRV_NAME ": "
 
diff -Naur linux-2.6.14-a/drivers/net/znet.c linux-2.6.14-b/drivers/net/znet.c
--- linux-2.6.14-a/drivers/net/znet.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/net/znet.c	2005-11-10 21:32:38.688824800 +0100
@@ -114,7 +114,7 @@
 #endif
 static unsigned int znet_debug = ZNET_DEBUG;
 module_param (znet_debug, int, 0);
-MODULE_PARM_DESC (znet_debug, "ZNet debug level");
+MODULE_PARM_DESC(znet_debug, "ZNet debug level");
 MODULE_LICENSE("GPL");
 
 /* The DMA modes we need aren't in <dma.h>. */
diff -Naur linux-2.6.14-a/drivers/pci/hotplug/ibmphp_core.c linux-2.6.14-b/drivers/pci/hotplug/ibmphp_core.c
--- linux-2.6.14-a/drivers/pci/hotplug/ibmphp_core.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/pci/hotplug/ibmphp_core.c	2005-11-10 21:32:39.923637080 +0100
@@ -52,9 +52,9 @@
 
 static int debug;
 module_param(debug, bool, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC (debug, "Debugging mode enabled or not");
-MODULE_LICENSE ("GPL");
-MODULE_DESCRIPTION (DRIVER_DESC);
+MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION(DRIVER_DESC);
 
 struct pci_bus *ibmphp_pci_bus;
 static int max_slots;
diff -Naur linux-2.6.14-a/drivers/pcmcia/yenta_socket.c linux-2.6.14-b/drivers/pcmcia/yenta_socket.c
--- linux-2.6.14-a/drivers/pcmcia/yenta_socket.c	2005-11-10 21:16:24.325950472 +0100
+++ linux-2.6.14-b/drivers/pcmcia/yenta_socket.c	2005-11-10 21:32:39.954632368 +0100
@@ -54,7 +54,7 @@
 
 static unsigned int override_bios;
 module_param(override_bios, uint, 0000);
-MODULE_PARM_DESC (override_bios, "yenta ignore bios resource allocation");
+MODULE_PARM_DESC(override_bios, "yenta ignore bios resource allocation");
 
 /*
  * Generate easy-to-use ways of reading a cardbus sockets
diff -Naur linux-2.6.14-a/drivers/s390/char/vmlogrdr.c linux-2.6.14-b/drivers/s390/char/vmlogrdr.c
--- linux-2.6.14-a/drivers/s390/char/vmlogrdr.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/s390/char/vmlogrdr.c	2005-11-10 21:32:40.053617320 +0100
@@ -32,7 +32,7 @@
 MODULE_AUTHOR
 	("(C) 2004 IBM Corporation by Xenia Tkatschow (xenia@us.ibm.com)\n"
 	 "                            Stefan Weinhuber (wein@de.ibm.com)");
-MODULE_DESCRIPTION ("Character device driver for reading z/VM "
+MODULE_DESCRIPTION("Character device driver for reading z/VM "
 		    "system service records.");
 MODULE_LICENSE("GPL");
 
diff -Naur linux-2.6.14-a/drivers/s390/net/netiucv.c linux-2.6.14-b/drivers/s390/net/netiucv.c
--- linux-2.6.14-a/drivers/s390/net/netiucv.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/s390/net/netiucv.c	2005-11-10 21:32:40.172599232 +0100
@@ -66,7 +66,7 @@
 
 MODULE_AUTHOR
     ("(C) 2001 IBM Corporation by Fritz Elfert (felfert@millenux.com)");
-MODULE_DESCRIPTION ("Linux for S/390 IUCV network driver");
+MODULE_DESCRIPTION("Linux for S/390 IUCV network driver");
 
 
 #define PRINTK_HEADER " iucv: "       /* for debugging */
diff -Naur linux-2.6.14-a/drivers/s390/net/smsgiucv.c linux-2.6.14-b/drivers/s390/net/smsgiucv.c
--- linux-2.6.14-a/drivers/s390/net/smsgiucv.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/s390/net/smsgiucv.c	2005-11-10 21:32:40.165600296 +0100
@@ -37,7 +37,7 @@
 
 MODULE_AUTHOR
    ("(C) 2003 IBM Corporation by Martin Schwidefsky (schwidefsky@de.ibm.com)");
-MODULE_DESCRIPTION ("Linux for S/390 IUCV special message driver");
+MODULE_DESCRIPTION("Linux for S/390 IUCV special message driver");
 
 static iucv_handle_t smsg_handle;
 static unsigned short smsg_pathid;
diff -Naur linux-2.6.14-a/drivers/scsi/3w-9xxx.c linux-2.6.14-b/drivers/scsi/3w-9xxx.c
--- linux-2.6.14-a/drivers/scsi/3w-9xxx.c	2005-11-10 21:16:24.394939984 +0100
+++ linux-2.6.14-b/drivers/scsi/3w-9xxx.c	2005-11-10 21:32:40.486551504 +0100
@@ -90,8 +90,8 @@
 extern struct timezone sys_tz;
 
 /* Module parameters */
-MODULE_AUTHOR ("AMCC");
-MODULE_DESCRIPTION ("3ware 9000 Storage Controller Linux Driver");
+MODULE_AUTHOR("AMCC");
+MODULE_DESCRIPTION("3ware 9000 Storage Controller Linux Driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(TW_DRIVER_VERSION);
 
diff -Naur linux-2.6.14-a/drivers/scsi/megaraid.c linux-2.6.14-b/drivers/scsi/megaraid.c
--- linux-2.6.14-a/drivers/scsi/megaraid.c	2005-11-10 21:16:24.508922656 +0100
+++ linux-2.6.14-b/drivers/scsi/megaraid.c	2005-11-10 21:32:40.358570960 +0100
@@ -53,9 +53,9 @@
 
 #define MEGARAID_MODULE_VERSION "2.00.3"
 
-MODULE_AUTHOR ("LSI Logic Corporation");
-MODULE_DESCRIPTION ("LSI Logic MegaRAID driver");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("LSI Logic Corporation");
+MODULE_DESCRIPTION("LSI Logic MegaRAID driver");
+MODULE_LICENSE("GPL");
 MODULE_VERSION(MEGARAID_MODULE_VERSION);
 
 static unsigned int max_cmd_per_lun = DEF_CMD_PER_LUN;
diff -Naur linux-2.6.14-a/drivers/serial/serial_lh7a40x.c linux-2.6.14-b/drivers/serial/serial_lh7a40x.c
--- linux-2.6.14-a/drivers/serial/serial_lh7a40x.c	2005-11-10 21:16:24.623905176 +0100
+++ linux-2.6.14-b/drivers/serial/serial_lh7a40x.c	2005-11-10 21:32:41.191444344 +0100
@@ -694,6 +694,6 @@
 module_init (lh7a40xuart_init);
 module_exit (lh7a40xuart_exit);
 
-MODULE_AUTHOR ("Marc Singer");
-MODULE_DESCRIPTION ("Sharp LH7A40X serial port driver");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Marc Singer");
+MODULE_DESCRIPTION("Sharp LH7A40X serial port driver");
+MODULE_LICENSE("GPL");
diff -Naur linux-2.6.14-a/drivers/serial/v850e_uart.c linux-2.6.14-b/drivers/serial/v850e_uart.c
--- linux-2.6.14-a/drivers/serial/v850e_uart.c	2005-11-10 21:16:24.631903960 +0100
+++ linux-2.6.14-b/drivers/serial/v850e_uart.c	2005-11-10 21:32:41.170447536 +0100
@@ -544,6 +544,6 @@
 module_init (v850e_uart_init);
 module_exit (v850e_uart_exit);
 
-MODULE_AUTHOR ("Miles Bader");
-MODULE_DESCRIPTION ("NEC " V850E_UART_CHIP_NAME " on-chip UART");
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR("Miles Bader");
+MODULE_DESCRIPTION("NEC " V850E_UART_CHIP_NAME " on-chip UART");
+MODULE_LICENSE("GPL");
diff -Naur linux-2.6.14-a/drivers/usb/core/devio.c linux-2.6.14-b/drivers/usb/core/devio.c
--- linux-2.6.14-a/drivers/usb/core/devio.c	2005-11-10 21:16:24.646901680 +0100
+++ linux-2.6.14-b/drivers/usb/core/devio.c	2005-11-10 21:32:41.371416984 +0100
@@ -71,7 +71,7 @@
 
 static int usbfs_snoop = 0;
 module_param (usbfs_snoop, bool, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC (usbfs_snoop, "true to log all usbfs traffic");
+MODULE_PARM_DESC(usbfs_snoop, "true to log all usbfs traffic");
 
 #define snoop(dev, format, arg...)				\
 	do {							\
diff -Naur linux-2.6.14-a/drivers/usb/core/hub.c linux-2.6.14-b/drivers/usb/core/hub.c
--- linux-2.6.14-a/drivers/usb/core/hub.c	2005-11-10 21:16:24.651900920 +0100
+++ linux-2.6.14-b/drivers/usb/core/hub.c	2005-11-10 21:32:41.364418048 +0100
@@ -53,7 +53,7 @@
 /* cycle leds on hubs that aren't blinking for attention */
 static int blinkenlights = 0;
 module_param (blinkenlights, bool, S_IRUGO);
-MODULE_PARM_DESC (blinkenlights, "true to cycle leds on hubs");
+MODULE_PARM_DESC(blinkenlights, "true to cycle leds on hubs");
 
 /*
  * As of 2.6.10 we introduce a new USB device initialization scheme which
diff -Naur linux-2.6.14-a/drivers/usb/gadget/dummy_hcd.c linux-2.6.14-b/drivers/usb/gadget/dummy_hcd.c
--- linux-2.6.14-a/drivers/usb/gadget/dummy_hcd.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/usb/gadget/dummy_hcd.c	2005-11-10 21:32:41.437406952 +0100
@@ -72,9 +72,9 @@
 
 static const char	gadget_name [] = "dummy_udc";
 
-MODULE_DESCRIPTION (DRIVER_DESC);
-MODULE_AUTHOR ("David Brownell");
-MODULE_LICENSE ("GPL");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("David Brownell");
+MODULE_LICENSE("GPL");
 
 /*-------------------------------------------------------------------------*/
 
diff -Naur linux-2.6.14-a/drivers/usb/gadget/ether.c linux-2.6.14-b/drivers/usb/gadget/ether.c
--- linux-2.6.14-a/drivers/usb/gadget/ether.c	2005-11-10 21:16:24.658899856 +0100
+++ linux-2.6.14-b/drivers/usb/gadget/ether.c	2005-11-10 21:32:41.406411664 +0100
@@ -2539,9 +2539,9 @@
 	},
 };
 
-MODULE_DESCRIPTION (DRIVER_DESC);
-MODULE_AUTHOR ("David Brownell, Benedikt Spanger");
-MODULE_LICENSE ("GPL");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("David Brownell, Benedikt Spanger");
+MODULE_LICENSE("GPL");
 
 
 static int __init init (void)
diff -Naur linux-2.6.14-a/drivers/usb/gadget/inode.c linux-2.6.14-b/drivers/usb/gadget/inode.c
--- linux-2.6.14-a/drivers/usb/gadget/inode.c	2005-11-10 21:16:24.663899096 +0100
+++ linux-2.6.14-b/drivers/usb/gadget/inode.c	2005-11-10 21:32:41.393413640 +0100
@@ -76,9 +76,9 @@
 static const char driver_desc [] = DRIVER_DESC;
 static const char shortname [] = "gadgetfs";
 
-MODULE_DESCRIPTION (DRIVER_DESC);
-MODULE_AUTHOR ("David Brownell");
-MODULE_LICENSE ("GPL");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("David Brownell");
+MODULE_LICENSE("GPL");
 
 
 /*----------------------------------------------------------------------*/
diff -Naur linux-2.6.14-a/drivers/usb/gadget/net2280.c linux-2.6.14-b/drivers/usb/gadget/net2280.c
--- linux-2.6.14-a/drivers/usb/gadget/net2280.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/usb/gadget/net2280.c	2005-11-10 21:32:41.423409080 +0100
@@ -2955,9 +2955,9 @@
 	/* FIXME add power management support */
 };
 
-MODULE_DESCRIPTION (DRIVER_DESC);
-MODULE_AUTHOR ("David Brownell");
-MODULE_LICENSE ("GPL");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("David Brownell");
+MODULE_LICENSE("GPL");
 
 static int __init init (void)
 {
diff -Naur linux-2.6.14-a/drivers/usb/gadget/omap_udc.c linux-2.6.14-b/drivers/usb/gadget/omap_udc.c
--- linux-2.6.14-a/drivers/usb/gadget/omap_udc.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/usb/gadget/omap_udc.c	2005-11-10 21:32:41.416410144 +0100
@@ -100,7 +100,7 @@
  * boot parameter "omap_udc:fifo_mode=42"
  */
 module_param (fifo_mode, uint, 0);
-MODULE_PARM_DESC (fifo_mode, "endpoint setup (0 == default)");
+MODULE_PARM_DESC(fifo_mode, "endpoint setup (0 == default)");
 
 #ifdef	USE_DMA
 static unsigned use_dma = 1;
@@ -109,7 +109,7 @@
  * boot parameter "omap_udc:use_dma=y"
  */
 module_param (use_dma, bool, 0);
-MODULE_PARM_DESC (use_dma, "enable/disable DMA");
+MODULE_PARM_DESC(use_dma, "enable/disable DMA");
 #else	/* !USE_DMA */
 
 /* save a bit of code */
diff -Naur linux-2.6.14-a/drivers/usb/gadget/pxa2xx_udc.c linux-2.6.14-b/drivers/usb/gadget/pxa2xx_udc.c
--- linux-2.6.14-a/drivers/usb/gadget/pxa2xx_udc.c	2005-11-10 21:16:24.664898944 +0100
+++ linux-2.6.14-b/drivers/usb/gadget/pxa2xx_udc.c	2005-11-10 21:32:41.388414400 +0100
@@ -108,7 +108,7 @@
 #ifdef	USE_DMA
 static int use_dma = 1;
 module_param(use_dma, bool, 0);
-MODULE_PARM_DESC (use_dma, "true to use dma");
+MODULE_PARM_DESC(use_dma, "true to use dma");
 
 static void dma_nodesc_handler (int dmach, void *_ep, struct pt_regs *r);
 static void kick_dma(struct pxa2xx_ep *ep, struct pxa2xx_request *req);
@@ -138,7 +138,7 @@
  */
 static ushort fifo_mode = 0;
 module_param(fifo_mode, ushort, 0);
-MODULE_PARM_DESC (fifo_mode, "pxa2xx udc fifo mode");
+MODULE_PARM_DESC(fifo_mode, "pxa2xx udc fifo mode");
 #endif
 
 /* ---------------------------------------------------------------------------
diff -Naur linux-2.6.14-a/drivers/usb/gadget/rndis.c linux-2.6.14-b/drivers/usb/gadget/rndis.c
--- linux-2.6.14-a/drivers/usb/gadget/rndis.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/usb/gadget/rndis.c	2005-11-10 21:32:41.410411056 +0100
@@ -62,7 +62,7 @@
 static int rndis_debug = 0;
 
 module_param (rndis_debug, int, 0);
-MODULE_PARM_DESC (rndis_debug, "enable debugging");
+MODULE_PARM_DESC(rndis_debug, "enable debugging");
 
 #else
 
diff -Naur linux-2.6.14-a/drivers/usb/gadget/zero.c linux-2.6.14-b/drivers/usb/gadget/zero.c
--- linux-2.6.14-a/drivers/usb/gadget/zero.c	2005-11-10 21:16:24.668898336 +0100
+++ linux-2.6.14-b/drivers/usb/gadget/zero.c	2005-11-10 21:32:41.378415920 +0100
@@ -1308,8 +1308,8 @@
 	},
 };
 
-MODULE_AUTHOR ("David Brownell");
-MODULE_LICENSE ("Dual BSD/GPL");
+MODULE_AUTHOR("David Brownell");
+MODULE_LICENSE("Dual BSD/GPL");
 
 
 static int __init init (void)
diff -Naur linux-2.6.14-a/drivers/usb/host/ehci-hcd.c linux-2.6.14-b/drivers/usb/host/ehci-hcd.c
--- linux-2.6.14-a/drivers/usb/host/ehci-hcd.c	2005-11-10 21:16:24.669898184 +0100
+++ linux-2.6.14-b/drivers/usb/host/ehci-hcd.c	2005-11-10 21:32:41.479400568 +0100
@@ -127,12 +127,12 @@
 /* Initial IRQ latency:  faster than hw default */
 static int log2_irq_thresh = 0;		// 0 to 6
 module_param (log2_irq_thresh, int, S_IRUGO);
-MODULE_PARM_DESC (log2_irq_thresh, "log2 IRQ latency, 1-64 microframes");
+MODULE_PARM_DESC(log2_irq_thresh, "log2 IRQ latency, 1-64 microframes");
 
 /* initial park setting:  slower than hw default */
 static unsigned park = 0;
 module_param (park, uint, S_IRUGO);
-MODULE_PARM_DESC (park, "park setting; 1-3 back-to-back async packets");
+MODULE_PARM_DESC(park, "park setting; 1-3 back-to-back async packets");
 
 #define	INTR_MASK (STS_IAA | STS_FATAL | STS_PCD | STS_ERR | STS_INT)
 
@@ -1251,9 +1251,9 @@
 
 #define DRIVER_INFO DRIVER_VERSION " " DRIVER_DESC
 
-MODULE_DESCRIPTION (DRIVER_INFO);
-MODULE_AUTHOR (DRIVER_AUTHOR);
-MODULE_LICENSE ("GPL");
+MODULE_DESCRIPTION(DRIVER_INFO);
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_LICENSE("GPL");
 
 static int __init init (void) 
 {
diff -Naur linux-2.6.14-a/drivers/usb/host/ohci-hcd.c linux-2.6.14-b/drivers/usb/host/ohci-hcd.c
--- linux-2.6.14-a/drivers/usb/host/ohci-hcd.c	2005-11-10 21:16:24.679896664 +0100
+++ linux-2.6.14-b/drivers/usb/host/ohci-hcd.c	2005-11-10 21:32:41.454404368 +0100
@@ -163,13 +163,13 @@
 /* Some boards misreport power switching/overcurrent */
 static int distrust_firmware = 1;
 module_param (distrust_firmware, bool, 0);
-MODULE_PARM_DESC (distrust_firmware,
+MODULE_PARM_DESC(distrust_firmware,
 	"true to distrust firmware power/overcurrent setup");
 
 /* Some boards leave IR set wrongly, since they fail BIOS/SMM handshakes */
 static int no_handshake = 0;
 module_param (no_handshake, bool, 0);
-MODULE_PARM_DESC (no_handshake, "true (not default) disables BIOS handshake");
+MODULE_PARM_DESC(no_handshake, "true (not default) disables BIOS handshake");
 
 /*-------------------------------------------------------------------------*/
 
@@ -877,9 +877,9 @@
 
 #define DRIVER_INFO DRIVER_VERSION " " DRIVER_DESC
 
-MODULE_AUTHOR (DRIVER_AUTHOR);
-MODULE_DESCRIPTION (DRIVER_INFO);
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_INFO);
+MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_PCI
 #include "ohci-pci.c"
diff -Naur linux-2.6.14-a/drivers/usb/media/dabusb.c linux-2.6.14-b/drivers/usb/media/dabusb.c
--- linux-2.6.14-a/drivers/usb/media/dabusb.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/usb/media/dabusb.c	2005-11-10 21:32:41.579385368 +0100
@@ -868,7 +868,7 @@
 MODULE_LICENSE("GPL");
 
 module_param(buffers, int, 0);
-MODULE_PARM_DESC (buffers, "Number of buffers (default=256)");
+MODULE_PARM_DESC(buffers, "Number of buffers (default=256)");
 
 module_init (dabusb_init);
 module_exit (dabusb_cleanup);
diff -Naur linux-2.6.14-a/drivers/usb/media/ibmcam.c linux-2.6.14-b/drivers/usb/media/ibmcam.c
--- linux-2.6.14-a/drivers/usb/media/ibmcam.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/usb/media/ibmcam.c	2005-11-10 21:32:41.576385824 +0100
@@ -158,8 +158,8 @@
 module_param(init_model3_input, int, 0);
 MODULE_PARM_DESC(init_model3_input, "Model3 input: 0=CCD 1=RCA");
 
-MODULE_AUTHOR ("Dmitri");
-MODULE_DESCRIPTION ("IBM/Xirlink C-it USB Camera Driver for Linux (c) 2000");
+MODULE_AUTHOR("Dmitri");
+MODULE_DESCRIPTION("IBM/Xirlink C-it USB Camera Driver for Linux (c) 2000");
 MODULE_LICENSE("GPL");
 
 /* Still mysterious i2c commands */
diff -Naur linux-2.6.14-a/drivers/usb/media/stv680.c linux-2.6.14-b/drivers/usb/media/stv680.c
--- linux-2.6.14-a/drivers/usb/media/stv680.c	2005-11-10 21:16:24.704892864 +0100
+++ linux-2.6.14-b/drivers/usb/media/stv680.c	2005-11-10 21:32:41.535392056 +0100
@@ -90,13 +90,13 @@
 #define DRIVER_AUTHOR "Kevin Sisson <kjsisson@bellsouth.net>"
 #define DRIVER_DESC "STV0680 USB Camera Driver"
 
-MODULE_AUTHOR (DRIVER_AUTHOR);
-MODULE_DESCRIPTION (DRIVER_DESC);
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
 module_param(debug, int, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC (debug, "Debug enabled or not");
+MODULE_PARM_DESC(debug, "Debug enabled or not");
 module_param(swapRGB_on, int, 0);
-MODULE_PARM_DESC (swapRGB_on, "Red/blue swap: 1=always, 0=auto, -1=never");
+MODULE_PARM_DESC(swapRGB_on, "Red/blue swap: 1=always, 0=auto, -1=never");
 module_param(video_nr, int, 0);
 
 /********************************************************************
diff -Naur linux-2.6.14-a/drivers/usb/misc/auerswald.c linux-2.6.14-b/drivers/usb/misc/auerswald.c
--- linux-2.6.14-a/drivers/usb/misc/auerswald.c	2005-11-10 21:16:24.708892256 +0100
+++ linux-2.6.14-b/drivers/usb/misc/auerswald.c	2005-11-10 21:32:41.601382024 +0100
@@ -2145,9 +2145,9 @@
 /* --------------------------------------------------------------------- */
 /* Linux device driver module description                                */
 
-MODULE_AUTHOR (DRIVER_AUTHOR);
-MODULE_DESCRIPTION (DRIVER_DESC);
-MODULE_LICENSE ("GPL");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
 
 module_init (auerswald_init);
 module_exit (auerswald_cleanup);
diff -Naur linux-2.6.14-a/drivers/usb/misc/usbtest.c linux-2.6.14-b/drivers/usb/misc/usbtest.c
--- linux-2.6.14-a/drivers/usb/misc/usbtest.c	2005-11-10 21:16:24.721890280 +0100
+++ linux-2.6.14-b/drivers/usb/misc/usbtest.c	2005-11-10 21:32:41.595382936 +0100
@@ -239,7 +239,7 @@
 
 static unsigned pattern = 0;
 module_param (pattern, uint, S_IRUGO);
-// MODULE_PARM_DESC (pattern, "i/o pattern (0 == zeroes)");
+// MODULE_PARM_DESC(pattern, "i/o pattern (0 == zeroes)");
 
 static inline void simple_fill_buf (struct urb *urb)
 {
@@ -461,7 +461,7 @@
 
 static unsigned realworld = 1;
 module_param (realworld, uint, 0);
-MODULE_PARM_DESC (realworld, "clear to demand stricter spec compliance");
+MODULE_PARM_DESC(realworld, "clear to demand stricter spec compliance");
 
 static int get_altsetting (struct usbtest_dev *dev)
 {
@@ -1833,16 +1833,16 @@
 
 static unsigned force_interrupt = 0;
 module_param (force_interrupt, uint, 0);
-MODULE_PARM_DESC (force_interrupt, "0 = test default; else interrupt");
+MODULE_PARM_DESC(force_interrupt, "0 = test default; else interrupt");
 
 #ifdef	GENERIC
 static unsigned short vendor;
 module_param(vendor, ushort, 0);
-MODULE_PARM_DESC (vendor, "vendor code (from usb-if)");
+MODULE_PARM_DESC(vendor, "vendor code (from usb-if)");
 
 static unsigned short product;
 module_param(product, ushort, 0);
-MODULE_PARM_DESC (product, "product code (from vendor)");
+MODULE_PARM_DESC(product, "product code (from vendor)");
 #endif
 
 static int
@@ -2177,6 +2177,6 @@
 }
 module_exit (usbtest_exit);
 
-MODULE_DESCRIPTION ("USB Core/HCD Testing Driver");
-MODULE_LICENSE ("GPL");
+MODULE_DESCRIPTION("USB Core/HCD Testing Driver");
+MODULE_LICENSE("GPL");
 
diff -Naur linux-2.6.14-a/drivers/usb/net/pegasus.c linux-2.6.14-b/drivers/usb/net/pegasus.c
--- linux-2.6.14-a/drivers/usb/net/pegasus.c	2005-11-10 21:16:24.735888152 +0100
+++ linux-2.6.14-b/drivers/usb/net/pegasus.c	2005-11-10 21:32:41.639376248 +0100
@@ -87,7 +87,7 @@
 /* use ethtool to change the level for any given device */
 static int msg_level = -1;
 module_param (msg_level, int, 0);
-MODULE_PARM_DESC (msg_level, "Override default message level");
+MODULE_PARM_DESC(msg_level, "Override default message level");
 
 MODULE_DEVICE_TABLE(usb, pegasus_ids);
 
diff -Naur linux-2.6.14-a/drivers/usb/net/usbnet.c linux-2.6.14-b/drivers/usb/net/usbnet.c
--- linux-2.6.14-a/drivers/usb/net/usbnet.c	2005-11-10 21:16:24.743886936 +0100
+++ linux-2.6.14-b/drivers/usb/net/usbnet.c	2005-11-10 21:32:41.633377160 +0100
@@ -88,7 +88,7 @@
 /* use ethtool to change the level for any given device */
 static int msg_level = -1;
 module_param (msg_level, int, 0);
-MODULE_PARM_DESC (msg_level, "Override default message level");
+MODULE_PARM_DESC(msg_level, "Override default message level");
 
 /*-------------------------------------------------------------------------*/
 
diff -Naur linux-2.6.14-a/drivers/usb/serial/safe_serial.c linux-2.6.14-b/drivers/usb/serial/safe_serial.c
--- linux-2.6.14-a/drivers/usb/serial/safe_serial.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/drivers/usb/serial/safe_serial.c	2005-11-10 21:32:41.684369408 +0100
@@ -87,8 +87,8 @@
 #define DRIVER_AUTHOR "sl@lineo.com, tbr@lineo.com"
 #define DRIVER_DESC "USB Safe Encapsulated Serial"
 
-MODULE_AUTHOR (DRIVER_AUTHOR);
-MODULE_DESCRIPTION (DRIVER_DESC);
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #if defined(CONFIG_USBD_SAFE_SERIAL_VENDOR) && !defined(CONFIG_USBD_SAFE_SERIAL_PRODUCT)
diff -Naur linux-2.6.14-a/sound/oss/wavfront.c linux-2.6.14-b/sound/oss/wavfront.c
--- linux-2.6.14-a/sound/oss/wavfront.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-b/sound/oss/wavfront.c	2005-11-10 21:32:44.626922072 +0100
@@ -3494,7 +3494,7 @@
 static int irq = -1;
 
 MODULE_AUTHOR      ("Paul Barton-Davis <pbd@op.net>");
-MODULE_DESCRIPTION ("Turtle Beach WaveFront Linux Driver");
+MODULE_DESCRIPTION("Turtle Beach WaveFront Linux Driver");
 MODULE_LICENSE("GPL");
 module_param       (io, int, 0);
 module_param       (irq, int, 0);

--=-OgMKXyCTfWEKqGaPOjKG--


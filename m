Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVBALHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVBALHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 06:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVBALHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 06:07:10 -0500
Received: from [81.187.167.50] ([81.187.167.50]:26844 "EHLO kylie.comodo.net")
	by vger.kernel.org with ESMTP id S261986AbVBALG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 06:06:58 -0500
Message-ID: <41FF6360.9010506@comodo.com>
Date: Tue, 01 Feb 2005 16:39:20 +0530
From: Sabarinathan <sabarinathan@comodo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Problem in Kernel-2.6.11-rc2 Compilation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Comodo-ClamAV-Virus-Check-By: kylie.comodo.net - PASSED!
X-Comodo-ClamAV-Virus-Version: ClamAV 0.80/694/Sun Jan 30 21:15:10 2005
X-Comodo-F-Prot-Virus-Check-By: kylie.comodo.net - PASSED!
X-Comodo-F-Prot-Virus-Program: F-PROT ANTIVIRUS Program version: 4.5.3 Engine version: 3.16.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Now i am using kernel-2.6.10 in my fedora core 2 machine, i have 
downloaded the kernel-2.6.11-rc2 then created the default config file 
and i run the make command , it compiled all the kernel modules then i 
run the make modules , it shows some few lines and terminate the process 
so i am not able to make the kernel modules.After i switch over the 
kernel 2.6.5-1.358 that is default kernel in fedora core 2, this time i 
am able to make and install the kernel modules without any problem, 
anybody tell me what is the problem in that place


 # make modules
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CC [M]  drivers/acpi/video.o
  CC [M]  drivers/acpi/ibm_acpi.o
  CC [M]  drivers/base/firmware_class.o
  CC [M]  drivers/char/agp/intel-mch-agp.o
  CC [M]  drivers/net/dummy.o
  CC [M]  drivers/net/s2io.o
  CC [M]  drivers/scsi/dpt_i2o.o
drivers/scsi/dpt_i2o.c: In function `adpt_isr':
drivers/scsi/dpt_i2o.c:2031: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2032: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2043: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2044: warning: passing arg 2 of `writel' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2047: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2049: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2056: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2063: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2070: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c: In function `adpt_i2o_to_scsi':
drivers/scsi/dpt_i2o.c:2240: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2244: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2249: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2260: warning: passing arg 1 of `readl' makes 
pointer from integer without a cast
  CC [M]  drivers/scsi/ipr.o
  CC [M]  drivers/scsi/sata_sis.o
  CC [M]  drivers/scsi/sata_sx4.o
  CC [M]  drivers/usb/input/touchkitusb.o
  CC [M]  drivers/usb/misc/cytherm.o
  CC [M]  drivers/usb/misc/phidgetservo.o
  CC [M]  net/ipv4/netfilter/iptable_raw.o
  CC [M]  net/ipv4/netfilter/ipt_NOTRACK.o
  CC [M]  lib/libcrc32c.o
  Building modules, stage 2.
  MODPOST
  CC      drivers/acpi/ibm_acpi.mod.o
  LD [M]  drivers/acpi/ibm_acpi.ko
  CC      drivers/acpi/video.mod.o
  LD [M]  drivers/acpi/video.ko
  CC      drivers/base/firmware_class.mod.o
  LD [M]  drivers/base/firmware_class.ko
  CC      drivers/char/agp/intel-mch-agp.mod.o
  LD [M]  drivers/char/agp/intel-mch-agp.ko
  CC      drivers/net/dummy.mod.o
  LD [M]  drivers/net/dummy.ko
  CC      drivers/net/s2io.mod.o
  LD [M]  drivers/net/s2io.ko
  CC      drivers/scsi/dpt_i2o.mod.o
  LD [M]  drivers/scsi/dpt_i2o.ko
  CC      drivers/scsi/ipr.mod.o
  LD [M]  drivers/scsi/ipr.ko
  CC      drivers/scsi/sata_sis.mod.o
  LD [M]  drivers/scsi/sata_sis.ko
  CC      drivers/scsi/sata_sx4.mod.o
  LD [M]  drivers/scsi/sata_sx4.ko
  CC      drivers/usb/input/touchkitusb.mod.o
  LD [M]  drivers/usb/input/touchkitusb.ko
  CC      drivers/usb/misc/cytherm.mod.o
  LD [M]  drivers/usb/misc/cytherm.ko
  CC      drivers/usb/misc/phidgetservo.mod.o
  LD [M]  drivers/usb/misc/phidgetservo.ko
  CC      lib/libcrc32c.mod.o
  LD [M]  lib/libcrc32c.ko
  CC      net/ipv4/netfilter/ipt_NOTRACK.mod.o
  LD [M]  net/ipv4/netfilter/ipt_NOTRACK.ko
  CC      net/ipv4/netfilter/iptable_raw.mod.o
  LD [M]  net/ipv4/netfilter/iptable_raw.ko
#

-- 
Regards
Sabarinathan.A



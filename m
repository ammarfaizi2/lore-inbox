Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271025AbTHBHZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 03:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271032AbTHBHZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 03:25:25 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:58763 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S271025AbTHBHZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 03:25:22 -0400
Message-Id: <5.1.0.14.2.20030802092320.00a80168@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 02 Aug 2003 09:26:45 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: Linux 2.4.22-pre10
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: Sx4jy0ZcgeTY+tZLIkGLYTiWn2lYUd4F8wVE1vUdrk0R3cvqu+cVQa
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well ignoring the almost 1000 occurrences of __FUNCTION__ deprecated and
unused variables, we are left with this:


system.c: In function `acpi_power_off':
system.c:93: warning: implicit declaration of function `acpi_suspend'
system.c: At top level:
system.c:303: warning: type mismatch with previous implicit declaration
system.c:93: warning: previous implicit declaration of `acpi_suspend'
system.c:303: warning: `acpi_suspend' was previously implicitly declared to 
retu
rn `int'
siimage.c: In function `pdev_is_sata':
siimage.c:65: warning: control reaches end of non-void function
generic.h:151: warning: `unknown_chipset' defined but not used
tipar.c:76:1: warning: "minor" redefined
In file included from /var/tmp/linux-2.4.21/include/linux/fs.h:16,
                  from /var/tmp/linux-2.4.21/include/linux/capability.h:17,
                  from /var/tmp/linux-2.4.21/include/linux/binfmts.h:5,
                  from /var/tmp/linux-2.4.21/include/linux/sched.h:9,
                  from tipar.c:49:
/var/tmp/linux-2.4.21/include/linux/kdev_t.h:81:1: warning: this is the 
location
  of the previous definition
applicom.c:268:2: warning: #warning "LEAK"
applicom.c:532:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"
i2o_pci.c:393:1: warning: no newline at end of file
cfi_cmdset_0020.c: In function `do_write_buffer':
cfi_cmdset_0020.c:491: warning: unsigned int format, different type arg (arg 3)
cfi_cmdset_0020.c: In function `do_erase_oneblock':
cfi_cmdset_0020.c:851: warning: unsigned int format, different type arg (arg 3)
cfi_cmdset_0020.c: In function `do_lock_oneblock':
cfi_cmdset_0020.c:1137: warning: unsigned int format, different type arg 
(arg 3)
cfi_cmdset_0020.c: In function `do_unlock_oneblock':
cfi_cmdset_0020.c:1286: warning: unsigned int format, different type arg 
(arg 3)
cfi_cmdset_0001.c: In function `do_write_oneword':
cfi_cmdset_0001.c:826: warning: unsigned int format, different type arg (arg 2)
cfi_cmdset_0001.c: In function `do_write_buffer':
cfi_cmdset_0001.c:1135: warning: unsigned int format, different type arg 
(arg 2)
cfi_cmdset_0001.c:1165: warning: unsigned int format, different type arg 
(arg 2)
ma600.c:51:22: warning: extra tokens at end of #undef directive
crc32.c:91: warning: static declaration for `fn_calc_memory_chunk_crc32' 
follows
  non-static
cardbus.c: In function `cb_scan_slot':
cardbus.c:240: warning: implicit declaration of function `pci_scan_device'
cardbus.c:240: warning: assignment makes pointer from integer without a cast
cardbus.c:226: warning: unused variable `bus'
cardbus.c: In function `program_bridge':
cardbus.c:405: warning: control reaches end of non-void function
In file included from yenta.c:837:
ti113x.h: In function `ti_intctl':
ti113x.h:182: warning: suggest parentheses around comparison in operand of &
qlogicfas.c: In function `qlogicfas_detect':
qlogicfas.c:650: warning: passing arg 1 of `scsi_unregister' from 
incompatible p
ointer type
cpqfcTSi2c.c:62: warning: `i2c_delay' declared `static' but never defined
../qlogicfas.c: In function `qlogicfas_detect':
../qlogicfas.c:650: warning: passing arg 1 of `scsi_unregister' from 
incompatibl
e pointer type
main.c:236:2: warning: #warning "Initialisation order race. Must register after
usable"
hid-core.c: In function `hid_input_report':
hid-core.c:879: warning: implicit declaration of function `hiddev_report_event'
kaweth.c: In function `kaweth_start_xmit':
kaweth.c:738: warning: assignment from incompatible pointer type
pm3fb.c: In function `cleanup_module':
pm3fb.c:3835: warning: passing arg 2 of `__release_region' makes integer 
from po
inter without a cast
pm3fb.c:3838: warning: passing arg 2 of `__release_region' makes integer 
from po
inter without a cast
matroxfb_g450.c: In function `g450_compute_bwlevel':
matroxfb_g450.c:134: warning: duplicate `const'
matroxfb_g450.c:135: warning: duplicate `const'
matroxfb_maven.c: In function `maven_compute_bwlevel':
matroxfb_maven.c:359: warning: duplicate `const'
matroxfb_maven.c:360: warning: duplicate `const'
fs.c: In function `_ntfs_clear_inode':
fs.c:852: warning: deprecated use of label at end of compound statement
sock.c:64: warning: static declaration for `sockfd_lookup' follows non-static
sock.c:56: warning: static declaration for `sockfd_lookup' follows non-static
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.22-pre10; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-pre10/kernel/drivers/net/w
an/comx.o
depmod:         proc_get_inode

Margit 


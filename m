Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272800AbTG3IL5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272805AbTG3IL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:11:57 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:64466 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S272800AbTG3ILz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:11:55 -0400
Message-Id: <5.1.0.14.2.20030730101141.00a891a0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 30 Jul 2003 10:13:12 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: Linux 2.4.22-pre9
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: TzfPO2ZDoetkK4MkHDUM5yeXsSkzsyCI+lOg4krSR-BSS8tsmzDw0E
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following warnings/erors excerpts maybe cause for concern ?

siimage.c: In function `pdev_is_sata':
siimage.c:65: warning: control reaches end of non-void function

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
qlogicfas.c:650: warning: passing arg 1 of `scsi_unregister' from incompatible
pointer type

cpqfcTSi2c.c:62: warning: `i2c_delay' declared `static' but never defined

../qlogicfas.c: In function `qlogicfas_detect':
../qlogicfas.c:650: warning: passing arg 1 of `scsi_unregister' from
  incompatible pointer type

pm3fb.c: In function `cleanup_module':
pm3fb.c:3835: warning: passing arg 2 of `__release_region' makes integer
from pointer without a cast

matroxfb_g450.c:134: warning: duplicate `const'
matroxfb_g450.c:135: warning: duplicate `const'

matroxfb_maven.c:359: warning: duplicate `const'
matroxfb_maven.c:360: warning: duplicate `const'

fs.c:852: warning: deprecated use of label at end of compound statement

sock.c:64: warning: static declaration for `sockfd_lookup' follows non-static
sock.c:56: warning: static declaration for `sockfd_lookup' follows non-static

And of course :-)
depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-pre9/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode

Margit 


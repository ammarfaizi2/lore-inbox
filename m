Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282005AbRKZSZL>; Mon, 26 Nov 2001 13:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282011AbRKZSX4>; Mon, 26 Nov 2001 13:23:56 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:21186 "EHLO
	c0mailgw08.prontomail.com") by vger.kernel.org with ESMTP
	id <S282008AbRKZSXI>; Mon, 26 Nov 2001 13:23:08 -0500
Message-ID: <3C02886D.8DB9D1B5@starband.net>
Date: Mon, 26 Nov 2001 13:22:37 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 Bug (PPC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the actual SCSI driver I need for the 7200/90.

cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring    -c -o 53c7,8xx.o 53c7,8xx.c
53c7,8xx.c: In function `ncr_pci_init':
53c7,8xx.c:1436: `is_prep' undeclared (first use in this function)
53c7,8xx.c:1436: (Each undeclared identifier is reported only once
53c7,8xx.c:1436: for each function it appears in.)
53c7,8xx.c:1440: warning: unsigned int format, long unsigned int arg
(arg 3)
53c7,8xx.c:1443: structure has no member named `base_address'
53c7,8xx.c: In function `NCR53c8x0_init_fixup':
53c7,8xx.c:1796: warning: assignment from incompatible pointer type
53c7,8xx.c: In function `NCR53c8xx_dsa_fixup':
53c7,8xx.c:2018: warning: assignment from incompatible pointer type
53c7,8xx.c:2065: warning: assignment from incompatible pointer type
53c7,8xx.c: In function `print_queues':
53c7,8xx.c:5932: warning: initialization makes integer from pointer
without a cast
53c7,8xx.c:5932: warning: passing arg 1 of `__fswab32' makes integer
from pointer without a cast
make[3]: *** [53c7,8xx.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2


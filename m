Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTBJGun>; Mon, 10 Feb 2003 01:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbTBJGun>; Mon, 10 Feb 2003 01:50:43 -0500
Received: from franka.aracnet.com ([216.99.193.44]:46549 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263321AbTBJGum>; Mon, 10 Feb 2003 01:50:42 -0500
Date: Sun, 09 Feb 2003 23:00:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 330] New: compile error ( imm.c )
Message-ID: <47530000.1044860420@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=330

           Summary: compile error ( imm.c )
    Kernel Version: 2.5.59-bk3
            Status: NEW
          Severity: low
             Owner: andmike@us.ibm.com
         Submitter: corporal_pisang@counter-strike.com.my


Compile error.

  gcc -Wp,-MD,drivers/scsi/.imm.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
-DKBUILD_BASENAME=imm -DKBUILD_MODNAME=imm -c -o drivers/scsi/.tmp_imm.o
drivers/scsi/imm.c
drivers/scsi/imm.c: In function `imm_send_command':
drivers/scsi/imm.c:736: structure has no member named `host'
drivers/scsi/imm.c: In function `imm_completion':
drivers/scsi/imm.c:761: structure has no member named `host'
drivers/scsi/imm.c: In function `imm_command':
drivers/scsi/imm.c:848: structure has no member named `host'
drivers/scsi/imm.c:870: structure has no member named `host'
drivers/scsi/imm.c: In function `imm_interrupt':
drivers/scsi/imm.c:886: structure has no member named `host'
drivers/scsi/imm.c:933: structure has no member named `host'
drivers/scsi/imm.c:935: structure has no member named `host'
drivers/scsi/imm.c: In function `imm_engine':
drivers/scsi/imm.c:946: structure has no member named `host'
drivers/scsi/imm.c:975: structure has no member named `target'
drivers/scsi/imm.c: In function `imm_queuecommand':
drivers/scsi/imm.c:1085: structure has no member named `host'
drivers/scsi/imm.c: In function `imm_abort':
drivers/scsi/imm.c:1128: structure has no member named `host'
drivers/scsi/imm.c: In function `imm_reset':
drivers/scsi/imm.c:1160: structure has no member named `host'
make[2]: *** [drivers/scsi/imm.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2



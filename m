Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTFXPeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTFXPbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:31:43 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:1673
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S262710AbTFXPaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:30:01 -0400
From: "jds" <jds@soltis.cc>
To: linux-kernel@vger.kernel.org
Subject: Problems when compile kernel 2.5.73-mm1
Date: Tue, 24 Jun 2003 09:18:46 -0600
Message-Id: <20030624151611.M70129@soltis.cc>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 180.175.220.238 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew:

   I have problems whe try the compile kernel. the messages is:

[root@toshiba linux-2.5]# make bzImage
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-i386/asm_offsets.h
  CC      init/main.o
In file included from include/linux/pagemap.h:7,
                 from include/linux/blkdev.h:10,
                 from include/linux/blk.h:2,
                 from init/main.c:26:
include/linux/mm.h: In function `lowmem_page_address':
include/linux/mm.h:344: `__PAGE_OFFSET' undeclared (first use in this function)
include/linux/mm.h:344: (Each undeclared identifier is reported only once
include/linux/mm.h:344: for each function it appears in.)
In file included from include/linux/bio.h:28,
                 from include/linux/blkdev.h:14,
                 from include/linux/blk.h:2,
                 from init/main.c:26:
include/asm/io.h: In function `virt_to_phys':
include/asm/io.h:74: `__PAGE_OFFSET' undeclared (first use in this function)
include/asm/io.h: In function `phys_to_virt':
include/asm/io.h:92: `__PAGE_OFFSET' undeclared (first use in this function)
include/asm/io.h: In function `isa_check_signature':
include/asm/io.h:245: `__PAGE_OFFSET' undeclared (first use in this function)
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2
[root@toshiba linux-2.5]#

Helpme please 

Regards

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270489AbTHCBdm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 21:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270499AbTHCBdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 21:33:42 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:25509 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S270489AbTHCBdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 21:33:41 -0400
From: Miles Lane <miles.lane@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-bk25 -- agpgart_be.c:95:2: #error "Please define flush_cache."
Date: Sat, 2 Aug 2003 18:33:30 -0700
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308021833.30237.miles.lane@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[4]: Entering directory `/home/usr/src/linux-2.4.21/drivers/char/agp'
gcc -D__KERNEL__ -I/home/usr/src/linux-2.4.21/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -I/home/usr/src/linux-2.4.21/arch/ppc -fsigned-char 
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   
-nostdinc -iwithprefix include -DKBUILD_BASENAME=agpgart_be  -DEXPORT_SYMTAB 
-c agpgart_be.c
agpgart_be.c:95:2: #error "Please define flush_cache."
agpgart_be.c:401: warning: `agp_generic_agp_enable' defined but not used
agpgart_be.c:494: warning: `agp_generic_create_gatt_table' defined but not 
used
agpgart_be.c:618: warning: `agp_generic_suspend' defined but not used
agpgart_be.c:623: warning: `agp_generic_resume' defined but not used
agpgart_be.c:628: warning: `agp_generic_free_gatt_table' defined but not used
agpgart_be.c:680: warning: `agp_generic_insert_memory' defined but not used
agpgart_be.c:742: warning: `agp_generic_remove_memory' defined but not used
agpgart_be.c:759: warning: `agp_generic_alloc_by_type' defined but not used
agpgart_be.c:764: warning: `agp_generic_free_by_type' defined but not used
agpgart_be.c:782: warning: `agp_generic_alloc_page' defined but not used
agpgart_be.c:802: warning: `agp_generic_destroy_page' defined but not used
make[4]: *** [agpgart_be.o] Error 1

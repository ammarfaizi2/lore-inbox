Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbUDFBWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 21:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbUDFBWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 21:22:04 -0400
Received: from muss.CIS.mcmaster.ca ([130.113.64.9]:53419 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S263578AbUDFBWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 21:22:01 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Warnings in 2.6.5-mm1 kernel/sched.c
Date: Mon, 5 Apr 2004 21:22:08 -0400
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404052122.08698.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      kernel/sched.o
In file included from include/asm/tlb.h:18,
                 from kernel/sched.c:29:
include/asm-generic/tlb.h: In function `tlb_flush_mmu':
include/asm-generic/tlb.h:76: warning: implicit declaration of function 
`release
_pages'
include/asm-generic/tlb.h: In function `tlb_remove_page':
include/asm-generic/tlb.h:116: warning: implicit declaration of function 
`page_c
ache_release'
In file included from include/linux/blkdev.h:10,
                 from kernel/sched.c:36:
include/linux/pagemap.h: At top level:
include/linux/pagemap.h:50: warning: type mismatch with previous implicit 
declar
ation
include/asm-generic/tlb.h:76: warning: previous implicit declaration of 
`release
_pages'
include/linux/pagemap.h:50: warning: `release_pages' was previously implicitly 
d
eclared to return `int'

-- 
Gabriel Devenyi
devenyga@mcmaster.ca

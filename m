Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUC0QRy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 11:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUC0QRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 11:17:54 -0500
Received: from muss.CIS.mcmaster.ca ([130.113.64.9]:48574 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261803AbUC0QRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 11:17:52 -0500
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Warnings in linux-2.6.5-rc2-mm3
Date: Sat, 27 Mar 2004 11:17:53 -0500
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403271117.53029.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from include/asm/tlb.h:18,
                 from kernel/sched.c:28:
include/asm-generic/tlb.h: In function `tlb_flush_mmu':
include/asm-generic/tlb.h:74: warning: implicit declaration of function 
`release_pages'
include/asm-generic/tlb.h: In function `tlb_remove_page':
include/asm-generic/tlb.h:107: warning: implicit declaration of function 
`page_cache_release'
In file included from include/linux/blkdev.h:10,
                 from kernel/sched.c:35:
include/linux/pagemap.h: At top level:
include/linux/pagemap.h:50: warning: type mismatch with previous implicit 
declaration
include/asm-generic/tlb.h:74: warning: previous implicit declaration of 
`release_pages'
include/linux/pagemap.h:50: warning: `release_pages' was previously implicitly 
declared to return `int'

Please CC me with any further discussion
-- 
Gabriel Devenyi
devenyga@mcmaster.ca

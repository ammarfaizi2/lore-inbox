Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261480AbSIZUUL>; Thu, 26 Sep 2002 16:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261484AbSIZUUL>; Thu, 26 Sep 2002 16:20:11 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:58891 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261480AbSIZUUK>; Thu, 26 Sep 2002 16:20:10 -0400
Date: Thu, 26 Sep 2002 22:25:25 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: sparc32 sunrpc.o
Message-ID: <20020926202525.GO19015@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.4.20-pre2 or 3, sunrpc.o has had this problem on sparc32:

depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre8/kernel/net/sunrpc/sunrpc.o
depmod:         ___illegal_use_of_BTFIXUP_SETHI_in_module
depmod:         ___f_set_pte
depmod:         fix_kmap_begin
depmod:         ___f_flush_cache_all
depmod:         ___f_pte_clear
depmod:         ___f_mk_pte
depmod:         ___f_flush_tlb_all

I'd like to fix the breakage but have no idea where to start
looking.  Any hints will be thoroughly appreciated.

T.

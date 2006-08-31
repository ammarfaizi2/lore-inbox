Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWHaNFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWHaNFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWHaNFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:05:46 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:42768 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S932193AbWHaNFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:05:45 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200608311305.k7VD5iFW018562@clem.clem-digital.net>
Subject: 2.6.18-rc5-git3 SMP fails compile
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Thu, 31 Aug 2006 09:05:44 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fyi:
2.6.18-rc5-git3 fails compile with SMP.

  CC      arch/i386/kernel/asm-offsets.s
In file included from include/linux/spinlock.h:86,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:44,
                 from include/linux/module.h:9,
                 from include/linux/crypto.h:20,
                 from arch/i386/kernel/asm-offsets.c:7:
include/asm/spinlock.h: In function '__raw_read_lock':
include/asm/spinlock.h:164: error: expected '(' before ')' token
include/asm/spinlock.h:164: error: output operand constraint lacks '='
include/asm/spinlock.h:164: error: output operand constraint lacks '='
include/asm/spinlock.h:164: error: invalid lvalue in asm output 0
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

-- 
Pete Clements 

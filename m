Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbVCEQMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVCEQMl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVCEQIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:08:05 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:39399 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261973AbVCEQFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:05:16 -0500
Subject: [patch 1/1] x86-64: kconfig typo (trivial)
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 04 Mar 2005 17:36:00 +0100
Message-Id: <20050304163600.213774B47@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial typo:
	default off
instead of 
	default n
in kbuild.

No, I haven't made sure that it actually does not work, but
correcting it is right.

And "grep off scripts/kconfig/*" does not find anything relevant.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/x86_64/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/x86_64/Kconfig~x86-64-kconfig-typo arch/x86_64/Kconfig
--- linux-2.6.11/arch/x86_64/Kconfig~x86-64-kconfig-typo	2005-03-04 17:30:04.566990048 +0100
+++ linux-2.6.11-paolo/arch/x86_64/Kconfig	2005-03-04 17:30:20.502567472 +0100
@@ -254,7 +254,7 @@ config PREEMPT_BKL
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
 	depends on SMP
-	default off
+	default n
 	help
 	  SMT scheduler support improves the CPU scheduler's decision making
 	  when dealing with Intel Pentium 4 chips with HyperThreading at a
_

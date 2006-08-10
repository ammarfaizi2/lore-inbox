Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWHJUQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWHJUQF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWHJUQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:16:00 -0400
Received: from mx1.suse.de ([195.135.220.2]:24464 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932524AbWHJTfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:47 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [32/145] x86_64: A few trivial spelling and grammar fixes
Message-Id: <20060810193545.D30ED13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:45 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: "Adam Henley" <adamazing@gmail.com>
A few trivial spelling and grammar mistakes picked up in
"arch/x86_64/aperture.c", "arch/x86_64/crash.c" and
"arch/x86_64/apic.c". I think all are correct fixes but am ever aware
of my fallibility :o) This is my first patch submission so all
feedback is appreciated, esp. WRT CCing to Linus, Andi and
trivial@kernel.org, is this correct? And which is the most appropriate
kernel version to diff against? If any.

Should apply cleanly to 2.6.18-rc1

Signed-off-by: Adam Henley <adamazing@gmail.com>
Signed-off-by: Andi Kleen <ak@suse.de>

-  adam

---
 arch/x86_64/kernel/aperture.c |    2 +-
 arch/x86_64/kernel/apic.c     |    4 ++--
 arch/x86_64/kernel/crash.c    |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

Index: linux/arch/x86_64/kernel/aperture.c
===================================================================
--- linux.orig/arch/x86_64/kernel/aperture.c
+++ linux/arch/x86_64/kernel/aperture.c
@@ -48,7 +48,7 @@ static u32 __init allocate_aperture(void
 
 	/* 
 	 * Aperture has to be naturally aligned. This means an 2GB aperture won't
-	 * have much chances to find a place in the lower 4GB of memory.
+	 * have much chance of finding a place in the lower 4GB of memory.
 	 * Unfortunately we cannot move it up because that would make the
 	 * IOMMU useless.
 	 */
Index: linux/arch/x86_64/kernel/apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/apic.c
+++ linux/arch/x86_64/kernel/apic.c
@@ -400,7 +400,7 @@ void __cpuinit setup_local_APIC (void)
 	value |= APIC_SPIV_APIC_ENABLED;
 
 	/*
-	 * Some unknown Intel IO/APIC (or APIC) errata is biting us with
+	 * Some unknown Intel IO/APIC (or APIC) errata are biting us with
 	 * certain networking cards. If high frequency interrupts are
 	 * happening on a particular IOAPIC pin, plus the IOAPIC routing
 	 * entry is masked/unmasked at a high rate as well then sooner or
@@ -950,7 +950,7 @@ void smp_local_timer_interrupt(struct pt
 	 * We take the 'long' return path, and there every subsystem
 	 * grabs the appropriate locks (kernel lock/ irq lock).
 	 *
-	 * we might want to decouple profiling from the 'long path',
+	 * We might want to decouple profiling from the 'long path',
 	 * and do the profiling totally in assembly.
 	 *
 	 * Currently this isn't too much of an issue (performance wise),
Index: linux/arch/x86_64/kernel/crash.c
===================================================================
--- linux.orig/arch/x86_64/kernel/crash.c
+++ linux/arch/x86_64/kernel/crash.c
@@ -69,7 +69,7 @@ static void crash_save_this_cpu(struct p
 	 * for the data I pass, and I need tags
 	 * on the data to indicate what information I have
 	 * squirrelled away.  ELF notes happen to provide
-	 * all of that that no need to invent something new.
+	 * all of that, no need to invent something new.
 	 */
 
 	buf = (u32*)per_cpu_ptr(crash_notes, cpu);

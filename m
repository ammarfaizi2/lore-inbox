Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWGHR15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWGHR15 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWGHR14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:27:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:59609 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964919AbWGHR14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:27:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZJHsbNkih9QNwQ44OGau73cclSeC2SVnEG8WcyfMKslzKf1F1qbVDli4z+++4gV+4Gnc1FIkMISrLg71suMsF5tuq48Of7F8Q6TFZBYKyh23MWyJqsLHH2PLyYx8gkCj2kp6YcW7LQRdRKuEIRqKGPIZ39FTt3SRdKlIpoo8Nm4=
Message-ID: <c526a04b0607081027j62887e9bi5a3b93fa4606e003@mail.gmail.com>
Date: Sat, 8 Jul 2006 18:27:54 +0100
From: "Adam Henley" <adamazing@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc1 1/1] arch/x86-64: A few trivial spelling and grammar fixes
Cc: torvalds@osdl.org, trivial@kernel.org, ak@suse.de
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few trivial spelling and grammar mistakes picked up in
"arch/x86_64/aperture.c", "arch/x86_64/crash.c" and
"arch/x86_64/apic.c". I think all are correct fixes but am ever aware
of my fallibility :o) This is my first patch submission so all
feedback is appreciated, esp. WRT CCing to Linus, Andi and
trivial@kernel.org, is this correct? And which is the most appropriate
kernel version to diff against? If any.

Should apply cleanly to 2.6.18-rc1

Signed-off-by: Adam Henley <adamazing@gmail.com>

-  adam

diff --git a/arch/x86_64/kernel/aperture.c b/arch/x86_64/kernel/aperture.c
index 58af8e7..d5f6f56 100644
--- a/arch/x86_64/kernel/aperture.c
+++ b/arch/x86_64/kernel/aperture.c
@@ -48,7 +48,7 @@ static u32 __init allocate_aperture(void

 	/*
 	 * Aperture has to be naturally aligned. This means an 2GB aperture won't
-	 * have much chances to find a place in the lower 4GB of memory.
+	 * have much chance of finding a place in the lower 4GB of memory.
 	 * Unfortunately we cannot move it up because that would make the
 	 * IOMMU useless.
 	 */
diff --git a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
index 2b8cef0..194b826 100644
--- a/arch/x86_64/kernel/apic.c
+++ b/arch/x86_64/kernel/apic.c
@@ -400,7 +400,7 @@ void __cpuinit setup_local_APIC (void)
 	value |= APIC_SPIV_APIC_ENABLED;

 	/*
-	 * Some unknown Intel IO/APIC (or APIC) errata is biting us with
+	 * Some unknown Intel IO/APIC (or APIC) errata are biting us with
 	 * certain networking cards. If high frequency interrupts are
 	 * happening on a particular IOAPIC pin, plus the IOAPIC routing
 	 * entry is masked/unmasked at a high rate as well then sooner or
@@ -951,7 +951,7 @@ #endif
 	 * We take the 'long' return path, and there every subsystem
 	 * grabs the appropriate locks (kernel lock/ irq lock).
 	 *
-	 * we might want to decouple profiling from the 'long path',
+	 * We might want to decouple profiling from the 'long path',
 	 * and do the profiling totally in assembly.
 	 *
 	 * Currently this isn't too much of an issue (performance wise),
diff --git a/arch/x86_64/kernel/crash.c b/arch/x86_64/kernel/crash.c
index d8d5750..324a5ed 100644
--- a/arch/x86_64/kernel/crash.c
+++ b/arch/x86_64/kernel/crash.c
@@ -68,7 +68,7 @@ static void crash_save_this_cpu(struct p
 	 * for the data I pass, and I need tags
 	 * on the data to indicate what information I have
 	 * squirrelled away.  ELF notes happen to provide
-	 * all of that that no need to invent something new.
+	 * all of that, no need to invent something new.
 	 */

 	buf = (u32*)per_cpu_ptr(crash_notes, cpu);

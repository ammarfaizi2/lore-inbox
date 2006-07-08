Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWGHSuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWGHSuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWGHSuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:50:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:54329 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932253AbWGHSuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:50:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gfhXjfQ01ZL/LX45EU0ihH7ZMy6lDcoIV4kM0dAunNIIvVjuah+MDSk31EM6zOz8fZjHVOLRtfU//DTux+mA3QfqahEzXXxBEtlZoxGMIuRTStLFM+8+Y4drwOM2oMK7t9Yn6aypgW4+RoQcsLetUgdKVvAZXXiB7STXqVR/iBw=
Message-ID: <c526a04b0607081150s54516470p1d1b1726dd7d9675@mail.gmail.com>
Date: Sat, 8 Jul 2006 19:50:23 +0100
From: "Adam Henley" <adamazing@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc1 1/1] arch/x86-64: A few trivial spelling and grammar fixes
Cc: torvalds@osdl.org, trivial@kernel.org, ak@suse.de,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <1152381894.27368.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c526a04b0607081027j62887e9bi5a3b93fa4606e003@mail.gmail.com>
	 <1152381894.27368.30.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edited patch.

diff --git a/arch/x86_64/kernel/aperture.c b/arch/x86_64/kernel/aperture.c
index 58af8e7..d5f6f56 100644
--- a/arch/x86_64/kernel/aperture.c
+++ b/arch/x86_64/kernel/aperture.c
@@ -48,7 +48,7 @@ static u32 __init allocate_aperture(void

       /*
        * Aperture has to be naturally aligned. This means an 2GB aperture won't
-        * have much chances to find a place in the lower 4GB of memory.
+        * have much chance to find a place in the lower 4GB of memory.
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
-        * Some unknown Intel IO/APIC (or APIC) errata is biting us with
+        * Some unknown Intel IO/APIC (or APIC) errata are biting us with
        * certain networking cards. If high frequency interrupts are
        * happening on a particular IOAPIC pin, plus the IOAPIC routing
        * entry is masked/unmasked at a high rate as well then sooner or
@@ -951,7 +951,7 @@ #endif
        * We take the 'long' return path, and there every subsystem
        * grabs the appropriate locks (kernel lock/ irq lock).
        *
-        * we might want to decouple profiling from the 'long path',
+        * We might want to decouple profiling from the 'long path',
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
-        * all of that that no need to invent something new.
+        * all of that. There is no need to invent something new.
        */

       buf = (u32*)per_cpu_ptr(crash_notes, cpu);

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267721AbTBKLBp>; Tue, 11 Feb 2003 06:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267507AbTBKKwx>; Tue, 11 Feb 2003 05:52:53 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11012 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267597AbTBKKwW>;
	Tue, 11 Feb 2003 05:52:22 -0500
Date: Mon, 10 Feb 2003 17:36:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Clarify comment in kernel/acpi.c
Message-ID: <20030210163623.GA1106@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is more explicit about which low memory means... Please apply,

							Pavel

--- clean/arch/i386/kernel/acpi.c	2003-01-17 23:13:33.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/acpi.c	2003-01-27 17:23:36.000000000 +0100
@@ -507,7 +501,7 @@
 /**
  * acpi_reserve_bootmem - do _very_ early ACPI initialisation
  *
- * We allocate a page in low memory for the wakeup
+ * We allocate a page in 1MB low memory for the wakeup
  * routine for when we come back from a sleep state. The
  * runtime allocator allows specification of <16M pages, but not
  * <1M pages.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129219AbQKRNd2>; Sat, 18 Nov 2000 08:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131237AbQKRNdS>; Sat, 18 Nov 2000 08:33:18 -0500
Received: from smtp2.Mountain.Net ([198.77.1.5]:22732 "EHLO
	nabiki.mountain.net") by vger.kernel.org with ESMTP
	id <S129219AbQKRNdC>; Sat, 18 Nov 2000 08:33:02 -0500
Message-ID: <3A167BE4.44080F7F@mountain.net>
Date: Sat, 18 Nov 2000 07:53:56 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Typo in test11-pre7 i386 cpu_init
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is another.

Tom


--- linux-2.4.0-test11/arch/i386/kernel/setup.c.orig	Sat Nov 18 01:55:18
2000+++ linux-2.4.0-test11/arch/i386/kernel/setup.c	Sat Nov 18 07:43:19 2000
@@ -2178,7 +2178,7 @@
 	if (tsc_disable && cpu_has_tsc) {
 		printk("Disabling TSC...\n");
 		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
-		clear_bit(&boot_cpu_data.x86_capability, X86_FEATURE_TSC);
+		clear_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability);
 		set_in_cr4(X86_CR4_TSD);
 	}
 #endif
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

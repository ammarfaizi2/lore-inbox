Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbTAPUsD>; Thu, 16 Jan 2003 15:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTAPUqz>; Thu, 16 Jan 2003 15:46:55 -0500
Received: from ool-182f525d.dyn.optonline.net ([24.47.82.93]:30601 "EHLO
	j0nah.ath.cx") by vger.kernel.org with ESMTP id <S267280AbTAPUpZ>;
	Thu, 16 Jan 2003 15:45:25 -0500
Date: Thu, 16 Jan 2003 10:54:40 -0500
From: Jonah Sherman <jsherman@stuy.edu>
To: tigran@veritas.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial: Fix date in i386 microcode changelog
Message-ID: <20030116155440.GA2471@rootbox>
Reply-To: Jonah Sherman <jsherman@stuy.edu>
Mail-Followup-To: tigran@veritas.com, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The changelog dates for the i386 microcode are wrong(1.11 is
before 1.09 and 1.10)
Patch is against 2.5.58

diff -Nru linux-2.5.58/arch/i386/kernel/microcode.c linux-2.5.58-new/arch/i386/kernel/microcode.c
--- linux-2.5.58/arch/i386/kernel/microcode.c	2003-01-14 00:58:25.000000000 -0500
+++ linux-2.5.58-new/arch/i386/kernel/microcode.c	2003-01-16 10:38:55.000000000 -0500
@@ -55,7 +55,7 @@
  *		Tigran Aivazian <tigran@veritas.com>,
  *		Serialize updates as required on HT processors due to speculative
  *		nature of implementation.
- *	1.11	22 Mar 2001 Tigran Aivazian <tigran@veritas.com>
+ *	1.11	22 Mar 2002 Tigran Aivazian <tigran@veritas.com>
  *		Fix the panic when writing zero-length microcode chunk.
  */
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267292AbUHPQ7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267292AbUHPQ7j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267757AbUHPQ7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:59:39 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:7874 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S267292AbUHPQ7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 12:59:34 -0400
Date: Mon, 16 Aug 2004 09:59:31 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Add docs for PPC noltlbs and nobats parameters
Message-ID: <20040816095931.A11412@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation of the PPC noltlbs and nobats kernel cmdline
parameters. noltlbs is a new option and nobats never had an entry.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== Documentation/kernel-parameters.txt 1.43 vs edited =====
--- 1.43/Documentation/kernel-parameters.txt	Sun Jul 11 02:23:28 2004
+++ edited/Documentation/kernel-parameters.txt	Mon Aug 16 09:54:44 2004
@@ -707,6 +707,9 @@
 	noasync		[HW,M68K] Disables async and sync negotiation for
 			all devices.
 
+	nobats		[PPC] Do not use BATs for mapping kernel lowmem
+			on "Classic" PPC cores.
+
 	nocache		[ARM]
  
 	nodisconnect	[HW,SCSI,M68K] Disables SCSI disconnects.
@@ -738,6 +741,9 @@
 	nointroute	[IA-64]
 
 	nolapic		[IA-32,APIC] Do not enable or use the local APIC.
+
+	noltlbs		[PPC] Do not use large page/tlb entries for kernel
+			lowmem mapping on PPC40x.
 
 	nomce		[IA-32] Machine Check Exception
 

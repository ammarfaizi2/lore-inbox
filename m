Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269467AbUINRXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269467AbUINRXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269603AbUINRTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:19:24 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:37038 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269530AbUINRRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:17:51 -0400
Date: Tue, 14 Sep 2004 10:17:49 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Document ARM pci=firmware option
Message-ID: <20040914171749.GA9193@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Added a new pci= command line option specific to ARM systems in 
-rc2 and it should be added to kernel-parameters.txt.

Please apply,
~Deepak

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

===== Documentation/kernel-parameters.txt 1.47 vs edited =====
--- 1.47/Documentation/kernel-parameters.txt	Thu Aug 26 23:30:30 2004
+++ edited/Documentation/kernel-parameters.txt	Tue Sep 14 09:53:56 2004
@@ -878,6 +878,12 @@
 					enabled.
 		noacpi			[IA-32] Do not use ACPI for IRQ routing
 					or for PCI scanning.
+		firmware		[ARM] Do not re-enumerate the bus but 
+					instead just use the configuration
+					from the bootloader. This is currently
+					used on IXP2000 systems where the 
+					bus has to be configured a certain way
+					for adjunct CPUs.
 
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment
and will die here like rotten cabbages." - Number 6

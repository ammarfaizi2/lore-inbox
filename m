Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWFNR7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWFNR7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 13:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWFNR7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 13:59:35 -0400
Received: from customer-domains.icp-qv1-irony7.iinet.net.au ([203.59.1.128]:53414
	"EHLO customer-domains.icp-qv1-irony7.iinet.net.au")
	by vger.kernel.org with ESMTP id S1750831AbWFNR7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 13:59:34 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,132,1149436800"; 
   d="scan'208"; a="307253303:sNHT12780916"
From: Paul Andreassen <paul@andreassen.com.au>
Organization: Pinnacle Plus
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] swsusp simple typo
Date: Thu, 15 Jun 2006 03:59:19 +1000
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606150359.20038.paul@andreassen.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No sure how this ever worked.

Please CC me because I'm not subscribed.

Paul

--- linux-source-2.6.15.7-ubuntu1/arch/i386/power/cpu.c.old     2006-03-03 
07:18:35.000000000 +1000
+++ linux-source-2.6.15.7-ubuntu1/arch/i386/power/cpu.c 2006-06-15 
00:32:11.022610552 +1000
@@ -92,7 +92,7 @@
        write_cr4(ctxt->cr4);
        write_cr3(ctxt->cr3);
        write_cr2(ctxt->cr2);
-       write_cr2(ctxt->cr0);
+       write_cr0(ctxt->cr0);

        /*
         * now restore the descriptor tables to their proper values

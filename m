Return-Path: <linux-kernel-owner+w=401wt.eu-S1751385AbWLLOzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWLLOzK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 09:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWLLOzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 09:55:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52663 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbWLLOzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 09:55:07 -0500
Date: Tue, 12 Dec 2006 09:55:06 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Fix typo in new debug options.
Message-ID: <20061212145506.GA1397@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.19.noarch/lib/Kconfig.debug~	2006-12-12 09:54:30.000000000 -0500
+++ linux-2.6.19.noarch/lib/Kconfig.debug	2006-12-12 09:54:40.000000000 -0500
@@ -455,7 +455,7 @@ config FAIL_PAGE_ALLOC
 	  Provide fault-injection capability for alloc_pages().
 
 config FAIL_MAKE_REQUEST
-	bool "Fault-injection capabilitiy for disk IO"
+	bool "Fault-injection capability for disk IO"
 	depends on FAULT_INJECTION
 	help
 	  Provide fault-injection capability for disk IO.

-- 
http://www.codemonkey.org.uk

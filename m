Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933173AbWF0AEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933173AbWF0AEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 20:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933457AbWF0AEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 20:04:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933432AbWF0AEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 20:04:06 -0400
Date: Mon, 26 Jun 2006 20:04:05 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: no 64bit geodes (yet?)
Message-ID: <20060627000405.GA6818@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Offering this driver on x86-64 is pointless right now.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/char/hw_random/Kconfig~	2006-06-26 20:03:04.000000000 -0400
+++ linux-2.6/drivers/char/hw_random/Kconfig	2006-06-26 20:03:19.000000000 -0400
@@ -38,7 +38,7 @@ config HW_RANDOM_AMD
 
 config HW_RANDOM_GEODE
 	tristate "AMD Geode HW Random Number Generator support"
-	depends on HW_RANDOM && X86 && PCI
+	depends on HW_RANDOM && X86_32 && PCI
 	default y
 	---help---
 	  This driver provides kernel-side support for the Random Number

-- 
http://www.codemonkey.org.uk

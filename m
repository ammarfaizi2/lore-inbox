Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263168AbTHVMnr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbTHVMkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:40:51 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:20495 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263168AbTHVL4M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 07:56:12 -0400
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test3-mm3 ACPI config broken
Date: Fri, 22 Aug 2003 19:54:04 +0800
User-Agent: KMail/1.5.2
Cc: acpi-devel-request@lists.sourceforge.net
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308221954.06089.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last line of the block below in drivers/acpi/Kconfig disables ACPI in most configs. Please check.

config ACPI
	bool "Full ACPI Support"
	depends on !X86_VISWS
	depends on !IA64_HP_SIM
	depends on IA64 || (X86 && ACPI_HT)

Regards
Michael

-- 
Powered by linux-2.6. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, PCI IRQ sharing, swsusp
2.6 kernel testing:     PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3

More info on swsusp: http://sourceforge.net/projects/swsusp/


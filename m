Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269994AbTHFQkg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270811AbTHFQjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:39:13 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:16909 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S270803AbTHFQiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:38:18 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test2: Lost USB mouse after resuming from S3
Date: Thu, 7 Aug 2003 00:37:31 +0800
User-Agent: KMail/1.5.2
Cc: acpi-devel@lists.sourceforge.net, usb-devel@lists.sourceforge.net
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308070037.31630.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Causes are that usb-host controller does no handle S3 yet _plus_ possibly (depending on your hardware) 
loss of PCI interrupt links as current ACPI does not resume those.

Regards
Michael


-- 
Powered by linux-2.6-test2-mm4. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, PCI IRQ sharing, swsusp
2.6 kernel testing:     PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3

More info on swsusp: http://sourceforge.net/projects/swsusp/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270234AbTGMLtw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 07:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270235AbTGMLtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 07:49:52 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:62469 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S270234AbTGMLtv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 07:49:51 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.74-mm1 yenta socket map card memory failure
Date: Sun, 13 Jul 2003 19:56:00 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307131229.34985.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got messages below. No such messages in logs of past 4 weeks and not seen before.

Regards
Michael

Jul 13 10:16:17 mhfl2 kernel: Linux Kernel Card Services 3.1.22
Jul 13 10:16:17 mhfl2 kernel:   options:  [pci] [cardbus] [pm]
Jul 13 10:16:17 mhfl2 startup: i82365
Jul 13 10:16:17 mhfl2 kernel: Intel PCIC probe: not found.
Jul 13 10:16:17 mhfl2 kernel: PCI: Enabling device 0000:00:12.0 (0000 -> 0002)
Jul 13 10:16:17 mhfl2 kernel: Yenta IRQ list 0000, PCI irq5
Jul 13 10:16:17 mhfl2 kernel: Socket status: 30000011
Jul 13 10:16:17 mhfl2 startup: using yenta_socket instead of i82365
Jul 13 10:16:17 mhfl2 startup: ds


----------------------\/
Jul 13 10:16:18 mhfl2 kernel: cs: warning: no high memory space available!
Jul 13 10:16:18 mhfl2 kernel: cs: unable to map card memory!
Jul 13 10:16:18 mhfl2 last message repeated 3 times



Jul 13 10:16:19 mhfl2 startup: cardmgr[1171]: watching 1 sockets
Jul 13 10:16:19 mhfl2 cardmgr[1171]: watching 1 sockets
Jul 13 10:16:19 mhfl2 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jul 13 10:16:19 mhfl2 kernel: cs: IO port probe 0x0800-0x08ff: clean.
Jul 13 10:16:19 mhfl2 kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x1e0-0x1e7 0x3c0-0x3df 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
Jul 13 10:16:19 mhfl2 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jul 13 10:16:19 mhfl2 cardmgr[1172]: starting, version is 3.2.4
Jul 13 10:16:19 mhfl2 startup: done.
Jul 13 10:16:20 mhfl2 rc: Starting startup:  succeeded


-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/


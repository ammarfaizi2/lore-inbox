Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTEEQbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbTEEQ3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:29:01 -0400
Received: from franka.aracnet.com ([216.99.193.44]:52170 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263668AbTEEQ2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:28:32 -0400
Date: Mon, 05 May 2003 09:40:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 655] New: Infrequent lockups on inbound connections
Message-ID: <11290000.1052152830@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=655

           Summary: Infrequent lockups on inbound connections
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: davem@vger.kernel.org
         Submitter: wsl-kernelbugs@fruit.eu.org


Distribution: Debian unstable/experimental
Hardware Environment: AMD Athlon XP1800+ stepping 02, VIA kt266a chipset,
eepro100 Intel 82557/8/9 rev 08 (PCI ID 8086:1229)
Software Environment: anything that does IPv6 TCP
(http://fruit.eu.org/config-2.5.68)
Problem Description:
Every so often the kernel locks up during an inbound connection. Alt-sysrq-s
doesn't work anymore, alt-sysrq-b does.

Steps to reproduce:
Create lots of inbound connections. Machine will hang sooner or later.


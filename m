Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWAQPGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWAQPGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWAQPGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:06:04 -0500
Received: from mail.dvmed.net ([216.237.124.58]:50091 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750915AbWAQPGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:06:00 -0500
Message-ID: <43CD07D5.30302@pobox.com>
Date: Tue, 17 Jan 2006 10:05:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: sata_mv important note
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  For sata_mv users, you should be aware of three things:
	1) The Marvell driver is experimental, and not yet considered ready for
	production use. As Kconfig notes: HIGHLY EXPERIMENTAL. 2) There are PCI
	Message Signalled Interrupt (MSI) problems that are not yet diagnosed.
	Workaround is to disable MSI. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For sata_mv users, you should be aware of three things:

1) The Marvell driver is experimental, and not yet considered ready for 
production use.  As Kconfig notes: HIGHLY EXPERIMENTAL.

2) There are PCI Message Signalled Interrupt (MSI) problems that are not 
yet diagnosed.  Workaround is to disable MSI.

3) There are still some errata that are not yet implemented.  Thus, for 
some systems, you may see either lockups or data corruption.  That's the 
price of running a HIGHLY EXPERIMENTAL driver.

Rest assured that all problem reports are read, even if you don't 
receive a reply.  After enough feedback is received, the exact problem 
becomes more clear.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVCNUIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVCNUIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVCNUHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:07:50 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7587 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261790AbVCNUFy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:05:54 -0500
Subject: Linux 2.6.11-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110830635.17740.144.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 14 Mar 2005 20:03:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Almost entirely the 2.6.11.3 update this time. Nice and simple because the
2.6.11.x is working out wonderfully.

Alan


2.6.11-ac3
o	Merge in 2.6.11.3
o	Make SATA AHCI error recovery work		(Brett Russ)
o	Watchdog link order				(Dave Jones)
o	Ressurect epca serial driver			(Alan Cox)
	
2.6.11-ac2
o	Merge 2.6.11.2					(Greg Kroah-Hartmann)
	including epoll error handling			(Georgi Guninski)
	| Theoretically security
o	Fix a couple of pwc warnings			(Alan Cox)
o	Ressurect esp serial driver			(Alan Cox)

2.6.11-ac1
o	Fix jbd race in ext3				(Stephen Tweedie)

Carried over from 2.6.10-ac

Security
o	AF_ROSE security hole fix - still missing from base
o	Bridge failure to check kmalloc argument overflow

Functionality
o	PWC USB camera driver
o	Working ULI526X support (added to base in .11 but broken)
o	ATP88x support
o	Intelligent misrouted IRQ handlers
o	Fix PCI boxes that take minutes IDE probing
o	Remove bogus confusing XFree86 keyboard message
o	Support fibre AMD pcnet32
o	Runtime configurable clock
	| So you can run laptops usefully. Set 100Hz to fix
	| the power drain, clock sliding and other problems
	| 1000Hz causes
o	Fix token ring locking so token ring can be used again
o	x86_64/32 cross build fixes
o	NetROM locking fixes (so NetROM actually works!)
o	SUID dumpable support
o	Don't log pointless CD messages
o	Minimal stallion driver functionality
o	IDE from 2.6-ac

Misc
o	Correct LANANA URL



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVCPTqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVCPTqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVCPTp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:45:59 -0500
Received: from [81.2.110.250] ([81.2.110.250]:3253 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262767AbVCPTps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:45:48 -0500
Subject: Linux 2.6.11-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111002230.1213.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 16 Mar 2005 19:43:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.11-ac4
o	Merge with 2.6.11.4

2.6.11-ac3
o	Make SATA AHCI error recovery work		(Brett Russ)
o	Watchdog link order				(Dave Jones)
o	Ressurect the epca driver			(Alan Cox)
o	Merge with 2.6.11.3

2.6.11-ac2
o	Merge 2.6.11.2					(Greg Kroah-Hartmann)
	including epoll error handling			(Georgi Guninski)
	| Theoretically security
o	Fix a couple of pwc warnings			(Alan Cox)
o	Ressurect esp driver				(Alan Cox)

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




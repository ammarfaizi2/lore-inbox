Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVCGWE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVCGWE6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVCGWEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:04:53 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:11136 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261818AbVCGVgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:36:09 -0500
Subject: Linux 2.6.11-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110231261.3116.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Mar 2005 21:34:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For a couple of reasons I've not yet merged Greg's 2.6.11.1 yet but this
diff should actually apply to either right now.

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





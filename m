Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271129AbUJVANo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271129AbUJVANo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271110AbUJVANj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:13:39 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:10207 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S271129AbUJVALB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:11:01 -0400
Subject: Linux 2.6.9-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098400086.18025.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Oct 2004 00:08:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.9/

2.6.9-ac3
o	Fix syncppp/async ppp problems with new hangup	(Paul Fulghum)
o	Fix broken parport_pc unload			(Andrea Arcangeli)
o	Security fix for smbfs leak/overrun		(Urban Widmark)
o	Stop i8xx_tco making some boxes reboot on load	(wim@iguana)
o	Fix cpia/module tools deadlock			(Peter Pregler)
o	Fix missing suid_dumpable export		(Alan Cox)

2.6.9-ac2
o	Fix invalid kernel version stupidity		(Adrian Bunk)
o	Compiler ICE workaround/fixup			(Linus Torvalds)
o	Fix network DoS bug in 2.6.9			(Herbert Xu)
	| Suggested by Sami Farin
o	Flash lights on panic as in 2.4			(Andi Kleen)

2.6.9-ac1

Security Fixes
o	Set VM_IO on areas that are temporarily		(Alan Cox)
	marked PageReserved (Serious bug)
o	Lock ide-proc against driver unload		(Alan Cox)
	(very low severity)

Bug Fixes
o	Working IDE locking				(Alan Cox)
	| And a great deal of review by Bartlomiej
o	Handle E7xxx boxes with USB legacy flaws	(Alan Cox)
	
Functionality
o	Allow booting with "irqpoll" or "irqfixup"	(Alan Cox)
	on systems with broken IRQ tables.
o	Support for setuid core dumping in some		(Alan Cox)
	environments (off by default)
o	Support for drives that don't report geometry
o	IT8212 support (raid and passthrough)		(Alan Cox)
o	Allow IDE to grab all unknown generic IDE	(Alan Cox)
	devices (boot with "all-generic-ide")
o	Restore PWC driver				(Luc Saillard)

Other
o	Small pending tty clean-up to moxa		(Alan Cox)
o	Put VIA Velocity (tm) adapters under gigabit	(VIA)


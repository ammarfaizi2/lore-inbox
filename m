Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270376AbUJUMPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270376AbUJUMPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268703AbUJUMN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:13:56 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:28124 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268709AbUJUMLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:11:18 -0400
Subject: Linux 2.6.9-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098356892.17052.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 12:08:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those who need the various patches and bits I've been doing. Also if
people have small, clearly correct fixes to real problems in 2.6.9 that
ought to go into a production 2.6.9 series kernel please mail me a copy
and I'll merge those so we don't get the 2.6.8.1 audio ripping mess
again. 

ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.9/

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


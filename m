Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279692AbRJYG2a>; Thu, 25 Oct 2001 02:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279694AbRJYG2X>; Thu, 25 Oct 2001 02:28:23 -0400
Received: from p1289.vcu.wanadoo.nl ([194.134.170.14]:43136 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S279692AbRJYG2I>; Thu, 25 Oct 2001 02:28:08 -0400
Message-Id: <200110242132.XAA03501@cave.bitwizard.nl>
Subject: APIC and "ISA" interrupts. 
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Date: Wed, 24 Oct 2001 23:32:45 +0200 (MEST)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After upgrading our fileserver to 2.4, I can't seem to get the ISDN
card to work. I think that's because the kernel is using the APIC to
route interrupts, such that my BIOS configuration "used-by-Legacy-ISA" 
is no longer in effect. 

I tried disabling the APIC with the following results: 

Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=linux ro root=302 BOOT_FILE=/boot/vmlinuz disableapic

as far as I can see, the code to print "local apci disabled by bios"
is not called if "disableapic" is on the commandline.

This is linux-2.4.10 that I got with SuSE 7.3

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

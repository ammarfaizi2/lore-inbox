Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284538AbRLXJun>; Mon, 24 Dec 2001 04:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284540AbRLXJud>; Mon, 24 Dec 2001 04:50:33 -0500
Received: from www.automatix.de ([212.4.161.35]:37643 "EHLO mail.automatix.de")
	by vger.kernel.org with ESMTP id <S284538AbRLXJuS>;
	Mon, 24 Dec 2001 04:50:18 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Juergen Sauer <jojo@automatix.de>
Organization: AutomatiX GmbH
To: linux-usb-users@lists.sourceforge.net
Subject: VIA Chipsets + USB + SMP == UGLY TRASH
Date: Mon, 24 Dec 2001 10:32:49 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16IRTQ-0003oN-00@s.automatix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Merry X-Mas everywhere !

So, my USB tryout is over. 
This is the expierience report:
You should not try to use VIA Chipsets + SMP + USB, that's
the worst thinkable idea. It's junk (usb-Part).

That's why:
1. not solved USB Irq errors in APIC mode, causes:
	Error -110, device does not accept ID
	USB Host is recognized fine, no device is attaced

This is an error somewhere in the Kernel APIC Irq routing, which may 
worked around with "append noapic pirq="your irq" but using such a cutdown
USB System is not a good idea, no relly working bulk-transfers (forget 
any devices which depend from it: scanners, camera, sound, isdn, 
harddisks, zip etc.)

State: unusable.
Timeframe to be fixed: Unkonwn, Error Reports open open since 1 year

So now I shutdown an connect the scanner (HP 6350) with a 2nd scsi card.

Ciao
Jürgen Sauer
	
-- 
Jürgen Sauer - AutomatiX GmbH, +49-4209-4699, jojo@automatix.de **
** Das Linux Systemhaus - Service - Support - Server - Lösungen **
http://www.automatix.de to Mail me: remove: -not-for-spawm-     **

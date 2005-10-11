Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbVJKTJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbVJKTJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 15:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbVJKTJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 15:09:35 -0400
Received: from er-systems.de ([217.172.180.163]:13587 "EHLO er-systems.de")
	by vger.kernel.org with ESMTP id S1751445AbVJKTJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 15:09:35 -0400
Date: Tue, 11 Oct 2005 21:09:38 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: linux-kernel@vger.kernel.org
Subject: bttv card after swsusp dead
Message-ID: <Pine.LNX.4.63.0510112104290.16712@er-systems.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1395022924-720038107-1129057778=:16712"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1395022924-720038107-1129057778=:16712
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT


Hi,


with 2.6.13 I could after a software suspend use my bttv card. This is not 
possible aynmore with 2.6.14-rc3 and 2.6.14-rc4. 

dmesg part of 2.6.13:

ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKA] -> GSI 11 (level, low) 
-> IRQ 11
bttv0: reset, reinitialize
bttv0: PLL: 28636363 => 35468950 . ok



and now with 2.6.14-rc3/4:


ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKA] -> GSI 11 (level, low) 
-> IRQ 11
ACPI: PCI interrupt for device 0000:01:04.0 disabled
bttv0: Can't enable device.
ACPI: PCI Interrupt 0000:01:04.1[A] -> Link [LNKA] -> GSI 11 (level, low) 
-> IRQ 11



      Thomas

-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------
---1395022924-720038107-1129057778=:16712--

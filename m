Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVJLL7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVJLL7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 07:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVJLL7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 07:59:00 -0400
Received: from er-systems.de ([217.172.180.163]:4102 "EHLO er-systems.de")
	by vger.kernel.org with ESMTP id S932428AbVJLL7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 07:59:00 -0400
Date: Wed, 12 Oct 2005 13:59:01 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: Pavel Machek <pavel@ucw.cz>, acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: bttv card after swsusp dead
In-Reply-To: <20051012113239.GA31035@elf.ucw.cz>
Message-ID: <Pine.LNX.4.63.0510121355030.30888@er-systems.de>
References: <Pine.LNX.4.63.0510112104290.16712@er-systems.de>
 <20051012113239.GA31035@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1395022924-223126574-1129118341=:30888"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1395022924-223126574-1129118341=:30888
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 12 Oct 2005, Pavel Machek wrote:

> Hi!
> 
> > with 2.6.13 I could after a software suspend use my bttv card. This is not 
> > possible aynmore with 2.6.14-rc3 and 2.6.14-rc4. 
> > 
> > dmesg part of 2.6.13:
> > 
> > ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKA] -> GSI 11 (level, low) 
> > -> IRQ 11
> > bttv0: reset, reinitialize
> > bttv0: PLL: 28636363 => 35468950 . ok
> > 
> > 
> > 
> > and now with 2.6.14-rc3/4:
> > 
> > 
> > ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKA] -> GSI 11 (level, low) 
> > -> IRQ 11
> > ACPI: PCI interrupt for device 0000:01:04.0 disabled
> > bttv0: Can't enable device.
> > ACPI: PCI Interrupt 0000:01:04.1[A] -> Link [LNKA] -> GSI 11 (level, low) 
> > -> IRQ 11
> 
> You probably want to ask on acpi-devel. Looks like some change in
> interrupt routing broken your card..
> 
> 									Pavel


Stupid me. Herewith resend to acpi-devel. 
Thanks Pavel for the info.

 

      Thomas

-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------
---1395022924-223126574-1129118341=:30888--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVJLLeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVJLLeP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 07:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVJLLeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 07:34:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34467 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932425AbVJLLeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 07:34:15 -0400
Date: Wed, 12 Oct 2005 13:32:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Voegtle <tv@lio96.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bttv card after swsusp dead
Message-ID: <20051012113239.GA31035@elf.ucw.cz>
References: <Pine.LNX.4.63.0510112104290.16712@er-systems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510112104290.16712@er-systems.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> with 2.6.13 I could after a software suspend use my bttv card. This is not 
> possible aynmore with 2.6.14-rc3 and 2.6.14-rc4. 
> 
> dmesg part of 2.6.13:
> 
> ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKA] -> GSI 11 (level, low) 
> -> IRQ 11
> bttv0: reset, reinitialize
> bttv0: PLL: 28636363 => 35468950 . ok
> 
> 
> 
> and now with 2.6.14-rc3/4:
> 
> 
> ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKA] -> GSI 11 (level, low) 
> -> IRQ 11
> ACPI: PCI interrupt for device 0000:01:04.0 disabled
> bttv0: Can't enable device.
> ACPI: PCI Interrupt 0000:01:04.1[A] -> Link [LNKA] -> GSI 11 (level, low) 
> -> IRQ 11

You probably want to ask on acpi-devel. Looks like some change in
interrupt routing broken your card..

									Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

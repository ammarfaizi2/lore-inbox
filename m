Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbTH3VJg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 17:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbTH3VJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 17:09:36 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:50444 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S262113AbTH3VJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 17:09:32 -0400
Date: Sat, 30 Aug 2003 23:09:13 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Claas Langbehn <claas@rootdir.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, andrew.grover@intel.com,
       paul.s.diefenbaugh@intel.com
Subject: Re: 2.6.0-test4 acpi problems
Message-ID: <20030830210913.GA5809@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030830203353.GA967@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030830203353.GA967@rootdir.de>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claas Langbehn <claas@rootdir.de>
Date: Sat, Aug 30, 2003 at 10:33:53PM +0200
> Hello!
> 
> 
> I have got an Epox 8K9A9i mainboard with an Athlon XP 1800+ CPU. The
> chipset is an VIA KT400A. The bios is dated 12.05.2003.
> When booting with ACPI enabled, the interrupts dont get enumerated
> properly. with acpi=ht it works, but i dont have enough features.
> Below you see my bootlog with acpi and further down the bootlog with 
> acpi=off. Is there a way to use full acpi support and "normal"
> interrupts? pci=noacpi was not really successful.
> 
> How can I help acip development and do more debugging?
> 
> kernel: pci_link-0263 [17] acpi_pci_link_get_curr: No IRQ resource found
> kernel: ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)
> kernel: pci_link-0263 [19] acpi_pci_link_get_curr: No IRQ resource found

Lots of people have problems with KT400 chipsets and ACPI. A mr. Quincey
is busy devising a patch, and according to his last post at the
acpi-support mailinglist from sourceforge, things are getting better.
There are also several bugs postet at bugzilla.kernel,org.

So either wait, or join acpi-support and read more there.

Hope this helps,
Jurriaan
-- 
I mean, if the musician thought "WOOOHOOO! YEAH! ANI RUUULES!" sounded better
than the actual lyrics she would have put them on there.
	Steve in rec.music.artists.ani-difranco.
Debian (Unstable) GNU/Linux 2.6.0-test4-mm2 4276 bogomips 4.40 2.63

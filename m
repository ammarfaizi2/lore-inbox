Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSFYAPP>; Mon, 24 Jun 2002 20:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315421AbSFYAPO>; Mon, 24 Jun 2002 20:15:14 -0400
Received: from pallas.or.intel.com ([134.134.214.21]:21961 "EHLO
	pallas.or.intel.com") by vger.kernel.org with ESMTP
	id <S315420AbSFYAPO>; Mon, 24 Jun 2002 20:15:14 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7F59@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Shawn Starr'" <spstarr@sh0n.net>, Linux <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.5.24 - Strange power off problems (ACPI support on)
Date: Mon, 24 Jun 2002 17:15:03 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Shawn Starr [mailto:spstarr@sh0n.net] 
> When I run the halt/poweroff program, it powers off the hard 
> disks, and
> displays the 'Poweroff System' message. If I press the power 
> button, It
> turns the system off HARD, Ie, i don't see the NIC card's aux 
> power on,
> and when I try to turn the machine on again it won't until I 
> physically
> remove all power (turn off powerbar) for a few seconds, then 
> It will let
> me power it on (or it will power on itself).
> 
> This did not happen in the 2.4.x kernel, I assume a new ACPI bug? ;-)

I'm heartened to see that ACPI PCI IRQ routing and CPU/IOAPIC enumeration is
working on your system. ;-)

2.4 ACPI is very different from 2.5 ACPI. You can try the latest ACPI patch
against 2.4 at http://sf.net/projects/acpi .

I bet it will do the same thing, though. I'll have to think about why this
might be happening.

Regards -- Andy

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264792AbTIDH1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264778AbTIDHZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:25:11 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:5519 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264769AbTIDHY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:24:59 -0400
Date: Wed, 3 Sep 2003 13:05:52 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Where do I send APIC victims?
Message-ID: <20030903110552.GF27875@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030903080852.GA27649@k3.hellgate.ch> <200309031123.58713.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309031123.58713.adq_dvb@lidskialf.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003, Andrew de Quincey wrote:

> Hi, I'm trying to develop patches for ACPI IRQ issues. 
> 
> Are these VIA KT333/KT400 chipsets? If so, there's a known bug in many BIOSes 
> with these chipsets. I'm waiting on some docs from VIA to fix this issue.

I'm looking after a box with EPoX 8K9A2+ board (IIRC), with KT400 chip
set.  Booting with ACPI enabled (i. e. no acpi=off in kernel command
line) makes most interrupts (network, disk) invisible. acpi=off fixes
this. I haven't bothered to report this because it's running some
SuSE-patched 2.4.20 kernel (they did patch newer ACPI, "Subsystem
revision 20030228").

Is testing a newer kernel or ACPI stuff worthwhile or should I wait?
It's a production machine, so "see if this works" is out of the game,
"it should work" can be tested in times of low load but not necessarily
on short notice.

Is this any help?

<6>ACPI: Subsystem revision 20030228
<6>ACPI: Disabled via command line (acpi=off)
<6>PCI: PCI BIOS revision 2.10 entry at 0xfb380, last bus=1
<6>PCI: Using configuration type 1
<6>PCI: Probing PCI hardware
<4>PCI: ACPI tables contain no PCI IRQ routing entries
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Using IRQ router VIA [1106/3177] at 00:11.0

That 00:11.0 is:

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

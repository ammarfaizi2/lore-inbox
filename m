Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTKKTWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 14:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTKKTWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 14:22:49 -0500
Received: from oobleck.astro.cornell.edu ([132.236.6.230]:44501 "EHLO
	oobleck.astro.cornell.edu") by vger.kernel.org with ESMTP
	id S263695AbTKKTV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 14:21:57 -0500
Date: Tue, 11 Nov 2003 14:21:56 -0500
Message-Id: <200311111921.hABJLur16428@oobleck.astro.cornell.edu>
From: Joe Harrington <jh@oobleck.astro.cornell.edu>
To: linux-kernel@vger.kernel.org
Subject: Via KT600 support?
CC: jh@oobleck.astro.cornell.edu
Reply-To: jh@oobleck.astro.cornell.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having show-stopper difficulties getting Linux to run on my Asus
A7V600 motherboard, which sports the Via KT600 chipset.

During install of Fedora Core 1, Fedora Core test3, Red Hat 9, and
Debian 3.0r1, the install fails at a random point, generally during
the non-interactive package loading phase.  The most recent kernel
with the problem is kernel-2.4.22-1.2115.nptl in the Fedora Core 1
release.  The problem is 100% reproducible.

VC messages indicate problems in different programs each time.
Generally the failure happens during package installation, but
sometimes it happens earlier.  After the first indication of a
problem, one can generally still switch VCs, but eventually that stops
working, too.  Frequently, there are several programs indicating
problems in the VC screens.

In three months of trials, I have never gotten any install to run to
completion on this machine.  I have used the same media for each of
the distros above to install other machines.

The hardware:

Asus A7V600 mobo (VIA KT600 chipset)
AMD 2800+XP CPU
1536 MB DDR333 (3 sticks)
IDE disks (250GB WD)
IDE CD/DVD reader

On Morphix 0.4-1 (a live-CD linux distro), this configuration boots,
but crashes during large file copies (1GB or larger generally does it,
but it can happen much sooner than that, or occasionally take longer).

Things I have tried:
noapic nolapic acpi=off pci=noacpi allowcddma nodma
in various combinations and individually.  None worked.  I also
changed "APIC" to "PIC" in the BIOS, to no avail.

I have tested and replaced the hardware extensively over the past
several months of chasing this problem down.  The problem is not
damaged hardware.  I suspect it is a problem with chipset support in
the kernel.  However, I have not been able to find a reliable source
of information about the support status of various chipsets and
motherboard features in the kernel.

Please reply directly as I am not subscribed to linux-kernel.

Thanks,

--jh--

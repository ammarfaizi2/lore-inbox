Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbTAJTDX>; Fri, 10 Jan 2003 14:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266930AbTAJTDT>; Fri, 10 Jan 2003 14:03:19 -0500
Received: from mailout.nordcom.net ([213.168.202.90]:31696 "HELO
	mailout.nordcom.net") by vger.kernel.org with SMTP
	id <S266971AbTAJTCZ>; Fri, 10 Jan 2003 14:02:25 -0500
Date: Fri, 10 Jan 2003 20:11:08 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-acpi: NMI received for unknown reason 2d/3d
Message-ID: <Pine.LNX.4.44.0301102002160.1120-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Kernel is 2.4.20 with akpm's ext3 fixes and acpi-20021212-2.4.20.diff.gz
patched in.

I just upgraded from a Duron 1 GHz processor to an Athlon XP 1700+. The
only other change to the system is an updated BIOS to support the new
processor.

Motherboard is a Soyo K7ADA, using the ALi Magik 1 chipset.

Since the CPU and BIOS upgrade, I get the following message(s) from
the kernel:

> Uhhuh. NMI received for unknown reason 2d.
> Dazed and confused, but trying to continue
> Do you have a strange power saving mode enabled?

The reason is 2d most of the time, with a few 3d inbetween. About 8 of
these messages pile up in dmesg until my system (Red Hat 7.2) is
completely done running sysinit. After that, new messages only appear
seldomly and minutes apart with no pattern I could regocnize.

I don't think it's a memory problem because memtest86 (I only tried a
single run since the memory worked fine before) doesn't show up errors
and memory-related NMIs are not "unknown reason"s to the kernel as far
as I know.

Everything that shows up in the BIOS setup related to power management
is turned off.

Running with or without local APIC support does not change anything. Same 
for ACPI support or not.

What can this be? Do I have to worry or is this just some fancy power
management stuff supported by the AthlonXP that the kernel does not know
about?

Again, this is an AthlonXP 1700+ (CPU family 6, model 8, stepping 0).

-- 
Ciao,
Pascal


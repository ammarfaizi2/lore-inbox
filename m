Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUBCKrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 05:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUBCKrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 05:47:46 -0500
Received: from aun.it.uu.se ([130.238.12.36]:50863 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265966AbUBCKrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 05:47:43 -0500
Date: Tue, 3 Feb 2004 11:47:42 +0100 (MET)
Message-Id: <200402031047.i13Algrs019289@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: mcornils@usta.de
Subject: ACPI breakage (was: 2.6.x: local APIC results in hang at boot)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-02-03, Malte Cornils wrote:
>I've tested this with 2.6.2-rc3 and kernels before that; when I activate
>the "Enable local APIC" question the kernel hangs with:
>
>POSIX conformance testing by UNIFIX
>enabled ExtInt on CPU#0
>ESR value before enabling vector: 00000000
>ESR value after enabling vector: 00000000
>Using local APIC timer interrupts.
>calibrating APIC timer ...
>..... CPU clock speed is 1399.0856 MHz.
>..... host bus clock speed is 99.0989 MHz.
>NET: Registered protocol family 16
>EISA bus registered
>PCI: Using configuration type 1
>mtrr: v2.0 (20020519)
>ACPI: Subsystem revision 20040116
>ACPI: IRQ9 SCI: Edge set to Level Trigger.
>
>and then nothing happens.
>
>On request, I can send the boot log from the same kernel without local
>APIC compiled-in; you can also get it from 
>http://www.usta.de/RefAk/Aussen/privat/apic-works.log
>
>As I said, it works without the option. (So, this is a problem for
>people using distribution/generic kernels with the Local-APIC option
>enabled)
>
>This is an Asus Centrino notebook (M2400N) with 1,4 GHz, latest BIOS
>update and so on. When I enable the local APIC but disable ACPI, it
>works too - ACPI is used to reroute some interrupts and make e.g. sound
>work.

This clearly indicates ACPI breakage on your machine.
Re-report it as such to the ACPI list.

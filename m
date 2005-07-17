Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVGRMvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVGRMvC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 08:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVGRMvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 08:51:02 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41689 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261340AbVGRMvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 08:51:01 -0400
Message-Id: <200507170256.j6H2ugUo004904@laptop11.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc3 from today: No Toshiba ACPI module load?
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sat, 16 Jul 2005 22:56:42 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 18 Jul 2005 08:50:59 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting:
# modprobe toshiba_acpi
FATAL: Error inserting toshiba_acpi (/lib/modules/2.6.13-rc3/kernel/drivers/acpi/toshiba_acpi.ko): No such device

This is definitely a Toshiba M30 notebook with this.

On bootup I see:

ACPI: RSDP (v000 TOSHIB                                ) @ 0x000f7a10
ACPI: RSDT (v001 TOSHIB 750      0x00970814 MASM 0x06110000) @ 0x1ff63fd8
ACPI: FADT (v002 TOSHIB 750      0x20030101 MASM 0x61100000) @ 0x1ff69d03
ACPI: SSDT (v001 TOSHIB A0007    0x00970814 MSFT 0x0100000e) @ 0x1ff69d87
ACPI: DBGP (v001 TOSHIB 750      0x00970814 MASM 0x61100000) @ 0x1ff69fa4
ACPI: BOOT (v001 TOSHIB 750      0x00970814 MASM 0x06110000) @ 0x1ff69fd8
ACPI: DSDT (v001 TOSHIB A0007    0x20030806 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008

Anything else that might be useful?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbTFCJMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 05:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264854AbTFCJMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 05:12:54 -0400
Received: from a089003.adsl.hansenet.de ([213.191.89.3]:19584 "EHLO rubicon")
	by vger.kernel.org with ESMTP id S264850AbTFCJMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 05:12:53 -0400
Date: Tue, 3 Jun 2003 11:26:17 +0200
To: stelian@popies.net
Cc: linux-kernel@vger.kernel.org
Subject: sonypi irq 11 nobody cared
Message-ID: <20030603092617.GA2949@jandittmer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Jan Dittmer <jdittmer@jandittmer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm hitting this with 2.5.70-bk7, spicctrl is working though.
Machine in question is a Sony Vaio SRX51P.
acpi & apic enabled.

CONFIG_SONYPI=m

Thanks,
Jan

irq 11: nobody cared!
Call Trace:
 [<c010ab04>] handle_IRQ_event+0x94/0xf0
 [<c010acf1>] do_IRQ+0x9d/0x118
 [<d0ac86f8>] sonypi_type2_ioport_list+0x0/0x14 [sonypi]
 [<d0ac871c>] sonypi_type2_irq_list+0x0/0x14 [sonypi]
 [<c010974c>] common_interrupt+0x18/0x20
 [<d0ac86f8>] sonypi_type2_ioport_list+0x0/0x14 [sonypi]
 [<d0ac871c>] sonypi_type2_irq_list+0x0/0x14 [sonypi]
 [<c01c007b>] strlcpy+0x43/0x64
 [<d0ac53a9>] sonypi_call2+0x85/0xc8 [sonypi]
 [<d0ac6351>] sonypi_probe+0x241/0x3e0 [sonypi]
 [<d0ac8a00>] +0x0/0x200 [sonypi]
 [<d0954020>] +0x20/0x2a [sonypi]
 [<c012dbf4>] sys_init_module+0xf8/0x1f4
 [<c0108ddf>] syscall_call+0x7/0xb

handlers:
[<d0ac571c>] (sonypi_irq+0x0/0x204 [sonypi])
sonypi: Sony Programmable I/O Controller Driver v1.18.
sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on
irq 11: nobody cared!
Call Trace:
 [<c010ab04>] handle_IRQ_event+0x94/0xf0
 [<c010acf1>] do_IRQ+0x9d/0x118
 [<c010974c>] common_interrupt+0x18/0x20
 [<c01f007b>] eraser+0x20b/0x410
 [<c0221a53>] vgacon_scroll+0xd7/0x1f0
 [<c01fa282>] scrup+0x76/0x108
 [<c01fb7d0>] lf+0x34/0x60
 [<c01fe00f>] vt_console_print+0x19f/0x2d0
 [<c011bf56>] __call_console_drivers+0x3e/0x50
 [<c011bfbb>] _call_console_drivers+0x53/0x58
 [<c011c075>] call_console_drivers+0xb5/0xe0
 [<c011c2ce>] release_console_sem+0x4a/0xb4
 [<c011c227>] printk+0x11f/0x148
 [<d0ac86f8>] sonypi_type2_ioport_list+0x0/0x14 [sonypi]
 [<d0ac871c>] sonypi_type2_irq_list+0x0/0x14 [sonypi]
 [<d0ac63e9>] sonypi_probe+0x2d9/0x3e0 [sonypi]
 [<d0ac6a00>] +0x3c0/0x560 [sonypi]
 [<d0ac69e9>] +0x3a9/0x560 [sonypi]
 [<d0ac69df>] +0x39f/0x560 [sonypi]
 [<d0ac69df>] +0x39f/0x560 [sonypi]
 [<d0ac69df>] +0x39f/0x560 [sonypi]
 [<d0ac69dc>] +0x39c/0x560 [sonypi]
 [<d0ac8a00>] +0x0/0x200 [sonypi]
 [<d0954020>] +0x20/0x2a [sonypi]
 [<c012dbf4>] sys_init_module+0xf8/0x1f4
 [<c0108ddf>] syscall_call+0x7/0xb

handlers:
[<d0ac571c>] (sonypi_irq+0x0/0x204 [sonypi])
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
Sony VAIO Jog Dial installed.

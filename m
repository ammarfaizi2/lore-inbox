Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWA2BSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWA2BSY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 20:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWA2BSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 20:18:24 -0500
Received: from xenotime.net ([66.160.160.81]:49901 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750785AbWA2BSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 20:18:24 -0500
Date: Sat, 28 Jan 2006 17:18:41 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rc1 kernel init oops
Message-Id: <20060128171841.6f989958.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to boot 2.6.16-rc1 on a T42 Thinkpad notebook.
No serial port for serial console.  I don't think that networking
is alive yet (for network console ?).

Anyone recognize this?  got patch?

This is just typed in, so could contain a few errors.

Unable to handle kernel NULL pointer dereference at virtual address 00000001
printing eip:
00000001
*pde = 00000000
Oops: 0000 [#1]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:	0
EIP:	0060:[<00000001>]   Not tainted VLI
EFLAGS: 00010202   (2.6.16-rc1)
EIP is at 0x1
<skip reg. dump>
<skip stack dump>
Call trace:
	show_stack_log_lvl+0xa5/0xad
	show_registers+0xf9/0x162
	die+0xfe/0x179
	do_page_fault+0x399/0x4d8
	error_code+0x4f/0x54
	device_register+0x13/0x18
	platform_bus_init+0xd/0x19
	driver_init+0x1c/0x2d
	do_basic_setup+0x12/0x1e
	init+0x95/0x195
	kernel_thread_helper+0x5/0xb
Code:  Bad EIP value.

Thanks,
---
~Randy

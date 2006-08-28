Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWH1UZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWH1UZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWH1UZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:25:18 -0400
Received: from aa003msr.fastwebnet.it ([85.18.95.66]:30689 "EHLO
	aa003msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751463AbWH1UZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:25:16 -0400
Date: Mon, 28 Aug 2006 22:24:13 +0200
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: one more ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Message-ID: <20060828202412.GA5151@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20060826160922.3324a707.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc4-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 04:09:22PM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/
[...]
>  git-acpi.patch

Sorry for reporting separately, I deleted the other thread on the issue.
Here we go:
[    9.386644] PCI: Using ACPI for IRQ routing
[    9.386688] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    9.391209] ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
[    9.391521]  [<c0103a9f>] dump_trace+0x1ef/0x230
[    9.391626]  [<c0103b06>] show_trace_log_lvl+0x26/0x40
[    9.391724]  [<c01042bb>] show_trace+0x1b/0x20
[    9.391820]  [<c01043a4>] dump_stack+0x24/0x30
[    9.391918]  [<c0249f15>] acpi_format_exception+0xa3/0xb0
[    9.392729]  [<c0246fb6>] acpi_ut_status_exit+0x31/0x5e
[    9.393453]  [<c0243352>] acpi_walk_resources+0x10e/0x11b
[    9.394174]  [<c025697e>] acpi_motherboard_add+0x22/0x31
[    9.394977]  [<c0255890>] acpi_bus_driver_init+0x2b/0x7c
[    9.395742]  [<c02568da>] acpi_bus_register_driver+0xa1/0x123
[    9.396507]  [<c0418adb>] acpi_motherboard_init+0x17/0xfb
[    9.397268]  [<c01003d0>] init+0x80/0x290
[    9.397343]  [<c0103593>] kernel_thread_helper+0x7/0x14
[    9.397439]  =======================

full dmesg: http://oioio.altervista.org/linux/dmesg-2.6.18-rc4-mm3-1
config: http://oioio.altervista.org/linux/config-2.6.18-rc4-mm3-1
DSDT: http://oioio.altervista.org/linux/DSDT.aml
      http://oioio.altervista.org/linux/DSDT.dsl
lspci: http://oioio.altervista.org/linux/lspci-v

-- 
mattia
:wq!

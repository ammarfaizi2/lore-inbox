Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWH0G4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWH0G4M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 02:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWH0G4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 02:56:12 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:48354 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750784AbWH0G4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 02:56:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MXsrdqVyGH5Brs4ODkYLRTVrldGdnoIWghy6oFkcYggDWeqpSzt+hczpe1mK6x6kezlGqNvmQDLYouLN1Z/8X/Q5BYnkluLAGJk0uqwT1aVL/nI+7e+HxEVyOlH8P9eyU/o59c46A3s7pIkgZKi6J4jXxUdPIxgKM9lDpCNzPf0=
Message-ID: <a44ae5cd0608262356j29c0234cl198fb207bcad383d@mail.gmail.com>
Date: Sat, 26 Aug 2006 23:56:09 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "akpm@osdl.org" <akpm@osdl.org>
Subject: 2.6.18-rc4-mm3 -- ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
 [dump_trace+100/418] dump_trace+0x64/0x1a2
 [show_trace_log_lvl+18/37] show_trace_log_lvl+0x12/0x25
 [show_trace+13/16] show_trace+0xd/0x10
 [dump_stack+23/25] dump_stack+0x17/0x19
 [acpi_format_exception+162/175] acpi_format_exception+0xa2/0xaf
 [acpi_ut_status_exit+43/88] acpi_ut_status_exit+0x2b/0x58
 [acpi_walk_resources+269/281] acpi_walk_resources+0x10d/0x119
 [acpi_motherboard_add+34/52] acpi_motherboard_add+0x22/0x34
 [acpi_bus_driver_init+42/122] acpi_bus_driver_init+0x2a/0x7a
 [acpi_bus_register_driver+137/248] acpi_bus_register_driver+0x89/0xf8
 [acpi_motherboard_init+23/249] acpi_motherboard_init+0x17/0xf9
 [init+136/512] init+0x88/0x200
 [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10

Leftover inexact backtrace:

 [show_trace_log_lvl+18/37] show_trace_log_lvl+0x12/0x25
 [show_trace+13/16] show_trace+0xd/0x10
 [dump_stack+23/25] dump_stack+0x17/0x19
 [acpi_format_exception+162/175] acpi_format_exception+0xa2/0xaf
 [acpi_ut_status_exit+43/88] acpi_ut_status_exit+0x2b/0x58
 [acpi_walk_resources+269/281] acpi_walk_resources+0x10d/0x119
 [acpi_motherboard_add+34/52] acpi_motherboard_add+0x22/0x34
 [acpi_bus_driver_init+42/122] acpi_bus_driver_init+0x2a/0x7a
 [acpi_bus_register_driver+137/248] acpi_bus_register_driver+0x89/0xf8
 [acpi_motherboard_init+23/249] acpi_motherboard_init+0x17/0xf9
 [init+136/512] init+0x88/0x200
 [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
 =======================

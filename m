Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752110AbWICHAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbWICHAS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 03:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbWICHAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 03:00:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:57573 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752110AbWICHAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 03:00:17 -0400
X-Authenticated: #14349625
Subject: [2.6.18-rc5-mm1 ACPI] Unknown exception code: 0xFFFFFFEA
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
References: <20060901015818.42767813.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 03 Sep 2006 09:09:45 +0000
Message-Id: <1157274585.6304.6.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

My single P4/HT box tossed the below on boot.

	-Mike

ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
 [<c1004089>] dump_trace+0x1d7/0x206
 [<c10040d2>] show_trace_log_lvl+0x1a/0x30
 [<c100484c>] show_trace+0x12/0x14
 [<c100496d>] dump_stack+0x19/0x1b
 [<c1229702>] acpi_format_exception+0xa2/0xaf
 [<c1226824>] acpi_ut_status_exit+0x2b/0x58
 [<c1222cbc>] acpi_walk_resources+0xfd/0x109
 [<c12393ca>] acpi_motherboard_add+0x22/0x32
 [<c123848e>] acpi_bus_driver_init+0x2a/0x7a
 [<c123892c>] acpi_bus_register_driver+0x8b/0xfb
 [<c15ebd20>] acpi_motherboard_init+0xd/0xf9
 [<c10003b1>] init+0x108/0x300
 [<c1003c93>] kernel_thread_helper+0x7/0x14
 =======================
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
 [<c1004089>] dump_trace+0x1d7/0x206
 [<c10040d2>] show_trace_log_lvl+0x1a/0x30
 [<c100484c>] show_trace+0x12/0x14
 [<c100496d>] dump_stack+0x19/0x1b
 [<c1229702>] acpi_format_exception+0xa2/0xaf
 [<c1226824>] acpi_ut_status_exit+0x2b/0x58
 [<c1222cbc>] acpi_walk_resources+0xfd/0x109
 [<c12393ca>] acpi_motherboard_add+0x22/0x32
 [<c123848e>] acpi_bus_driver_init+0x2a/0x7a
 [<c123892c>] acpi_bus_register_driver+0x8b/0xfb
 [<c15ebd2a>] acpi_motherboard_init+0x17/0xf9
 [<c10003b1>] init+0x108/0x300
 [<c1003c93>] kernel_thread_helper+0x7/0x14
 =======================
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
 [<c1004089>] dump_trace+0x1d7/0x206
 [<c10040d2>] show_trace_log_lvl+0x1a/0x30
 [<c100484c>] show_trace+0x12/0x14
 [<c100496d>] dump_stack+0x19/0x1b
 [<c1229702>] acpi_format_exception+0xa2/0xaf
 [<c1226824>] acpi_ut_status_exit+0x2b/0x58
 [<c1222cbc>] acpi_walk_resources+0xfd/0x109
 [<c12393ca>] acpi_motherboard_add+0x22/0x32
 [<c123848e>] acpi_bus_driver_init+0x2a/0x7a
 [<c123892c>] acpi_bus_register_driver+0x8b/0xfb
 [<c15ebd2a>] acpi_motherboard_init+0x17/0xf9
 [<c10003b1>] init+0x108/0x300
 [<c1003c93>] kernel_thread_helper+0x7/0x14
 =======================



-- 
VGER BF report: H 0.00749888

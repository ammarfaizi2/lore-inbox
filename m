Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265025AbUEKXGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbUEKXGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbUEKXGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:06:15 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:18610 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265025AbUEKXGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:06:10 -0400
Message-ID: <40A15C65.8020206@yahoo.es>
Date: Tue, 11 May 2004 19:06:13 -0400
From: Roberto Sanchez <rcsanchez97@yahoo.es>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Possible ACPI/Proc issues in 2.6.6
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Please CC me, as I am not subscribed. ***

I just upgraded to 2.6.6 yestrday and noticed this:

ACPI: Power Button (FF) [PWRF]
Badness in remove_proc_entry at fs/proc/generic.c:685
Call Trace:
  [<c0179870>] remove_proc_entry+0x100/0x150
  [<c028d5c2>] acpi_button_remove_fs+0x4f/0x5f
  [<c028d856>] acpi_button_add+0x22f/0x23e
  [<c029252c>] acpi_bus_driver_init+0x2c/0x8a
  [<c02925e5>] acpi_driver_attach+0x5b/0x98
  [<c02926f0>] acpi_bus_register_driver+0x52/0x5f
  [<c0484838>] acpi_button_init+0x31/0x52
  [<c04727bb>] do_initcalls+0x2b/0xc0
  [<c0125b77>] init_workqueues+0x17/0x60
  [<c01002e0>] init+0x0/0x160
  [<c0100315>] init+0x35/0x160
  [<c010208c>] kernel_thread_helper+0x0/0x14
  [<c0102091>] kernel_thread_helper+0x5/0x14
 

ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (54 C)

I have attached the complete dmesg and kernel config for my machine.
Specs:

Athlon 2500+
nForce2 mobo

-Roberto Sanchez

*** Please CC me, as I am not subscribed. ***

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266423AbUAIHl0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 02:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266426AbUAIHl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 02:41:26 -0500
Received: from p508B10DB.dip0.t-ipconnect.de ([80.139.16.219]:28548 "EHLO
	emil.home") by vger.kernel.org with ESMTP id S266423AbUAIHlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 02:41:24 -0500
From: Markus Kossmann <markus.kossmann@inka.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0:  Disabling IRQ #9
Date: Fri, 9 Jan 2004 08:39:38 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401090839.38733.markus.kossmann@inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I run 2.60 on my PC with Tyan S2462 (AMD 762 MP)  motherboard 
I allways get after some time the message "Disabling IRQ #9"
and the following messages in the syslog :
Jan  8 20:30:44 emil3 kernel: irq 9: nobody cared!
Jan  8 20:30:44 emil3 kernel: Call Trace:
Jan  8 20:30:44 emil3 kernel:  [__report_bad_irq+42/144] __report_bad_irq
+0x2a/0
x90
Jan  8 20:30:44 emil3 kernel:  [<c010e8ca>] __report_bad_irq+0x2a/0x90
Jan  8 20:30:44 emil3 kernel:  [note_interrupt+149/192] note_interrupt
+0x95/0xc0
Jan  8 20:30:44 emil3 kernel:  [<c010e9e5>] note_interrupt+0x95/0xc0
Jan  8 20:30:44 emil3 kernel:  [do_IRQ+278/320] do_IRQ+0x116/0x140
Jan  8 20:30:44 emil3 kernel:  [<c010ec96>] do_IRQ+0x116/0x140
Jan  8 20:30:44 emil3 kernel:  [common_interrupt+24/32] common_interrupt
+0x18/0x
20
Jan  8 20:30:44 emil3 kernel:  [<c010ce1c>] common_interrupt+0x18/0x20
Jan  8 20:30:44 emil3 kernel:  [do_softirq+93/224] do_softirq+0x5d/0xe0
Jan  8 20:30:44 emil3 kernel:  [<c012c19d>] do_softirq+0x5d/0xe0
Jan  8 20:30:44 emil3 kernel:  [do_IRQ+285/320] do_IRQ+0x11d/0x140
Jan  8 20:30:44 emil3 kernel:  [<c010ec9d>] do_IRQ+0x11d/0x140
Jan  8 20:30:44 emil3 kernel:  [common_interrupt+24/32] common_interrupt
+0x18/0x
20
Jan  8 20:30:44 emil3 kernel:  [<c010ce1c>] common_interrupt+0x18/0x20
Jan  8 20:30:44 emil3 kernel:  [default_idle+0/64] default_idle+0x0/0x40
Jan  8 20:30:44 emil3 kernel:  [<c010a030>] default_idle+0x0/0x40
Jan  8 20:30:44 emil3 kernel:  [default_idle+41/64] default_idle+0x29/0x40
Jan  8 20:30:44 emil3 kernel:  [<c010a059>] default_idle+0x29/0x40
Jan  8 20:30:44 emil3 kernel:  [cpu_idle+52/80] cpu_idle+0x34/0x50
Jan  8 20:30:44 emil3 kernel:  [<c010a0e4>] cpu_idle+0x34/0x50
Jan  8 20:30:44 emil3 kernel:  [printk+393/416] printk+0x189/0x1a0
Jan  8 20:30:44 emil3 kernel:  [<c01288a9>] printk+0x189/0x1a0
Jan  8 20:30:44 emil3 kernel:
Jan  8 20:30:44 emil3 kernel: handlers:
Jan  8 20:30:44 emil3 kernel: [acpi_irq+0/22] (acpi_irq+0x0/0x16)
Jan  8 20:30:44 emil3 kernel: [<c01fb426>] (acpi_irq+0x0/0x16)
Jan  8 20:30:44 emil3 kernel: Disabling IRQ #9


What can I do to fix that problem  ? 


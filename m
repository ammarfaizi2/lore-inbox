Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbUA1ADS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 19:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUA1ADS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 19:03:18 -0500
Received: from smtp02.web.de ([217.72.192.151]:15898 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265816AbUA1ADF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 19:03:05 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6.2-rc2] R31 hangs after booting oops
Date: Wed, 28 Jan 2004 01:02:53 +0100
User-Agent: KMail/1.6
Cc: r31@rnbhq.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401280102.53758.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

my Thinkpad R31 stops during the boot-process when I give 'acpi=off' as boot 
option, but on using acpi it boots fine (so when I'm not giving this option).
Unfortunality it has no serial port to capture this oops -- any suggestions 
how to capture it via parallel port or via usb-to-serial cable?

I manually write down some maybe helpfull messages, please tell me, if you 
need more or have an idea how to get a full automatic trace.

Floppy drives(s): fd0 is 1.44M
Unable to hande kernel pointer dereference at virtual address 00000004
 printing eip:
c01449ec
*pde = 00000000
Oops: 0000 [#1]
CPU:	0
EIP:	0060:[<c01449ec>] Not tainted

(I leave out the other numbers and registers)

Process swapper (pid: 0, threadinginfo=c048000 task c941ed60)

(please ask for Stack numbers if needed)

Call Trace: (without all numbers)

drain_array
reap_timer
update_process_times
reap_timer_softirq
do_softirq
common interrrupt
apm_bios_call_simple
apm_do_idle
apm_cpu_idle
_stext
cpu_idle
start_kernel
unknown_bootoption

Kernel panic: Fatal exception in interrrupt
In interrupt handler - not syncing


Thanks in advance for your help,
	Bernd

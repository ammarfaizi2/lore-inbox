Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVBTP4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVBTP4I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 10:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVBTP4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 10:56:08 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:2441 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261858AbVBTP4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 10:56:03 -0500
Date: Sun, 20 Feb 2005 16:56:02 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.6.11rc4: irq 5, nobody cared
Message-ID: <20050220155600.GD5049@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-By: Mon Feb 21 15:46:49 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com (Folkert van Heusden)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My linux laptop says:
irq 5: nobody cared!
 [<c0133044>] __report_bad_irq+0x24/0x90
 [<c0133141>] note_interrupt+0x61/0x90
 [<c0132b2b>] __do_IRQ+0x13b/0x150
 [<c0104a33>] do_IRQ+0x23/0x40
 [<c01031fe>] common_interrupt+0x1a/0x20
 [<c0119dee>] __do_softirq+0x2e/0x80
 [<c0119e67>] do_softirq+0x27/0x30
 [<c0119f35>] irq_exit+0x35/0x40
 [<c0104a38>] do_IRQ+0x28/0x40
 [<c01031fe>] common_interrupt+0x1a/0x20
 [<c011d6c0>] del_timer+0x0/0xb0
 [<c02b1c59>] schedule_timeout+0x69/0xc0
 [<c0138b8f>] __get_free_pages+0x1f/0x40
 [<c011df90>] process_timeout+0x0/0x10
 [<c01633e5>] do_select+0x195/0x2f0
 [<c0163090>] __pollwait+0x0/0xc0
 [<c0128cc0>] autoremove_wake_function+0x0/0x50
 [<c016381e>] sys_select+0x2be/0x4b0
 [<c01194fc>] sys_gettimeofday+0x2c/0x70
 [<c010308f>] syscall_call+0x7/0xb
handlers:
[<dc8d35f0>] (usb_hcd_irq+0x0/0x60 [usbcore])
[<dca21690>] (ndis_irq_th+0x0/0xf0 [ndiswrapper])
Disabling IRQ #5

Does anyone care? :-)


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE

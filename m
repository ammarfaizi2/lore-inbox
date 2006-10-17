Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWJQPrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWJQPrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWJQPrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:47:43 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:28578 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1751160AbWJQPrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:47:42 -0400
From: CIJOML <cijoml@volny.cz>
To: linux-kernel@vger.kernel.org
Subject: [Bug 185] Sometimes kernel freezes sometime lists OOPS - hostap_cs
Date: Tue, 17 Oct 2006 17:47:34 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610171747.34177.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

can anybody take a look at this bug?

http://hostap.epitest.fi/bugz/show_bug.cgi?id=185

pccard: PCMCIA card inserted into slot 1
pcmcia: registering new device pcmcia1.0
ieee80211_crypt: registered algorithm 'NULL'
hostap_cs: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
hostap_cs: Registered netdevice wifi0
IRQ handler type mismatch for IRQ 3
 [<c0138840>] setup_irq+0x1aa/0x1c3
 [<fcb357cf>] prism2_interrupt+0x0/0x719 [hostap_cs]
 [<c01388d3>] request_irq+0x7a/0x97
 [<c0257f54>] pcmcia_request_irq+0xec/0x1fa
 [<fcb357cf>] prism2_interrupt+0x0/0x719 [hostap_cs]
 [<fcc0647f>] hostap_ap_tx_cb_assoc+0x0/0xc1 [hostap]
 [<fcb3483e>] hostap_cs_probe+0x990/0xd8d [hostap_cs]
 [<c019ad14>] journal_end_buffer_io_sync+0x0/0x1a
 [<c019ad14>] journal_end_buffer_io_sync+0x0/0x1a
 [<c019ad14>] journal_end_buffer_io_sync+0x0/0x1a
 [<c01ede69>] bit_cursor+0x4eb/0x502
 [<c01b87c4>] avc_has_perm+0x39/0x43
 [<c0112c37>] __activate_task+0x1c/0x28
 [<c02c9c7a>] schedule+0x484/0x52b
 [<c01d4948>] kobject_get+0x12/0x17
 [<c02576da>] pcmcia_device_probe+0x83/0x121
 [<c023d5a0>] driver_probe_device+0x45/0x8f
 [<c023d641>] __driver_attach+0x0/0x5c
 [<c023d678>] __driver_attach+0x37/0x5c
 [<c023d088>] bus_for_each_dev+0x46/0x6c
 [<c023d502>] driver_attach+0x14/0x18
 [<c023d641>] __driver_attach+0x0/0x5c
 [<c023cd32>] bus_add_driver+0x67/0x106
 [<fcb1a01f>] init_prism2_pccard+0x1f/0x23 [hostap_cs]
 [<c012e7fb>] sys_init_module+0x142b/0x15c7
 [<c0102c4b>] syscall_call+0x7/0xb
IRQ handler type mismatch for IRQ 5
 [<c0138840>] setup_irq+0x1aa/0x1c3
 [<fcb357cf>] prism2_interrupt+0x0/0x719 [hostap_cs]
 [<c01388d3>] request_irq+0x7a/0x97
 [<c0257f54>] pcmcia_request_irq+0xec/0x1fa
 [<fcb357cf>] prism2_interrupt+0x0/0x719 [hostap_cs]
 [<fcc0647f>] hostap_ap_tx_cb_assoc+0x0/0xc1 [hostap]
 [<fcb3483e>] hostap_cs_probe+0x990/0xd8d [hostap_cs]
 [<c019ad14>] journal_end_buffer_io_sync+0x0/0x1a
 [<c019ad14>] journal_end_buffer_io_sync+0x0/0x1a
 [<c019ad14>] journal_end_buffer_io_sync+0x0/0x1a
 [<c01ede69>] bit_cursor+0x4eb/0x502
 [<c01b87c4>] avc_has_perm+0x39/0x43
 [<c0112c37>] __activate_task+0x1c/0x28
 [<c02c9c7a>] schedule+0x484/0x52b
 [<c01d4948>] kobject_get+0x12/0x17
 [<c02576da>] pcmcia_device_probe+0x83/0x121
 [<c023d5a0>] driver_probe_device+0x45/0x8f
 [<c023d641>] __driver_attach+0x0/0x5c
 [<c023d678>] __driver_attach+0x37/0x5c
 [<c023d088>] bus_for_each_dev+0x46/0x6c
 [<c023d502>] driver_attach+0x14/0x18
 [<c023d641>] __driver_attach+0x0/0x5c
 [<c023cd32>] bus_add_driver+0x67/0x106
 [<fcb1a01f>] init_prism2_pccard+0x1f/0x23 [hostap_cs]
 [<c012e7fb>] sys_init_module+0x142b/0x15c7
 [<c0102c4b>] syscall_call+0x7/0xb
IRQ handler type mismatch for IRQ 3
 [<c0138840>] setup_irq+0x1aa/0x1c3
 [<fcb357cf>] prism2_interrupt+0x0/0x719 [hostap_cs]
 [<c01388d3>] request_irq+0x7a/0x97
 [<c0257f54>] pcmcia_request_irq+0xec/0x1fa
 [<fcb357cf>] prism2_interrupt+0x0/0x719 [hostap_cs]
 [<fcc0647f>] hostap_ap_tx_cb_assoc+0x0/0xc1 [hostap]
 [<fcb3483e>] hostap_cs_probe+0x990/0xd8d [hostap_cs]
 [<c019ad14>] journal_end_buffer_io_sync+0x0/0x1a
 [<c019ad14>] journal_end_buffer_io_sync+0x0/0x1a
 [<c019ad14>] journal_end_buffer_io_sync+0x0/0x1a
 [<c01ede69>] bit_cursor+0x4eb/0x502
 [<c01b87c4>] avc_has_perm+0x39/0x43
 [<c0112c37>] __activate_task+0x1c/0x28
 [<c02c9c7a>] schedule+0x484/0x52b
 [<c01d4948>] kobject_get+0x12/0x17
 [<c02576da>] pcmcia_device_probe+0x83/0x121
 [<c023d5a0>] driver_probe_device+0x45/0x8f
 [<c023d641>] __driver_attach+0x0/0x5c
 [<c023d678>] __driver_attach+0x37/0x5c
 [<c023d088>] bus_for_each_dev+0x46/0x6c
 [<c023d502>] driver_attach+0x14/0x18
 [<c023d641>] __driver_attach+0x0/0x5c
 [<c023cd32>] bus_add_driver+0x67/0x106
 [<fcb1a01f>] init_prism2_pccard+0x1f/0x23 [hostap_cs]
 [<c012e7fb>] sys_init_module+0x142b/0x15c7
 [<c0102c4b>] syscall_call+0x7/0xb
IRQ handler type mismatch for IRQ 5
 [<c0138840>] setup_irq+0x1aa/0x1c3
 [<fcb357cf>] prism2_interrupt+0x0/0x719 [hostap_cs]
 [<c01388d3>] request_irq+0x7a/0x97
 [<c0257f54>] pcmcia_request_irq+0xec/0x1fa
 [<fcb357cf>] prism2_interrupt+0x0/0x719 [hostap_cs]
 [<fcc0647f>] hostap_ap_tx_cb_assoc+0x0/0xc1 [hostap]
 [<fcb3483e>] hostap_cs_probe+0x990/0xd8d [hostap_cs]
 [<c019ad14>] journal_end_buffer_io_sync+0x0/0x1a
 [<c019ad14>] journal_end_buffer_io_sync+0x0/0x1a
 [<c019ad14>] journal_end_buffer_io_sync+0x0/0x1a
 [<c01ede69>] bit_cursor+0x4eb/0x502
 [<c01b87c4>] avc_has_perm+0x39/0x43
 [<c0112c37>] __activate_task+0x1c/0x28
 [<c02c9c7a>] schedule+0x484/0x52b
 [<c01d4948>] kobject_get+0x12/0x17
 [<c02576da>] pcmcia_device_probe+0x83/0x121
 [<c023d5a0>] driver_probe_device+0x45/0x8f
 [<c023d641>] __driver_attach+0x0/0x5c
 [<c023d678>] __driver_attach+0x37/0x5c
 [<c023d088>] bus_for_each_dev+0x46/0x6c
 [<c023d502>] driver_attach+0x14/0x18
 [<c023d641>] __driver_attach+0x0/0x5c
 [<c023cd32>] bus_add_driver+0x67/0x106
 [<fcb1a01f>] init_prism2_pccard+0x1f/0x23 [hostap_cs]
 [<c012e7fb>] sys_init_module+0x142b/0x15c7
 [<c0102c4b>] syscall_call+0x7/0xb
pcmcia: request for exclusive IRQ could not be fulfilled.
pcmcia: the driver needs updating to supported shared IRQ lines.
hostap_cs: index 0x01: , irq 10, io 0x3100-0x313f
prism2_hw_init: initialized in 232 ms
wifi0: NIC: id=0x800c v1.0.0
wifi0: PRI: id=0x15 v1.1.1
wifi0: STA: id=0x1f v1.8.2
wifi0: registered netdevice wlan0


Thanks a lot

Michal

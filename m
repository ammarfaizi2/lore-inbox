Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUFHQrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUFHQrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 12:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbUFHQrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 12:47:53 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:64971 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265250AbUFHQru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 12:47:50 -0400
Message-ID: <40C5EDAA.9040808@t-online.de>
Date: Tue, 08 Jun 2004 18:47:38 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc3: NVidia graphics problem
References: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: XKmcq-ZEgeHsjXrzc1uvCbgjWd8G67c2Ywe9OKZVlTcG0j2oo1Q96e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure whether it is allowed to report problems with
NVidia graphics support to this list. I just want to make
sure that this hiccup isn't lost:

Jun  8 15:34:08 styx kernel: Badness in pci_find_subsys at drivers/pci/search.c:167
Jun  8 15:34:08 styx kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
Jun  8 15:34:08 styx kernel:  [pci_find_subsys+212/224] pci_find_subsys+0xd4/0xe0
Jun  8 15:34:08 styx kernel:  [pci_find_device+49/64] pci_find_device+0x31/0x40
Jun  8 15:34:08 styx kernel:  [pci_find_slot+41/80] pci_find_slot+0x29/0x50
Jun  8 15:34:08 styx kernel:  [pg0+555404950/1069666304] os_pci_init_handle+0x35/0x62 [nvidia]
Jun  8 15:34:08 styx kernel:  [pg0+553916511/1069666304] _nv001243rm+0x1f/0x24 [nvidia]
Jun  8 15:34:08 styx kernel:  [pg0+554642013/1069666304] _nv003797rm+0xa9/0x128 [nvidia]
Jun  8 15:34:08 styx kernel:  [pg0+555087009/1069666304] _nv001490rm+0x55/0xe4 [nvidia]
Jun  8 15:34:08 styx kernel:  [pg0+555254100/1069666304] _nv000816rm+0x334/0x384 [nvidia]
Jun  8 15:34:08 styx kernel:  [pg0+555252815/1069666304] _nv000809rm+0x2f/0x34 [nvidia]
Jun  8 15:34:08 styx kernel:  [pg0+554637136/1069666304] _nv003816rm+0xf0/0x104 [nvidia]
Jun  8 15:34:08 styx kernel:  [pg0+554631182/1069666304] _nv003795rm+0x6ea/0xaec [nvidia]
Jun  8 15:34:08 styx kernel:  [pg0+555072423/1069666304] _nv001476rm+0x277/0x45c [nvidia]
Jun  8 15:34:08 styx kernel:  [pg0+553927578/1069666304] _nv000896rm+0x4a/0x64 [nvidia]
Jun  8 15:34:08 styx kernel:  [pg0+553933748/1069666304] rm_isr_bh+0xc/0x10 [nvidia]
Jun  8 15:34:08 styx kernel:  [pg0+555395476/1069666304] nv_kern_isr_bh+0x11/0x15 [nvidia]
Jun  8 15:34:08 styx kernel:  [tasklet_action+70/112] tasklet_action+0x46/0x70
Jun  8 15:34:08 styx kernel:  [__do_softirq+140/144] __do_softirq+0x8c/0x90
Jun  8 15:34:08 styx kernel:  [do_softirq+43/48] do_softirq+0x2b/0x30
Jun  8 15:34:08 styx kernel:  [do_IRQ+213/256] do_IRQ+0xd5/0x100
Jun  8 15:34:08 styx kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jun  8 15:34:08 styx kernel:  [do_select+359/640] do_select+0x167/0x280
Jun  8 15:34:08 styx kernel:  [sys_select+686/1184] sys_select+0x2ae/0x4a0
Jun  8 15:34:08 styx kernel:  [syscall_call+7/11] syscall_call+0x7/0xb


Regards

Harri

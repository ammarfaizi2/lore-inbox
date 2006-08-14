Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWHNQOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWHNQOu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWHNQOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:14:50 -0400
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:25064
	"EHLO schlidder.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S1751086AbWHNQOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:14:49 -0400
Message-ID: <44E0A176.8070907@svs.Informatik.Uni-Oldenburg.de>
Date: Mon, 14 Aug 2006 18:14:46 +0200
From: Philipp Matthias Hahn <pmhahn@svs.Informatik.Uni-Oldenburg.de>
Organization: Carl von Ossietzky University Coldenburg
User-Agent: Debian Thunderbird 1.0.2 (X11/20060724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: openipmi-developer@lists.sourceforge.net
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Soft lockup (and reboot): IPMI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

While playing with "openipmigui", the server just rebooted with the
following last message:

BUG: soft lockup detected on CPU#0!
<c0103416> show_trace+0xd/0xf
<c01034e5> dump_stack+0x15/0x17
<c01382b0> softlockup_tick+0x9d/0xae
<c012190a> run_local_timers+0x12/0x14
<c0121748> update_process_times+0x3c/0x61
<c010e1d9> smp_apic_timer_interrupt+0x57/0x5f
<c010307c> apic_timer_interrupt+0x1c/0x24
<f8aa8783> ipmi_thread+0x43/0x71 [ipmi_si]
<c0129e62> kthread+0x78/0xa0
<c0100e31> kernel_thread_helper+0x5/0xb

Any idea on what went wrong?

BYtE
Philipp
-- 
      Dipl.-Inform. Philipp.Hahn@informatik.uni-oldenburg.de
      Abteilung Systemsoftware und verteilte Systeme, Fk. II
Carl von Ossietzky Universitaet Oldenburg, 26111 Oldenburg, Germany
    http://www.svs.informatik.uni-oldenburg.de/contact/pmhahn/
      Telefon: +49 441 798-2866    Telefax: +49 441 798-2756

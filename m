Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWALPWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWALPWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbWALPWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:22:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:36298 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030449AbWALPWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:22:38 -0500
From: Marco Menzel <debian@snowyweb.net>
To: linux-kernel@vger.kernel.org
Subject: soft lockup 2.6.15 with NR_CPUS=16 on quad xeon dual core HT
Date: Thu, 12 Jan 2006 16:22:25 +0100
User-Agent: KMail/1.9.1
Organization: snowyweb.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121622.25820.debian@snowyweb.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:7f40f4fd9d20900191ac22136b4a1374
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

some problem with DELL PowerEdge 6850 with four Dual-Core 64-bit Intel
Xeon Processor 7020, 2.66GHz, 667MHz front side bus, 2x1MB L2 cache.

INIT: version 2.86 booting
BUG: soft lockup detected on CPU#0!
Pid: 1148,comm:      modprobe
EIP: 0060:[<c010ffdd>] CPU: 0
EIP is at flush_tlb_others+0x8d/0xd6
EFLAGS: 00000206 Not tainted (2.6.15)
EAX: 000008fd EBX: f7bb9680 ECX: f7bb9680 EDX: 00000400
ESI: f7bb9680 EDI: f7bcf850 EBP: f7bcf73c DS: 007b ES: 0077b
CR0: 8005003b CR2: b7fa9000 CR3: 37a48280 CR4: 000006f0
[<c01100ba>] flush_tlb_mm+0x49/0x8d
[<c014f583>] unmap_region+0x108/0x144
[<c014f8b9>] do_munmap+0x108/0x144
[<c014f8b9>] sys_munmap+0x45/0x66
[<c0102d41>] syscall_call+0x7/0xb

Is somebody using such Hardware with kernel 2.6.x with HT?

Thanks,
Marco

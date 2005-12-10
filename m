Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbVLJVXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbVLJVXw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 16:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbVLJVXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 16:23:52 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:20378 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1161035AbVLJVXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 16:23:51 -0500
Message-ID: <439B475F.2050901@ens-lyon.org>
Date: Sat, 10 Dec 2005 16:23:43 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc5 bad page with fglrx on Radeon X300
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>There's a rc5 out there now, largely because I'm going to be out of email 
>contact for the next week, and while I wish people were religiously 
>testing all the nightly snapshots, the fact is, you guys don't.
>
>So making the current state available as an -rc makes sense, even though 
>not a lot has changed since -rc4.
>
>That said, if you didn't test -rc4 _either_ - shame on you, and please 
>do test -rc5.
>  
>
Does anybody out there have ATI drivers working on Radeon X300
on 2.6.15-rc5 (or -rc[234]) ? They released fglrx 8.20.8 on december 8th.
I thought they would have fixed the driver for 2.6.15.
But, I still get bad page and X programs freezing.

Thanks,
Brice


fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies,
Starnberg, GERMANY' taints kernel.
[fglrx] Maximum main memory to use for locked dma buffers: 431 MBytes.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[fglrx] module loaded - fglrx 8.20.8 [Dec  6 2005] on minor 0
[fglrx] ACPI power management is initialized.
 [<c0140817>] bad_page+0x87/0xc0
 [<c01410f8>] free_hot_cold_page+0x48/0x110
 [<c014b62c>] zap_pte_range+0x10c/0x250
 [<c014b866>] unmap_page_range+0xf6/0x130
 [<c014b97b>] unmap_vmas+0xdb/0x200
 [<c0150163>] unmap_region+0x93/0x130
 [<c01504f7>] do_munmap+0x107/0x150
 [<c015058c>] sys_munmap+0x4c/0x70
 [<c0103105>] syscall_call+0x7/0xb
[fglrx] free  PCIe = 54804480
[fglrx] max   PCIe = 54804480
[fglrx] free  LFB = 47099904
[fglrx] max   LFB = 47099904
[fglrx] free  Inv = 0
[fglrx] max   Inv = 0
[fglrx] total Inv = 0
[fglrx] total TIM = 0
[fglrx] total FB  = 0
[fglrx] total PCIe = 16384


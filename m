Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbUKHIqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbUKHIqx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 03:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbUKHIqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 03:46:53 -0500
Received: from mout1.freenet.de ([194.97.50.132]:64423 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261787AbUKHIo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 03:44:58 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH 2.6] fix address passing of unknown_bootoption
Date: Mon, 8 Nov 2004 09:43:43 +0100
User-Agent: KMail/1.7.1
References: <200411072247.39841.mbuesch@freenet.de> <20041107164244.34ad8bfd.akpm@osdl.org> <418EC395.3070002@osdl.org>
In-Reply-To: <418EC395.3070002@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200411080943.43734.mbuesch@freenet.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Randy.Dunlap" <rddunlap@osdl.org>:
> > hm, I don't know what happened there.  Maybe the value of pm_idle in
> > cpu_idle() is garbage.  Or maybe not.
> 
> Zwane and someone else had patches for that happening IIRC
> a month or 2 back.
> I can dig them out if wanted... Michael, want to try?


Yes, sure. Please.



oh, one second before pressing the send button for this mail I had
another panic. 8-}

Unable to handle kernel paging request at virtual address 00020800
 printing eip:
00020800
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: ipv6 ohci_hcd tuner tvaudio msp3400 bttv video_buf btcx_risc nvidia ehci_hcd uhci_hcd usbcore intel_agp agpgart evdev
CPU:    0
EIP:    0060:[<00020800>]    Tainted: P   VLI
EFLAGS: 00010296   (2.6.9-ck3-ac6-nozeroram) 
EIP is at 0x20800
eax: 00000001   ebx: b03e8000   ecx: 00000001   edx: 00000001
esi: 00099100   edi: b01020a7   ebp: 0045c007   esp: b03e9fec
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=b03e8000 task=b034cac0)
Stack: b03ea81c 000000db b03ea310 b04162a0 b0100211 
Call Trace:
 [<b03ea81c>] start_kernel+0x139/0x152
 [<b03ea310>] unknown_bootoption+0x0/0x171
Code:  Bad EIP value.
 <0>Kernel panic - not syncing: Attempted to kill the idle task!

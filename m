Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUJLOcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUJLOcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUJLOb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:31:58 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:12117 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264503AbUJLO3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:29:35 -0400
Message-ID: <592474b04101207292d8a6983@mail.gmail.com>
Date: Tue, 12 Oct 2004 16:29:22 +0200
From: =?ISO-8859-1?Q?Fabio_Codec=E0?= <fabiocode@gmail.com>
Reply-To: =?ISO-8859-1?Q?Fabio_Codec=E0?= <fabiocode@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic with 2.6.9-rc3-mm3 and 2.6.9-rc4-mm1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all, I have a problem with the two kernel in the subject...I use
gentoo and during an emerge operation I get the following message from
the kernel:

Oct 12 13:50:20 brutus Unable to handle kernel paging request at
virtual address 0001771c
Oct 12 13:50:20 brutus printing eip:
Oct 12 13:50:20 brutus c011c386
Oct 12 13:50:20 brutus *pde = 00000000
Oct 12 13:50:20 brutus Oops: 0002 [#1]
Oct 12 13:50:20 brutus Modules linked in: ohci_hcd 8139too mii
ohci1394 ieee1394 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd
snd_page_alloc ehci_hcd uhci_hcd intel_agp agpgart usbcore
Oct 12 13:50:20 brutus CPU:    0
Oct 12 13:50:20 brutus EIP:    0060:[<c011c386>]    Not tainted VLI
Oct 12 13:50:20 brutus EFLAGS: 00010082   (2.6.9-rc4-mm1) 
Oct 12 13:50:20 brutus EIP is at profile_hit+0x26/0x30
Oct 12 13:50:20 brutus eax: 0001771c   ebx: ded78a40   ecx: 00000000  
edx: 00000000
Oct 12 13:50:20 brutus esi: ffffffea   edi: 00000000   ebp: dd0c7fbc  
esp: dd0c7f8c
Oct 12 13:50:20 brutus ds: 007b   es: 007b   ss: 0068
Oct 12 13:50:20 brutus Process regxpcom (pid: 7796,
threadinfo=dd0c6000 task=ded78a40)
Oct 12 13:50:20 brutus Stack: c0118d31 00000002 c0105fef 00000004
c05247a0 c0118f46 bfffe45c 00000082
Oct 12 13:50:20 brutus 00000000 00001e74 b7f5ae20 b7f58060 dd0c6000
c0105fef 00001e74 00000000
Oct 12 13:50:20 brutus bfffe45c b7f5ae20 b7f58060 bfffe438 0000009c
0000007b 0000007b 0000009c
Oct 12 13:50:20 brutus Call Trace:
Oct 12 13:50:20 brutus [<c0118d31>] setscheduler+0xb1/0x1e0
Oct 12 13:50:20 brutus [<c0105fef>] syscall_call+0x7/0xb
Oct 12 13:50:20 brutus [<c0118f46>] sys_sched_getparam+0x56/0x90
Oct 12 13:50:20 brutus [<c0105fef>] syscall_call+0x7/0xb
Oct 12 13:50:20 brutus Code: 04 83 c4 08 c3 8b 44 24 08 8b 0d 2c 9a 52
c0 8b 15 28 9a 52 c0 2d 28 02 10 c0 d3 e8 4a 39 c2 0f 46 c2 8b 15 24
9a 52 c0 8d 04 82 <ff> 00 c3 8d b4 26 00 00 00 00 b8 da ff ff ff c3 8d
76 00 8d bc


I don't what can do...anyone can help me?
Thanks to all!

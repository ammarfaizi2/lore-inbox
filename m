Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUHDSfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUHDSfp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 14:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUHDSfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 14:35:45 -0400
Received: from mk-smarthost-3.mail.uk.tiscali.com ([212.74.114.39]:30736 "EHLO
	mk-smarthost-3.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id S267314AbUHDSfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 14:35:43 -0400
From: David M <eseol@tiscali.co.uk>
To: linux-kernel@vger.kernel.org
Date: Wed, 4 Aug 2004 19:46:45 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2 
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041946.45236.eseol@tiscali.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello 

the xruns below happen pretty regular, however i dont think this is just 
related to the 02 patch, this happens with standard 2.6.7 kernel.  I assume 
it has something to do with drm and mga? 

Dave

XRUN: pcmC0D0p
 [<d48ef1f7>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<c011046a>] scheduler_tick+0x20a/0x450
 [<d48a175a>] snd_ice1712_interrupt+0x1da/0x270 [snd_ice1712]
 [<c0118079>] generic_handle_IRQ_event+0x49/0x80
 [<c0105b0b>] do_IRQ+0x9b/0x140
 [<c0104234>] common_interrupt+0x18/0x20
 [<c010d734>] delay_tsc+0x14/0x20
 [<c01934c2>] __delay+0x12/0x20
 [<d4925218>] mga_do_dma_flush+0x48/0x1c0 [mga]
 [<d49262d9>] mga_dma_flush+0x109/0x130 [mga]
 [<d4921004>] mga_ioctl+0xe4/0x160 [mga]
 [<c015cce0>] sys_ioctl+0x100/0x270
 [<c01040c7>] syscall_call+0x7/0xb
XRUN: pcmC0D0p
 [<d48ef1f7>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<c011c764>] update_process_times+0x44/0x50
 [<d48a175a>] snd_ice1712_interrupt+0x1da/0x270 [snd_ice1712]
 [<c011ca40>] do_timer+0xe0/0xf0
 [<c0118079>] generic_handle_IRQ_event+0x49/0x80
 [<c0105b0b>] do_IRQ+0x9b/0x140
 [<c0104234>] common_interrupt+0x18/0x20
 [<c010d734>] delay_tsc+0x14/0x20
 [<c01934c2>] __delay+0x12/0x20
 [<d4925218>] mga_do_dma_flush+0x48/0x1c0 [mga]
 [<d49262d9>] mga_dma_flush+0x109/0x130 [mga]
 [<d4921004>] mga_ioctl+0xe4/0x160 [mga]
 [<c015cce0>] sys_ioctl+0x100/0x270
 [<c01040c7>] syscall_call+0x7/0xb

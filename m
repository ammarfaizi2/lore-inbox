Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSJLOUa>; Sat, 12 Oct 2002 10:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261223AbSJLOUa>; Sat, 12 Oct 2002 10:20:30 -0400
Received: from services.cam.org ([198.73.180.252]:984 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S261218AbSJLOU2>;
	Sat, 12 Oct 2002 10:20:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.41-mm3
Date: Sat, 12 Oct 2002 10:21:01 -0400
User-Agent: KMail/1.4.3
References: <3DA683F4.944DFC11@digeo.com> <200210110837.12089.tomlins@cam.org>
In-Reply-To: <200210110837.12089.tomlins@cam.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210121021.01704.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 11, 2002 08:37 am, Ed Tomlinson wrote:
> Hi,
>
> I get this opps just after boot - the box was sitting waiting for me to
> login and start X.  Nothing unsual in the boot log - same config I have
> been using

Note that 2.5.42-mm2 is starting correctly.  Not sure what happened here..

Ed

PS. email problems at this end...


> -------------
> oscar login: Unable to handle kernel paging request at virtual address
> 8978408f printing eip:
> c012b364
> *pde = 00000000
> Oops: 0002
> af_packet snd-seq-midi snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss
> snd-mixer-oss snd-cs46xx snd-pcm snd-timer snd-rawmidi snd-seq-device
> snd-ac97-codec snd soundcore gameport softdog matroxfb_base matroxfb_g450
> matroxfb_DAC1064 g450_pll matroxfb_accel matroxfb_misc fbcon-cfb16
> fbcon-cfb8 fbcon-cfb24 fbcon-cfb32 mga agpgart pppoe pppox ipchains msdos
> fat sd_mod floppy dummy bsd_comp ppp_generic slhc parport_pc lp parport
> ipip smbfs binfmt_aout autofs4 cdrom via-rhine mii tulip crc32 usb-storage
> scsi_mod hid pl2303 usbserial CPU:    0
> EIP:    0060:[<c012b364>]    Not tainted
> EFLAGS: 00010012
> EIP is at free_block+0x50/0xe4
> eax: 8978408b   ebx: dc2ad240   ecx: dc2bd000   edx: 558ba445
> esi: dffec21c   edi: 00000004   ebp: dffec228   esp: c0295eec
> ds: 0068   es: 0068   ss: 0068
> Process swapper (pid: 0, threadinfo=c0294000 task=c02596c0)
> Stack: 00000008 c173a400 c173a410 dffec21c c0295f18 c173a420 c012b86e
> dffec21c c173a410 00000008 c0353b1c c0294000 c02ab480 00000000 dffec408
> c0294000 dffec288 c011b6ef 00000000 00000000 c032fc60 fffffffe c032fc60
> c012b7ec Call Trace:
>  [<c012b86e>] reap_timer_fnc+0x82/0x478
>  [<c011b6ef>] run_timer_tasklet+0xe7/0x130
>  [<c012b7ec>] reap_timer_fnc+0x0/0x478
>  [<c01187e8>] tasklet_hi_action+0x3c/0x60
>  [<c011860b>] do_softirq+0x5b/0xac
>  [<c0108560>] do_IRQ+0xfc/0x114
>  [<c01052e0>] default_idle+0x0/0x28
>  [<c0105000>] stext+0x0/0x50
>  [<c01070e8>] common_interrupt+0x18/0x20
>  [<c01052e0>] default_idle+0x0/0x28
>  [<c0105000>] stext+0x0/0x50
>  [<c0105303>] default_idle+0x23/0x28
>  [<c0105374>] cpu_idle+0x28/0x38
>  [<c010504d>] stext+0x4d/0x50
>
> Code: 89 50 04 89 02 2b 59 0c 89 d8 31 d2 f7 76 30 89 c3 8b 41 14
>  <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
>
> Hope this helps,
> Ed Tomlinson


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVJWNEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVJWNEq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 09:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVJWNEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 09:04:46 -0400
Received: from g0-3.r01.cn.tts.khb.cisco.kht.ru ([194.85.113.7]:32735 "EHLO
	rc-vaio.rcdiostrouska.com") by vger.kernel.org with ESMTP
	id S1750724AbVJWNEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 09:04:46 -0400
Subject: Re: oops in 2.6.14-rc3
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
Reply-To: sasa.ostrouska@volja.net
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051008091416.6038ebaa@localhost>
References: <1128731551.8004.2.camel@rc-vaio.rcdiostrouska.com>
	 <20051008091416.6038ebaa@localhost>
Content-Type: text/plain
Date: Sun, 23 Oct 2005 15:05:44 +0200
Message-Id: <1130072744.7496.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr. Ornati, can you please help me now ?

Oct 20 03:01:50 rc-vaio kernel: Unable to handle kernel paging request
at virtual address f8e43706
Oct 20 03:01:50 rc-vaio kernel:  printing eip:
Oct 20 03:01:50 rc-vaio kernel: c01eaf49
Oct 20 03:01:50 rc-vaio kernel: *pde = 01bae067
Oct 20 03:01:50 rc-vaio kernel: Oops: 0000 [#1]
Oct 20 03:01:50 rc-vaio kernel: PREEMPT
Oct 20 03:01:50 rc-vaio kernel: Modules linked in: snd_pcm_oss
snd_mixer_oss lp ipv6 uhci_hcd joydev parport_pc parport psmouse pcspkr
rtc sis_agp shpchp pci_hotplug i2c_sis96x i2c_core usb_storage
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd
snd_page_alloc ohci_hcd ehci_hcd usbcore sis900 ohci1394 ieee1394 tsdev
pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core ide_scsi
agpgart
Oct 20 03:01:50 rc-vaio kernel: CPU:    0
Oct 20 03:01:50 rc-vaio kernel: EIP:    0060:[<c01eaf49>]    Not tainted
VLI
Oct 20 03:01:50 rc-vaio kernel: EFLAGS: 00010297   (2.6.14-rc4)
Oct 20 03:01:50 rc-vaio kernel: EIP is at vsnprintf+0x369/0x500
Oct 20 03:01:50 rc-vaio kernel: eax: f8e43706   ebx: 0000000a   ecx:
f8e43706   edx: fffffffe
Oct 20 03:01:50 rc-vaio kernel: esi: f596e11f   edi: 00000000   ebp:
f596efff   esp: f398ded0
Oct 20 03:01:50 rc-vaio kernel: ds: 007b   es: 007b   ss: 0068
Oct 20 03:01:50 rc-vaio kernel: Process grep (pid: 7529,
threadinfo=f398c000 task=f6122030)
Oct 20 03:01:50 rc-vaio kernel: Stack: 000003e1 00000000 00000010
00000004 00000002 00000001 ffffffff ffffffff
Oct 20 03:01:50 rc-vaio kernel:        00000eed f596e113 c0331532
f596e113 f665c380 f665c380 00000113 c017c52f
Oct 20 03:01:50 rc-vaio kernel:        f398df44 c0330829 f7fe0ca0
c011fcb4 f665c380 c0331520 00000000 c0330829
Oct 20 03:01:50 rc-vaio kernel: Call Trace:
Oct 20 03:01:50 rc-vaio kernel:  [<c017c52f>] seq_printf+0x2f/0x60
Oct 20 03:01:50 rc-vaio kernel:  [<c011fcb4>] r_show+0x84/0x90
Oct 20 03:01:50 rc-vaio kernel:  [<c017c0f1>] seq_read+0x221/0x290
Oct 20 03:01:50 rc-vaio kernel:  [<c015bae7>] vfs_read+0xc7/0x180
Oct 20 03:01:50 rc-vaio kernel:  [<c015be77>] sys_read+0x47/0x80
Oct 20 03:01:50 rc-vaio kernel:  [<c0103005>] syscall_call+0x7/0xb
Oct 20 03:01:50 rc-vaio kernel: Code: 00 83 cf 01 89 44 24 1c eb bc 8b
44 24 40 8b 54 24 18 83 44 24 40 04 8b 08 b8 fe 14 34 c0 81 f9 ff 0f 00
00 0f 46 c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83
e7 10 89 c3 75 20
Oct 20 03:01:50 rc-vaio kernel:  <6>note: grep[7529] exited with
preempt_count 1

Thank you very much for your help.
Rgds
Sasa Ostrouska



On Sat, 2005-10-08 at 09:14 +0200, Paolo Ornati wrote:
> On Sat, 08 Oct 2005 02:32:31 +0200
> Sasa Ostrouska <sasa.ostrouska@volja.net> wrote:
> 
> > Oct  8 02:20:33 rc-vaio kernel: EIP:    0060:[<c01eac19>]    Tainted: P
> 
> http://www.tux.org/lkml/#s1-18
> 
> "Some vendors distribute binary modules (i.e. modules without available
> source code under a free software license). As the source is not freely
> available, any bugs uncovered whilst such modules are loaded cannot be
> investigated by the kernel hackers. All problems discovered whilst such
> a module is loaded must be reported to the vendor of that module, not
> the Linux kernel hackers and the linux-kernel mailing list. The
> tainting scheme is used to identify bug reports from kernels with
> binary modules loaded: such kernels are marked as "tainted" by means of
> the MODULE_LICENSE tag. If a module is loaded that does not specify an
> approved license, the kernel is marked as tainted. The canonical list
> of approved license strings is in linux/include/linux/module.h. "oops"
> reports marked as tainted are of no use to the kernel developers and
> will be ignored. A warning is output when such a module is loaded. Note
> that you may come across module source that is under a compatible
> license, but does not have a suitable MODULE_LICENSE tag. If you see a
> warning from modprobe or insmod for a module under a compatible
> license, please report this bug to the maintainers of the module, so
> that they can add the necessary tag."
> 


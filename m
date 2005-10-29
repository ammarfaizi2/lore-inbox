Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVJ2LEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVJ2LEA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVJ2LEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:04:00 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33029 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750930AbVJ2LD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:03:59 -0400
Date: Sat, 29 Oct 2005 13:03:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Patrick Useldinger <uselpa@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: segmentation fault when accessing /proc/ioports
Message-ID: <20051029110358.GI4180@stusta.de>
References: <b2992ee70510290209h26c1fd6ex92fd137cd2c9d747@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2992ee70510290209h26c1fd6ex92fd137cd2c9d747@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 11:09:25AM +0200, Patrick Useldinger wrote:

> Hello,

Hi Patrick,

>...
> [code]
> Oct 29 10:32:33 slackw kernel: mtrr: 0xd0000000,0x4000000 overlaps
> existing 0xd0000000,0x2000000
> Oct 29 10:32:45 slackw kernel: Unable to handle kernel paging request
> at virtual address f8ce5a0a
> Oct 29 10:32:45 slackw kernel:  printing eip:
> Oct 29 10:32:45 slackw kernel: c01dbcfe
> Oct 29 10:32:45 slackw kernel: *pde = 36523067
> Oct 29 10:32:45 slackw kernel: *pte = 00000000
> Oct 29 10:32:45 slackw kernel: Oops: 0000 [#1]
> Oct 29 10:32:45 slackw kernel: PREEMPT
> Oct 29 10:32:45 slackw kernel: Modules linked in: vmnet vmmon sch_sfq
> snd_pcm_oss snd_mixer_oss ipv6 ipt_state ipt_REJECT ipt_LOG
> ip_conntrack_ftp ip_conntrack iptable_filter ip_tables uhci_hcd
> sis_agp shpchp i2c_sis96x i2c_core snd_intel8x0 snd_ac97_codec snd_pcm
> snd_timer snd soundcore snd_page_alloc ohci_hcd ehci_hcd ohci1394
> ieee1394 8139too mii pcmcia firmware_class yenta_socket rsrc_nonstatic
> pcmcia_core dm_mod evdev agpgart lp parport_pc parport psmouse
> Oct 29 10:32:45 slackw kernel: CPU:    0
> Oct 29 10:32:45 slackw kernel: EIP:    0060:[<c01dbcfe>]    Tainted: P      VLI
>...

Does this problem happen without ever loading the vmware modules since 
booting?

It it doesn't, please complain to vmware.

> I have read on the kernel mailing lists that this is due to drivers
> not properly unloading, so I won't post an lsmod.

You've already sent it above.

> Thanks for your attention,
> -pu

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


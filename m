Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWHBSPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWHBSPT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWHBSPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:15:18 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:445 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932122AbWHBSPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:15:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ckHou6sqEy7/kzJA1ZnbQc8zrk/6FMAZYHb0K5v02vk9DdMeqP6+7pF1Srb9yvgnDw2RzPRP0CELpXHTjn/laBq0wNHd9bHneLViXT48lA2SdzoUklih6ZF8XOWwdmM3LnQr6Okorvw63PlfST8ZqFa1QbuzWETFWRzoUDgbuxM=
Message-ID: <6bffcb0e0608021115s65f81224td8d852b931a9b787@mail.gmail.com>
Date: Wed, 2 Aug 2006 20:15:12 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: mm snapshot broken-out-2006-08-02-00-27.tar.gz uploaded
Cc: "Dave Jones" <davej@codemonkey.org.uk>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <200608020728.k727SegM012704@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608020728.k727SegM012704@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> The mm snapshot broken-out-2006-08-02-00-27.tar.gz has been uploaded to
>
>    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-02-00-27.tar.gz
>
> It contains the following patches against 2.6.18-rc3:
>

This was reported, git-cpufreq.patch breaks this.

Aug  2 19:55:52 ltg01-fedora kernel: p4-clockmod: P4/Xeon(TM) CPU
On-Demand Clock Modulation available
Aug  2 19:55:52 ltg01-fedora kernel: ip_tables: (C) 2000-2006
Netfilter Core Team
Aug  2 19:55:52 ltg01-fedora kernel: BUG: warning at
/usr/src/linux-work4/kernel/cpu.c:56/unlock_cpu_hotplug()
Aug  2 19:55:52 ltg01-fedora kernel:  [<c010425e>] show_trace_log_lvl+0x58/0x152
Aug  2 19:55:52 ltg01-fedora kernel:  [<c01049a7>] show_trace+0xd/0x10
Aug  2 19:55:52 ltg01-fedora kernel:  [<c0104a6f>] dump_stack+0x19/0x1b
Aug  2 19:55:52 ltg01-fedora kernel:  [<c013ddca>] unlock_cpu_hotplug+0x43/0x7c
Aug  2 19:55:52 ltg01-fedora kernel:  [<fd94a1e8>]
store_speed+0x8f/0x9b [cpufreq_userspace]
Aug  2 19:55:52 ltg01-fedora kernel:  [<c029f46d>] store+0x37/0x48
Aug  2 19:55:52 ltg01-fedora kernel:  [<c01a87e7>] sysfs_write_file+0xaa/0xd3
Aug  2 19:55:52 ltg01-fedora kernel:  [<c0171e5f>] vfs_write+0xcd/0x179
Aug  2 19:55:52 ltg01-fedora kernel:  [<c0172508>] sys_write+0x3b/0x71
Aug  2 19:55:52 ltg01-fedora kernel:  [<c0103181>] sysenter_past_esp+0x56/0x8d
Aug  2 19:55:52 ltg01-fedora kernel: DWARF2 unwinder stuck at
sysenter_past_esp+0x56/0x8d
Aug  2 19:55:52 ltg01-fedora kernel: Leftover inexact backtrace:
Aug  2 19:55:52 ltg01-fedora kernel:  [<c01049a7>] show_trace+0xd/0x10
Aug  2 19:55:52 ltg01-fedora kernel:  [<c0104a6f>] dump_stack+0x19/0x1b
Aug  2 19:55:52 ltg01-fedora kernel:  [<c013ddca>] unlock_cpu_hotplug+0x43/0x7c
Aug  2 19:55:52 ltg01-fedora kernel:  [<fd94a1e8>]
store_speed+0x8f/0x9b [cpufreq_userspace]
Aug  2 19:55:52 ltg01-fedora kernel:  [<c029f46d>] store+0x37/0x48
Aug  2 19:55:52 ltg01-fedora kernel:  [<c01a87e7>] sysfs_write_file+0xaa/0xd3
Aug  2 19:55:52 ltg01-fedora kernel:  [<c0171e5f>] vfs_write+0xcd/0x179
Aug  2 19:55:52 ltg01-fedora kernel:  [<c0172508>] sys_write+0x3b/0x71
Aug  2 19:55:52 ltg01-fedora kernel:  [<c0103181>] sysenter_past_esp+0x56/0x8d
Aug  2 19:55:52 ltg01-fedora kernel: Netfilter messages via NETLINK v0.30.

Here is something new, previous mm snapshot was fine

Aug  2 19:56:08 ltg01-fedora kernel: ------------[ cut here ]------------
Aug  2 19:56:08 ltg01-fedora kernel: kernel BUG at
/usr/src/linux-work4/mm/shmem.c:1228!
Aug  2 19:56:08 ltg01-fedora kernel: invalid opcode: 0000 [#1]
Aug  2 19:56:08 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
Aug  2 19:56:08 ltg01-fedora kernel: last sysfs file:
/devices/system/cpu/cpu0/cpufreq/scaling_governor
Aug  2 19:56:08 ltg01-fedora kernel: Modules linked in: ipv6 w83627hf
hwmon_vid hwmon i2c_isa af_packet ip_conntrack_netbios
_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp
iptable_filter ip_tables x_tables cpufreq_userspace p4_clockmod spe
edstep_lib binfmt_misc thermal processor fan container evdev
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_
oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss sk98lin
snd_mixer_oss snd_pcm skge snd_timer snd soundcore snd_pag
e_alloc i2c_i801 intel_agp ide_cd agpgart cdrom rtc unix
Aug  2 19:56:08 ltg01-fedora kernel: CPU:    1
Aug  2 19:56:08 ltg01-fedora kernel: EIP:    0060:[<c016afed>]    Not
tainted VLI
Aug  2 19:56:08 ltg01-fedora kernel: EFLAGS: 00013202   (2.6.18-rc3-mm1 #99)
Aug  2 19:56:08 ltg01-fedora kernel: EIP is at shmem_nopage+0x40/0xd8
Aug  2 19:56:08 ltg01-fedora kdm[1962]: Display :0 cannot be opened
Aug  2 19:56:08 ltg01-fedora kdm[1962]: Unable to fire up local
display :0; disabling.
Aug  2 19:56:08 ltg01-fedora kernel: eax: 00000001   ebx: 00000000
ecx: c0369848   edx: 00000001
Aug  2 19:56:09 ltg01-fedora kernel: esi: f7125120   edi: f7125120
ebp: f5f2ef28   esp: f5f2ef08
Aug  2 19:56:09 ltg01-fedora kernel: ds: 007b   es: 007b   ss: 0068
Aug  2 19:56:10 ltg01-fedora kernel: Process X (pid: 1964, ti=f5f2e000
task=f5accfa0 task.ti=f5f2e000)
Aug  2 19:56:10 ltg01-fedora kernel: Stack: f5f2ef78 00000000 f5f2ef4c
f5af46e0 00000000 c0372660 f7125120 f7125120
Aug  2 19:56:10 ltg01-fedora kernel:        f5f2ef88 c015f5af 00000000
00000001 00000000 f7125120 c767d774 00000000
Aug  2 19:56:10 ltg01-fedora kernel:        f5b3e000 f5f2ef74 00003246
00000001 00000002 00000000 c0116d05 c767d7d4
Aug  2 19:56:11 ltg01-fedora kernel: Call Trace:
Aug  2 19:56:12 ltg01-fedora kernel:  [<c015f5af>] __handle_mm_fault+0x2fe/0x963
Aug  2 19:56:12 ltg01-fedora kernel:  [<c0116db6>] do_page_fault+0x1be/0x4f0
Aug  2 19:56:13 ltg01-fedora kernel:  [<c0103d85>] error_code+0x39/0x40
Aug  2 19:56:14 ltg01-fedora kernel: DWARF2 unwinder stuck at
error_code+0x39/0x40
Aug  2 19:56:14 ltg01-fedora kernel: Leftover inexact backtrace:
Aug  2 19:56:14 ltg01-fedora kernel:  [<c01043e4>] show_stack_log_lvl+0x8c/0x97
Aug  2 19:56:14 ltg01-fedora kernel:  [<c010456c>] show_registers+0x17d/0x211
Aug  2 19:56:14 ltg01-fedora kernel:  [<c01047c2>] die+0x1c2/0x2d8
Aug  2 19:56:14 ltg01-fedora kernel:  [<c0104954>] do_trap+0x7c/0x96
Aug  2 19:56:14 ltg01-fedora kernel:  [<c01051a5>] do_invalid_op+0x89/0x93
Aug  2 19:56:14 ltg01-fedora kernel:  [<c0103d85>] error_code+0x39/0x40
Aug  2 19:56:15 ltg01-fedora kernel:  [<c015f5af>] __handle_mm_fault+0x2fe/0x963
Aug  2 19:56:15 ltg01-fedora kernel:  [<c0116db6>] do_page_fault+0x1be/0x4f0
Aug  2 19:56:15 ltg01-fedora kernel:  [<c0103d85>] error_code+0x39/0x40
Aug  2 19:56:15 ltg01-fedora kernel: Code: 08 8b 40 28 89 45 ec c7 45
f0 00 00 00 00 8b 56 14 81 f2 00 00 00 04 c1 ea 1a 83
e2 01 b8 48 98 36 c0 e8 1b 29 09 00 85 c0 74 08 <0f> 0b cc 04 89 da 31
c0 2b 5e 04 c1 eb 0c 03 5e 44 89 5d e4 c7
Aug  2 19:56:15 ltg01-fedora kernel: EIP: [<c016afed>]
shmem_nopage+0x40/0xd8 SS:ESP 0068:f5f2ef08

(gdb) list *0xc016afed
0xc016afed is in shmem_nopage (/usr/src/linux-work4/mm/shmem.c:1228).
1223            struct inode *inode = vma->vm_file->f_dentry->d_inode;
1224            struct page *page = NULL;
1225            unsigned long idx;
1226            int error;
1227
1228            BUG_ON(!(vma->vm_flags & VM_CAN_INVALIDATE));
1229
1230            idx = (address - vma->vm_start) >> PAGE_SHIFT;
1231            idx += vma->vm_pgoff;
1232            idx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;

I will revert
fix-the-race-between-invalidate_inode_pages-and-do_no_page.patch
fix-the-race-between-invalidate_inode_pages-and-do_no_page-tidy.patch
and see what will happen.

http://www.stardust.webpages.pl/files/mm/2.6.18-rc3-mm1/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

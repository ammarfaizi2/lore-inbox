Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbWHNOCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbWHNOCx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 10:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWHNOCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 10:02:53 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:280 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751607AbWHNOCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 10:02:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=roLKMwJqOZLP0m2rnLkXXtGXpxEyexNyvMBY7h5DOZQkPrZPrUjxfCnZtTalBL+18rRBEUDYIU0w4A5/VzwMJoOM65iuBPEdXVtsF91k+WpmOqMmOv5laudO/DYe3/07PFCRNY5C8z7Sl4eoBeHK1Pw1fRA7lVfp/oIHAnfIyWY=
Message-ID: <6bffcb0e0608140702i70fb82ffr99a3ad6fdfbfd55e@mail.gmail.com>
Date: Mon, 14 Aug 2006 16:02:52 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060813012454.f1d52189.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
>

Aug 14 15:35:10 ltg01-fedora kernel: BUG: unable to handle kernel
paging request at virtual address fffeffbf
Aug 14 15:35:10 ltg01-fedora kernel:  printing eip:
Aug 14 15:35:10 ltg01-fedora kernel: c013d539
Aug 14 15:35:10 ltg01-fedora kernel: *pde = 00004067
Aug 14 15:35:10 ltg01-fedora kernel: *pte = 00000000
Aug 14 15:35:10 ltg01-fedora kernel: Oops: 0000 [#1]
Aug 14 15:35:10 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
Aug 14 15:35:10 ltg01-fedora kernel: last sysfs file:
/devices/platform/i2c-9191/9191-0290/temp2_input
Aug 14 15:35:10 ltg01-fedora kernel: Modules linked in: ipv6 w83627hf
hwmon_vid hwmon i2c_isa af_packet ip_conntrack_netbios
_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp
iptable_filter ip_tables x_tables cpufreq_userspace p4_clockmod spe
edstep_lib binfmt_misc thermal processor fan container evdev
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_
oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss snd_pcm sk98lin snd_timer skge snd soundcore snd_pag
e_alloc ide_cd intel_agp agpgart cdrom i2c_i801 rtc unix
Aug 14 15:35:10 ltg01-fedora kernel: CPU:    1
Aug 14 15:35:10 ltg01-fedora kernel: EIP:    0060:[<c013d539>]    Not
tainted VLI
Aug 14 15:35:10 ltg01-fedora kernel: EFLAGS: 00210286   (2.6.18-rc4-mm1 #97)
Aug 14 15:35:10 ltg01-fedora kernel: EIP is at futex_wake+0x9c/0xcb
Aug 14 15:35:10 ltg01-fedora kernel: eax: 0808c000   ebx: c0670a60
ecx: d3a1dfa2   edx: fffeffbf
Aug 14 15:35:10 ltg01-fedora kernel: esi: 00000000   edi: fffeffbf
ebp: f4896f64   esp: f4896f40
Aug 14 15:35:10 ltg01-fedora kernel: ds: 007b   es: 007b   ss: 0068
Aug 14 15:35:10 ltg01-fedora kernel: Process firefox-bin (pid: 2210,
ti=f4896000 task=f3d180f0 task.ti=f4896000)
Aug 14 15:35:10 ltg01-fedora kernel: Stack: c0670a80 00000001 0808c000
f4302e74 00000044 ffffffe7 0808c044 bf8f35b0
Aug 14 15:35:10 ltg01-fedora kernel:        00000000 f4896f7c c013ed39
00000001 0808c044 7fffffff bf8f35b0 f4896fb4
Aug 14 15:35:10 ltg01-fedora kernel:        c013ee84 7fffffff bf8f35b0
00000000 bf8f3528 00000000 f4896fa8 00000000
Aug 14 15:35:10 ltg01-fedora kernel: Call Trace:
Aug 14 15:35:10 ltg01-fedora kernel:  [<c013ed39>] do_futex+0x3c/0x92
Aug 14 15:35:10 ltg01-fedora kernel:  [<c013ee84>] sys_futex+0xf5/0x101
Aug 14 15:35:11 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
Aug 14 15:35:11 ltg01-fedora kernel:  [<b7f1d410>] 0xb7f1d410
Aug 14 15:35:11 ltg01-fedora kernel:  [<c0103fc1>] show_trace_log_lvl+0x12/0x22
Aug 14 15:35:11 ltg01-fedora kernel:  [<c0104067>] show_stack_log_lvl+0x87/0x8f
Aug 14 15:35:11 ltg01-fedora kernel:  [<c0104203>] show_registers+0x151/0x1d8
Aug 14 15:35:11 ltg01-fedora kernel:  [<c010444d>] die+0x120/0x1f0
Aug 14 15:35:11 ltg01-fedora kernel:  [<c01185cf>] do_page_fault+0x49d/0x580
Aug 14 15:35:11 ltg01-fedora kernel:  [<c0303ba9>] error_code+0x39/0x40
Aug 14 15:35:11 ltg01-fedora kernel:  [<c013ed39>] do_futex+0x3c/0x92
Aug 14 15:35:11 ltg01-fedora kernel:  [<c013ee84>] sys_futex+0xf5/0x101
Aug 14 15:35:11 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
Aug 14 15:35:11 ltg01-fedora kernel:  =======================
Aug 14 15:35:11 ltg01-fedora kernel: Code: 45 e8 39 41 04 75 22 8b 45
ec 39 41 08 75 1a 83 7a 48 00 74 07 be ea ff ff ff eb
16 89 d0 46 e8 00 fd ff ff 3b 75 e0 7d 09 89 fa <8b> 3f 3b 55 dc eb c0
89 d8 e8 bd 60 1c 00 89 e0 25 00 f0 ff ff
Aug 14 15:35:11 ltg01-fedora kernel: EIP: [<c013d539>]
futex_wake+0x9c/0xcb SS:ESP 0068:f4896f40
Aug 14 15:35:11 ltg01-fedora kernel:  <6>note: firefox-bin[2210]
exited with preempt_count 1
Aug 14 15:35:11 ltg01-fedora kernel: BUG: sleeping function called
from invalid context at /usr/src/linux-mm/mm/slab.c:2989
Aug 14 15:35:11 ltg01-fedora kernel: in_atomic():1, irqs_disabled():1
Aug 14 15:35:11 ltg01-fedora kernel:  [<c0103e41>] dump_trace+0x70/0x176
Aug 14 15:35:11 ltg01-fedora kernel:  [<c0103fc1>] show_trace_log_lvl+0x12/0x22
Aug 14 15:35:11 ltg01-fedora kernel:  [<c0103fde>] show_trace+0xd/0xf
Aug 14 15:35:11 ltg01-fedora kernel:  [<c01040b0>] dump_stack+0x17/0x19
Aug 14 15:35:11 ltg01-fedora kernel:  [<c011ec0c>] __might_sleep+0x92/0x9a
Aug 14 15:35:11 ltg01-fedora kernel:  [<c01731ba>] kmem_cache_zalloc+0x27/0xe7
Aug 14 15:35:11 ltg01-fedora kernel:  [<c0154b73>]
taskstats_exit_alloc+0x30/0x6e
Aug 14 15:35:11 ltg01-fedora kernel:  [<c012455e>] do_exit+0x1a3/0x5cd
Aug 14 15:35:11 ltg01-fedora kernel:  [<c0104515>] die+0x1e8/0x1f0
Aug 14 15:35:11 ltg01-fedora kernel:  [<c01185cf>] do_page_fault+0x49d/0x580
Aug 14 15:35:11 ltg01-fedora kernel:  [<c0303ba9>] error_code+0x39/0x40
Aug 14 15:35:11 ltg01-fedora kernel:  [<c013d539>] futex_wake+0x9c/0xcb
Aug 14 15:35:11 ltg01-fedora kernel:  [<c013ed39>] do_futex+0x3c/0x92
Aug 14 15:35:12 ltg01-fedora kernel:  [<c013ee84>] sys_futex+0xf5/0x101
Aug 14 15:35:12 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
Aug 14 15:35:12 ltg01-fedora kernel:  [<b7f1d410>] 0xb7f1d410
Aug 14 15:35:12 ltg01-fedora kernel:  [<c0103fc1>] show_trace_log_lvl+0x12/0x22
Aug 14 15:35:12 ltg01-fedora kernel:  [<c0103fde>] show_trace+0xd/0xf
Aug 14 15:35:12 ltg01-fedora kernel:  [<c01040b0>] dump_stack+0x17/0x19
Aug 14 15:35:12 ltg01-fedora kernel:  [<c011ec0c>] __might_sleep+0x92/0x9a
Aug 14 15:35:12 ltg01-fedora kernel:  [<c01731ba>] kmem_cache_zalloc+0x27/0xe7
Aug 14 15:35:12 ltg01-fedora kernel:  [<c0154b73>]
taskstats_exit_alloc+0x30/0x6e
Aug 14 15:35:12 ltg01-fedora kernel:  [<c012455e>] do_exit+0x1a3/0x5cd
Aug 14 15:35:12 ltg01-fedora kernel:  [<c0104515>] die+0x1e8/0x1f0
Aug 14 15:35:12 ltg01-fedora kernel:  [<c01185cf>] do_page_fault+0x49d/0x580
Aug 14 15:35:12 ltg01-fedora kernel:  [<c0303ba9>] error_code+0x39/0x40
Aug 14 15:35:12 ltg01-fedora kernel:  [<c013ed39>] do_futex+0x3c/0x92
Aug 14 15:35:12 ltg01-fedora kernel:  [<c013ee84>] sys_futex+0xf5/0x101
Aug 14 15:35:12 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
Aug 14 15:35:12 ltg01-fedora kernel:  =======================
Aug 14 15:35:20 ltg01-fedora kernel: BUG: soft lockup detected on CPU#0!
Aug 14 15:35:20 ltg01-fedora kernel:  [<c0103e41>] dump_trace+0x70/0x176
Aug 14 15:35:20 ltg01-fedora kernel:  [<c0103fc1>] show_trace_log_lvl+0x12/0x22
Aug 14 15:35:20 ltg01-fedora kernel:  [<c0103fde>] show_trace+0xd/0xf
Aug 14 15:35:20 ltg01-fedora kernel:  [<c01040b0>] dump_stack+0x17/0x19
Aug 14 15:35:20 ltg01-fedora kernel:  [<c0150ff3>] softlockup_tick+0xca/0xde
Aug 14 15:35:20 ltg01-fedora kernel:  [<c012ad52>] run_local_timers+0x12/0x14
Aug 14 15:35:20 ltg01-fedora kernel:  [<c012abaa>]
update_process_times+0x40/0x65
Aug 14 15:35:20 ltg01-fedora kernel:  [<c0113989>]
smp_apic_timer_interrupt+0x6d/0x75
Aug 14 15:35:20 ltg01-fedora kernel:  [<c0103c5a>]
apic_timer_interrupt+0x2a/0x30
Aug 14 15:35:20 ltg01-fedora kernel:  [<c01f81c3>] delay_tsc+0xe/0x17
Aug 14 15:35:20 ltg01-fedora kernel:  [<c01f8200>] __delay+0x9/0xb
Aug 14 15:35:20 ltg01-fedora kernel:  [<c0204aed>] __spin_lock_debug+0x46/0x94
Aug 14 15:35:20 ltg01-fedora kernel:  [<c0204be3>] _raw_spin_lock+0xa8/0xbe
Aug 14 15:35:20 ltg01-fedora kernel:  [<c030359c>] _spin_lock+0x2a/0x2f
Aug 14 15:35:20 ltg01-fedora kernel:  [<c013d4f3>] futex_wake+0x56/0xcb
Aug 14 15:35:20 ltg01-fedora kernel:  [<c013ed39>] do_futex+0x3c/0x92
Aug 14 15:35:20 ltg01-fedora kernel:  [<c013ee84>] sys_futex+0xf5/0x101
Aug 14 15:35:20 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
Aug 14 15:35:20 ltg01-fedora kernel:  [<b7f1d410>] 0xb7f1d410
Aug 14 15:35:20 ltg01-fedora kernel:  [<c0103fc1>] show_trace_log_lvl+0x12/0x22
Aug 14 15:35:20 ltg01-fedora kernel:  [<c0103fde>] show_trace+0xd/0xf
Aug 14 15:35:21 ltg01-fedora kernel:  [<c01040b0>] dump_stack+0x17/0x19
Aug 14 15:35:21 ltg01-fedora kernel:  [<c0150ff3>] softlockup_tick+0xca/0xde
Aug 14 15:35:21 ltg01-fedora kernel:  [<c012ad52>] run_local_timers+0x12/0x14
Aug 14 15:35:21 ltg01-fedora kernel:  [<c012abaa>]
update_process_times+0x40/0x65
Aug 14 15:35:21 ltg01-fedora kernel:  [<c0113989>]
smp_apic_timer_interrupt+0x6d/0x75
Aug 14 15:35:21 ltg01-fedora kernel:  [<c0103c5a>]
apic_timer_interrupt+0x2a/0x30
Aug 14 15:35:21 ltg01-fedora kernel:  [<c01f8200>] __delay+0x9/0xb
Aug 14 15:35:21 ltg01-fedora kernel:  [<c0204aed>] __spin_lock_debug+0x46/0x94
Aug 14 15:35:21 ltg01-fedora kernel:  [<c0204be3>] _raw_spin_lock+0xa8/0xbe
Aug 14 15:35:21 ltg01-fedora kernel:  [<c030359c>] _spin_lock+0x2a/0x2f
Aug 14 15:35:21 ltg01-fedora kernel:  [<c013d4f3>] futex_wake+0x56/0xcb
Aug 14 15:35:21 ltg01-fedora kernel:  [<c013ed39>] do_futex+0x3c/0x92
Aug 14 15:35:21 ltg01-fedora kernel:  [<c013ee84>] sys_futex+0xf5/0x101
Aug 14 15:35:21 ltg01-fedora kernel:  [<c010312d>] sysenter_past_esp+0x56/0x8d
Aug 14 15:35:21 ltg01-fedora kernel:  =======================

0xc013d539 is in futex_wake (/usr/src/linux-mm/kernel/futex.c:671).
666
667             hb = hash_futex(&key);
668             spin_lock(&hb->lock);
669             head = &hb->chain;
670
671             list_for_each_entry_safe(this, next, head, list) {
672                     if (match_futex (&this->key, &key)) {
673                             if (this->pi_state) {
674                                     ret = -EINVAL;
675                                     break;

Here is a config file
http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm1/frontline/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

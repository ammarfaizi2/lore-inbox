Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbWB1We2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWB1We2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWB1We1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:34:27 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:36283 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932664AbWB1We0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:34:26 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc5-mm1
Date: Tue, 28 Feb 2006 23:34:04 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
References: <20060228042439.43e6ef41.akpm@osdl.org>
In-Reply-To: <20060228042439.43e6ef41.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602282334.05360.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 13:24, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm1/
> 
> 
> - A large procfs rework from Eric Biederman.
> 
> - The swap prefetching patch is back.

With this kernel something that causes the appended trace to appear happens on
my box (Asus L5D, 1 CPU, x86-64) 100% of the time during boot.

Greetings,
Rafael


usbcore: registered new driver usbserial
usbserial: USB Serial support registered for generic
usbcore: registered new driver usbserial_generic
usbserial: USB Serial Driver core
BUG: warning at kernel/fork.c:113/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c2b>{__put_task_struct+59}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:114/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c5d>{__put_task_struct+109}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:113/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c2b>{__put_task_struct+59}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:114/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c5d>{__put_task_struct+109}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:113/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c2b>{__put_task_struct+59}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:114/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c5d>{__put_task_struct+109}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:113/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c2b>{__put_task_struct+59}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:114/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c5d>{__put_task_struct+109}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:113/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c2b>{__put_task_struct+59}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:114/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c5d>{__put_task_struct+109}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:113/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c2b>{__put_task_struct+59}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:114/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c5d>{__put_task_struct+109}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:113/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c2b>{__put_task_struct+59}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:114/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c5d>{__put_task_struct+109}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:113/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c2b>{__put_task_struct+59}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
BUG: warning at kernel/fork.c:114/__put_task_struct()

Call Trace: <IRQ> <ffffffff80229c5d>{__put_task_struct+109}
       <ffffffff80226f60>{__put_task_struct_cb+16} <ffffffff8023faa4>{__rcu_process_callbacks+340}
       <ffffffff8023fb47>{rcu_process_callbacks+23} <ffffffff80231fa8>{tasklet_action+72}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
general protection fault: 0000 [1] PREEMPT
last sysfs file: /class/vc/vcsa2/dev
CPU 0
Modules linked in: usbserial asus_acpi thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device af_packet p
cmcia firmware_class ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core usbhid sk98lin snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_
pcm ip6t_REJECT xt_tcpudp snd_timer snd ipt_REJECT xt_state soundcore iptable_mangle snd_page_alloc iptable_nat ip_nat iptable_filter i2c_n
force2 ip6table_mangle i2c_core ehci_hcd ohci_hcd ip_conntrack ip_tables ip6table_filter ip6_tables x_tables ipv6 parport_pc lp parport dm_
mod
Pid: 820, comm: kjournald Not tainted 2.6.16-rc5-mm1 #70
RIP: 0010:[<ffffffff8046747c>] <ffffffff8046747c>{schedule+1164}
RSP: 0000:ffff810001c53c38  EFLAGS: 00010007
RAX: 0000000000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 949494959493a4ca
RDX: ffff810027ce1050 RSI: 0000000000000000 RDI: ffff810027ce1050
RBP: ffff810001c53c98 R08: ffff810001a83040 R09: 0000000000000009
R10: 00000000ffffffff R11: 0000000000000001 R12: ffff81002c8de4c8
R13: ffff81002fdf72f8 R14: ffff810001a83040 R15: 000000000000390b
FS:  00002adb23959b00(0000) GS:ffffffff8068d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002b5b92aa91de CR3: 0000000027329000 CR4: 00000000000006e0
Process kjournald (pid: 820, threadinfo ffff810001c52000, task ffff81002fdf7090)
Stack: ffff81002fdf7090 ffff810027ce1050 ffff810001c53d18 ffff810001f2af10
       ffff810001c53c78 ffff810001f2af10 ffff810001c53c78 ffff810001c53d08
       ffff810001c53d18 0000000000000002
Call Trace: <ffffffff804676df>{io_schedule+15} <ffffffff8027efeb>{sync_buffer+59}
       <ffffffff80468015>{__wait_on_bit_lock+69} <ffffffff8027efb0>{sync_buffer+0}
       <ffffffff8027efb0>{sync_buffer+0} <ffffffff804680c8>{out_of_line_wait_on_bit_lock+120}
       <ffffffff80242690>{wake_bit_function+0} <ffffffff8027e574>{__lock_buffer+36}
       <ffffffff8027fdc1>{ll_rw_block+65} <ffffffff8030a3ab>{journal_commit_transaction+1659}
       <ffffffff804697d4>{_spin_unlock_irq+20} <ffffffff8046981d>{_spin_unlock_irqrestore+29}
       <ffffffff8030e5c3>{kjournald+339} <ffffffff80242520>{autoremove_wake_function+0}
       <ffffffff8030e470>{kjournald+0} <ffffffff80242309>{kthread+217}
       <ffffffff804697d4>{_spin_unlock_irq+20} <ffffffff80228929>{schedule_tail+73}
       <ffffffff8020a85e>{child_rip+8} <ffffffff80242230>{kthread+0}
       <ffffffff8020a856>{child_rip+0}

Code: 0f ab 83 d8 02 00 00 48 8b 53 48 48 b8 ff ff ff 7f ff ff ff
RIP <ffffffff8046747c>{schedule+1164} RSP <ffff810001c53c38>
 <0>BUG: spinlock recursion on CPU#0, kjournald/820
 lock: ffffffff80613400, .magic: dead4ead, .owner: kjournald/820, .owner_cpu: 0

Call Trace: <IRQ> <ffffffff80354555>{spin_bug+165} <ffffffff803547c1>{_raw_spin_lock+81}
       <ffffffff80469837>{_spin_unlock_irqrestore+55} <ffffffff804693ee>{_spin_lock+30}
       <ffffffff80469837>{_spin_unlock_irqrestore+55} <ffffffff80228367>{try_to_wake_up+55}
       <ffffffff8022849d>{default_wake_function+13} <ffffffff80227463>{__wake_up_common+67}
       <ffffffff802274e3>{__wake_up+67} <ffffffff8023e900>{delayed_work_timer_fn+0}
       <ffffffff8023e42d>{__queue_work+93} <ffffffff8023e929>{delayed_work_timer_fn+41}
       <ffffffff80236e39>{run_timer_softirq+361} <ffffffff802322e4>{__do_softirq+84}
       <ffffffff8020abae>{call_softirq+30} <ffffffff8020c7d4>{do_softirq+52}
       <ffffffff8023215f>{irq_exit+63} <ffffffff8020c781>{do_IRQ+65}
       <ffffffff8020a232>{ret_from_intr+0} <EOI> <ffffffff804697cf>{_spin_unlock_irq+15}
       <ffffffff804697c9>{_spin_unlock_irq+9} <ffffffff80468df6>{__down_read+54}
       <ffffffff8023c2c2>{blocking_notifier_call_chain+34}
       <ffffffff8022dae5>{profile_task_exit+21} <ffffffff8022f1e5>{do_exit+37}
       <ffffffff8046981d>{_spin_unlock_irqrestore+29} <ffffffff8020b5a4>{die+84}
       <ffffffff8020bae0>{do_general_protection+272} <ffffffff8020a6a5>{error_exit+0}
       <ffffffff8046747c>{schedule+1164} <ffffffff80467468>{schedule+1144}
       <ffffffff804676df>{io_schedule+15} <ffffffff8027efeb>{sync_buffer+59}
       <ffffffff80468015>{__wait_on_bit_lock+69} <ffffffff8027efb0>{sync_buffer+0}
       <ffffffff8027efb0>{sync_buffer+0} <ffffffff804680c8>{out_of_line_wait_on_bit_lock+120}
       <ffffffff80242690>{wake_bit_function+0} <ffffffff8027e574>{__lock_buffer+36}
       <ffffffff8027fdc1>{ll_rw_block+65} <ffffffff8030a3ab>{journal_commit_transaction+1659}
       <ffffffff804697d4>{_spin_unlock_irq+20} <ffffffff8046981d>{_spin_unlock_irqrestore+29}
       <ffffffff8030e5c3>{kjournald+339} <ffffffff80242520>{autoremove_wake_function+0}
       <ffffffff8030e470>{kjournald+0} <ffffffff80242309>{kthread+217}
       <ffffffff804697d4>{_spin_unlock_irq+20} <ffffffff80228929>{schedule_tail+73}
       <ffffffff8020a85e>{child_rip+8} <ffffffff80242230>{kthread+0}
       <ffffffff8020a856>{child_rip+0}
NMI Watchdog detected LOCKUP on CPU 0
CPU 0
Modules linked in: usbserial asus_acpi thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device af_packet p
cmcia firmware_class ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core usbhid sk98lin snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_
pcm ip6t_REJECT xt_tcpudp snd_timer snd ipt_REJECT xt_state soundcore iptable_mangle snd_page_alloc iptable_nat ip_nat iptable_filter i2c_n
force2 ip6table_mangle i2c_core ehci_hcd ohci_hcd ip_conntrack ip_tables ip6table_filter ip6_tables x_tables ipv6 parport_pc lp parport dm_
mod
Pid: 820, comm: kjournald Not tainted 2.6.16-rc5-mm1 #70
RIP: 0010:[<ffffffff80354817>] <ffffffff80354817>{_raw_spin_lock+167}
RSP: 0000:ffffffff80606d68  EFLAGS: 00000006
RAX: 000000006b1712ca RBX: ffffffff80613400 RCX: 00000000006da909
RDX: 0000000001b6a424 RSI: ffffffff804a674b RDI: 0000000000000001
RBP: ffffffff80606d88 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000000 R11: 000000000000000a R12: 000000001b82fd67
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000086
FS:  00002adb23959b00(0000) GS:ffffffff8068d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002b5b92aa91de CR3: 0000000027329000 CR4: 00000000000006e0
Process kjournald (pid: 820, threadinfo ffff810001c52000, task ffff81002fdf7090)
Stack: ffffffff80469837 ffffffff80613400 ffff81002fd2db40 ffff810001c47090
       ffffffff80606da8 ffffffff804693ee ffffffff80469837 0000000000000003
       ffffffff80606de8 ffffffff80228367
Call Trace: <IRQ> <ffffffff80469837>{_spin_unlock_irqrestore+55}
       <ffffffff804693ee>{_spin_lock+30} <ffffffff80469837>{_spin_unlock_irqrestore+55}
       <ffffffff80228367>{try_to_wake_up+55} <ffffffff8022849d>{default_wake_function+13}
       <ffffffff80227463>{__wake_up_common+67} <ffffffff802274e3>{__wake_up+67}
       <ffffffff8023e900>{delayed_work_timer_fn+0} <ffffffff8023e42d>{__queue_work+93}
       <ffffffff8023e929>{delayed_work_timer_fn+41} <ffffffff80236e39>{run_timer_softirq+361}
       <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
       <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
       <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
       <ffffffff804697cf>{_spin_unlock_irq+15} <ffffffff804697c9>{_spin_unlock_irq+9}
       <ffffffff80468df6>{__down_read+54} <ffffffff8023c2c2>{blocking_notifier_call_chain+34}
       <ffffffff8022dae5>{profile_task_exit+21} <ffffffff8022f1e5>{do_exit+37}
       <ffffffff8046981d>{_spin_unlock_irqrestore+29} <ffffffff8020b5a4>{die+84}
       <ffffffff8020bae0>{do_general_protection+272} <ffffffff8020a6a5>{error_exit+0}
       <ffffffff8046747c>{schedule+1164} <ffffffff80467468>{schedule+1144}
       <ffffffff804676df>{io_schedule+15} <ffffffff8027efeb>{sync_buffer+59}
       <ffffffff80468015>{__wait_on_bit_lock+69} <ffffffff8027efb0>{sync_buffer+0}
       <ffffffff8027efb0>{sync_buffer+0} <ffffffff804680c8>{out_of_line_wait_on_bit_lock+120}
       <ffffffff80242690>{wake_bit_function+0} <ffffffff8027e574>{__lock_buffer+36}
       <ffffffff8027fdc1>{ll_rw_block+65} <ffffffff8030a3ab>{journal_commit_transaction+1659}
       <ffffffff804697d4>{_spin_unlock_irq+20} <ffffffff8046981d>{_spin_unlock_irqrestore+29}
       <ffffffff8030e5c3>{kjournald+339} <ffffffff80242520>{autoremove_wake_function+0}
       <ffffffff8030e470>{kjournald+0} <ffffffff80242309>{kthread+217}
       <ffffffff804697d4>{_spin_unlock_irq+20} <ffffffff80228929>{schedule_tail+73}
       <ffffffff8020a85e>{child_rip+8} <ffffffff80242230>{kthread+0}
       <ffffffff8020a856>{child_rip+0}

Code: 8b 03 c7 03 00 00 00 00 84 c0 7f 7d bf 01 00 00 00 49 ff c4
console shuts up ...

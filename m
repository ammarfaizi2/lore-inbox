Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbUKQApL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbUKQApL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUKQAnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:43:07 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:60176 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262126AbUKQAij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 19:38:39 -0500
Date: Tue, 16 Nov 2004 16:36:58 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041117003658.GA15067@nietzsche.lynx.com>
References: <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20041116134027.GA13360@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 16, 2004 at 02:40:27PM +0100, Ingo Molnar wrote:
> i have released the -V0.7.27-3 Real-Time Preemption patch, which can be
> downloaded from the usual place:

Against some version of V0.7.25... that I just deleted.

bill


--9jxsPFA5p3P2qPhR
Content-Type: application/x-troff
Content-Disposition: attachment; filename=t
Content-Transfer-Encoding: quoted-printable

=0Abillh@aesthetics> /home/billh% 24%=0Abillh@aesthetics> /home/billh% 24%=
=0Abillh@aesthetics> /home/billh% 24%=0Abillh@aesthetics> /home/billh% 24%=
=0AINIT: Id "T0" respawning too fast: disabled for 5 minutes=0AINIT: Id "T0=
" respawning too fast: disabled for 5 minutes=0AINIT: Id "T0" respawning to=
o fast: disabled for 5 minutes=0AINIT: Id "T0" respawning too fast: disable=
d for 5 minutes=0AINIT: Id "T0" respawning too fast: disabled for 5 minutes=
=0Ahttp:25521 BUG: lock held at task exit time!=0A [c040e0c4] {kernel_sem.l=
ock}=0A.. held by:              http:25521 [d71776a0, 120]=0A... acquired a=
t:  nfs_permission+0x125/0x170=0Ahttp/25521: BUG in __up_mutex at kernel/rt=
=2Ec:1064=0ABUG: sleeping function called from invalid context syslogd(315)=
 at kernel/rt.c:1314=0Ain_atomic():1 [00000001], irqs_disabled():0=0A [<c01=
075b3>] dump_stack+0x23/0x30 (20)=0A [<c0121365>] __might_sleep+0xe5/0x100 =
(36)=0A [<c013ed69>] __spin_lock+0x39/0x60 (24)=0A [<c013ee3d>] _spin_lock_=
irqsave+0x1d/0x30 (16)=0A [<c014afc5>] free_pages_bulk+0x35/0x320 (60)=0A [=
<c014b391>] __free_pages_ok+0xe1/0x100 (44)=0A [<c014b786>] free_hot_page+0=
x26/0x30 (16)=0A [<c017e594>] poll_freewait+0x54/0x60 (20)=0A [<c017e8e3>] =
do_select+0x193/0x2b0 (120)=0A [<c017ed0e>] sys_select+0x2be/0x580 (92)=0A =
[<c0106693>] syscall_call+0x7/0xb (-8124)=0A---------------------------=0A|=
 preempt count: 00000002 ]=0A| 2-level deep critical section nesting:=0A---=
-------------------------------------=0A.. [<c039818f>] .... _raw_spin_lock=
+0x6f/0x80=0A.....[<c013de20>] ..   ( <=3D __up_mutex+0x460/0x470)=0A.. [<c=
0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_=
stack+0x23/0x30)=0A=0ABUG: scheduling while atomic: syslogd/0x00000001/315=
=0Acaller is schedule+0x40/0x140=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=
=0A [<c039640c>] __schedule+0x7dc/0x830 (108)=0A [<c03964a0>] schedule+0x40=
/0x140 (36)=0A [<c0397225>] schedule_timeout+0xd5/0xe0 (128)=0A [<c017e8be>=
] do_select+0x16e/0x2b0 (120)=0A [<c017ed0e>] sys_select+0x2be/0x580 (92)=
=0A [<c0106693>] syscall_call+0x7/0xb (-8124)=0A---------------------------=
=0A| preempt count: 00000002 ]=0A| 2-level deep critical section nesting:=
=0A----------------------------------------=0A.. [<c039818f>] .... _raw_spi=
n_lock+0x6f/0x80=0A.....[<c013de20>] ..   ( <=3D __up_mutex+0x460/0x470)=0A=
=2E. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=
=3D dump_stack+0x23/0x30)=0A=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [=
<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013ebdc>] up+0xec/0xf0 (36)=
=0A [<c03963c1>] __schedule+0x791/0x830 (108)=0A [<c0127bb0>] do_exit+0x280=
/0x4e0 (48)=0A [<c0127f41>] do_group_exit+0x41/0xe0 (40)=0A [<c0132817>] ge=
t_signal_to_deliver+0x267/0x370 (44)=0A [<c010646a>] do_signal+0x8a/0x130 (=
200)=0A [<c0106557>] do_notify_resume+0x47/0x4c (12)=0A [<c01066ee>] work_n=
otifysig+0x13/0x15 (-8124)=0A---------------------------=0A| preempt count:=
 00000004 ]=0A| 4-level deep critical section nesting:=0A------------------=
----------------------=0A.. [<c0395c7f>] .... __schedule+0x4f/0x830=0A.....=
[<c0127bb0>] ..   ( <=3D do_exit+0x280/0x4e0)=0A.. [<c013eb8b>] .... up+0x9=
b/0xf0=0A.....[<c03963c1>] ..   ( <=3D __schedule+0x791/0x830)=0A.. [<c0398=
142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013de20>] ..   ( <=3D __up_mu=
tex+0x460/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01=
075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Aapt-get/25210: BUG in lock_n=
ew_owner at kernel/rt.c:651=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<=
c013d6e2>] lock_new_owner+0xc2/0xf0 (40)=0A [<c0397991>] __down_mutex+0x191=
/0x300 (84)=0A [<c013ed7b>] __spin_lock+0x4b/0x60 (24)=0A [<c013edad>] _spi=
n_lock+0x1d/0x30 (16)=0A [<c032dc0c>] qdisc_restart+0x1ac/0x290 (56)=0A [<c=
031f5bf>] dev_queue_xmit+0x1ef/0x2a0 (36)=0A [<c0339e99>] ip_finish_output+=
0xd9/0x280 (56)=0A [<c033c370>] ip_push_pending_frames+0x350/0x540 (76)=0A =
[<c035ac40>] udp_push_pending_frames+0x160/0x260 (48)=0A [<c035b172>] udp_s=
endmsg+0x3e2/0x830 (280)=0A [<c0363900>] inet_sendmsg+0x50/0x60 (28)=0A [<c=
0314bb0>] sock_sendmsg+0xc0/0xe0 (244)=0A [<c0314c17>] kernel_sendmsg+0x47/=
0x60 (28)=0A [<c0390fd1>] xdr_sendpages+0xc1/0x280 (136)=0A [<c0386fd4>] xp=
rt_transmit+0xe4/0x510 (64)=0A [<c0384b93>] call_transmit+0x53/0xc0 (24)=0A=
 [<c0388f37>] __rpc_execute+0x97/0x3e0 (108)=0A [<c0384363>] rpc_call_sync+=
0x73/0xd0 (40)=0A [<c01de376>] nfs3_rpc_wrapper+0x46/0x90 (40)=0A [<c01de72=
f>] nfs3_proc_lookup+0xbf/0x180 (240)=0A [<c01d1dc4>] nfs_lookup+0xf4/0x1d0=
 (328)=0A [<c0178681>] real_lookup+0xd1/0xf0 (36)=0A [<c01789eb>] do_lookup=
+0x8b/0xa0 (32)=0A [<c0179206>] link_path_walk+0x806/0x1000 (104)=0A [<c017=
9d53>] path_lookup+0xa3/0x1c0 (32)=0A [<c017a026>] __user_walk+0x36/0x60 (3=
2)=0A [<c01743e3>] vfs_stat+0x23/0x60 (92)=0A [<c0174b80>] sys_stat64+0x20/=
0x50 (100)=0A [<c0106693>] syscall_call+0x7/0xb (-8124)=0A-----------------=
----------=0A| preempt count: 00000002 ]=0A| 2-level deep critical section =
nesting:=0A----------------------------------------=0A.. [<c0398142>] .... =
_raw_spin_lock+0x22/0x80=0A.....[<c03978b4>] ..   ( <=3D __down_mutex+0xb4/=
0x300)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..=
   ( <=3D dump_stack+0x23/0x30)=0A=0Aksoftirqd/1/7: BUG in lock_new_owner a=
t kernel/rt.c:651=0Agrep/25524: BUG in lock_new_owner at kernel/rt.c:651=0A=
 [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013d6e2>] lock_new_owner+0xc2=
/0xf0 (40)=0A [<c0397991>] __down_mutex+0x191/0x300 (84)=0A [<c013ed7b>] __=
spin_lock+0x4b/0x60 (24)=0A [<c013ee3d>] _spin_lock_irqsave+0x1d/0x30 (16)=
=0A [<c038421c>] rpc_clnt_sigmask+0x6c/0xc0 (32)=0A [<c0384327>] rpc_call_s=
ync+0x37/0xd0 (40)=0A [<c01de376>] nfs3_rpc_wrapper+0x46/0x90 (40)=0A [<c01=
de570>] nfs3_proc_getattr+0x50/0x80 (40)=0A [<c01d5ab9>] __nfs_revalidate_i=
node+0xf9/0x3a0 (192)=0A [<c01d1b1a>] nfs_lookup_revalidate+0x45a/0x550 (34=
8)=0A [<c01789be>] do_lookup+0x5e/0xa0 (32)=0A [<c0178b1d>] link_path_walk+=
0x11d/0x1000 (104)=0A [<c0179d53>] path_lookup+0xa3/0x1c0 (32)=0A [<c017a4f=
b>] open_namei+0x8b/0x700 (60)=0A [<c0168951>] filp_open+0x41/0x70 (92)=0A =
[<c0168d4b>] sys_open+0x4b/0x90 (32)=0A [<c0106693>] syscall_call+0x7/0xb (=
-8124)=0A---------------------------=0A| preempt count: 00000002 ]=0A| 2-le=
vel deep critical section nesting:=0A--------------------------------------=
--=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c03978b4>] ..  =
 ( <=3D __down_mutex+0xb4/0x300)=0A.. [<c0140f4d>] .... print_traces+0x1d/0=
x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Agrep/25524: =
BUG in lock_new_owner at kernel/rt.c:651=0A [<c01075b3>] dump_stack+0x23/0x=
30 (20)=0A [<c013d6e2>] lock_new_owner+0xc2/0xf0 (40)=0A [<c0397991>] __dow=
n_mutex+0x191/0x300 (84)=0A [<c0397bb3>] down_read_mutex+0x53/0x70 (28)=0A =
[<c013f0bd>] _read_lock+0x1d/0x30 (16)=0A [<c0334d92>] __ip_route_output_ke=
y+0x52/0x140 (36)=0A [<c0334eaf>] ip_route_output_flow+0x2f/0x90 (40)=0A [<=
c035b312>] udp_sendmsg+0x582/0x830 (280)=0A [<c0363900>] inet_sendmsg+0x50/=
0x60 (28)=0A [<c0314bb0>] sock_sendmsg+0xc0/0xe0 (244)=0A [<c0314c17>] kern=
el_sendmsg+0x47/0x60 (28)=0A [<c0390fd1>] xdr_sendpages+0xc1/0x280 (136)=0A=
 [<c0386fd4>] xprt_transmit+0xe4/0x510 (64)=0A [<c0384b93>] call_transmit+0=
x53/0xc0 (24)=0A [<c0388f37>] __rpc_execute+0x97/0x3e0 (108)=0A [<c0384363>=
] rpc_call_sync+0x73/0xd0 (40)=0A [<c01de376>] nfs3_rpc_wrapper+0x46/0x90 (=
40)=0A [<c01de570>] nfs3_proc_getattr+0x50/0x80 (40)=0A [<c01d5ab9>] __nfs_=
revalidate_inode+0xf9/0x3a0 (192)=0A [<c01d1b1a>] nfs_lookup_revalidate+0x4=
5a/0x550 (348)=0A [<c01789be>] do_lookup+0x5e/0xa0 (32)=0A [<c0178b1d>] lin=
k_path_walk+0x11d/0x1000 (104)=0A [<c0179d53>] path_lookup+0xa3/0x1c0 (32)=
=0A [<c017a4fb>] open_namei+0x8b/0x700 (60)=0A [<c0168951>] filp_open+0x41/=
0x70 (92)=0A [<c0168d4b>] sys_open+0x4b/0x90 (32)=0A [<c0106693>] syscall_c=
all+0x7/0xb (-8124)=0A---------------------------=0A| preempt count: 000000=
02 ]=0A| 2-level deep critical section nesting:=0A-------------------------=
---------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c0=
3978b4>] ..   ( <=3D __down_mutex+0xb4/0x300)=0A.. [<c0140f4d>] .... print_=
traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=
=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013d6e2>] lock_new_owner+0=
xc2/0xf0 (40)=0A [<c013dd59>] __up_mutex+0x399/0x470 (72)=0A [<c013e576>] u=
p_mutex+0xb6/0x110 (40)=0A [<c012f246>] run_timer_softirq+0x86/0x470 (60)=
=0A [<c012a6f2>] ___do_softirq+0xd2/0x130 (48)=0A [<c012a819>] _do_softirq+=
0x29/0x30 (8)=0A [<c012ad96>] ksoftirqd+0xc6/0x100 (24)=0A [<c013bc1b>] kth=
read+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (104889550=
8)=0A---------------------------=0A| preempt count: 00000002 ]=0A| 2-level =
deep critical section nesting:=0A----------------------------------------=
=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   (=
 <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=
=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0AIRQ 18/247: BUG=
 in lock_new_owner at kernel/rt.c:651=0A [<c01075b3>] dump_stack+0x23/0x30 =
(20)=0A [<c013d6e2>] lock_new_owner+0xc2/0xf0 (40)=0A [<c0397991>] __down_m=
utex+0x191/0x300 (84)=0A [<c013ed7b>] __spin_lock+0x4b/0x60 (24)=0A [<c013e=
dad>] _spin_lock+0x1d/0x30 (16)=0A [<c01516dc>] __kmalloc+0x7c/0x140 (36)=
=0A [<c0318bdd>] alloc_skb+0x4d/0xf0 (32)=0A [<c0292cbb>] speedo_rx+0x29b/0=
x3d0 (56)=0A [<c02927f0>] speedo_interrupt+0x230/0x250 (56)=0A [<c0144943>]=
 handle_IRQ_event+0x53/0xa0 (40)=0A [<c01451c2>] do_hardirq+0x52/0xf0 (40)=
=0A [<c0145385>] do_irqd+0x125/0x240 (52)=0A [<c013bc1b>] kthread+0xbb/0xc0=
 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (548413460)=0A----------=
-----------------=0A| preempt count: 00000002 ]=0A| 2-level deep critical s=
ection nesting:=0A----------------------------------------=0A.. [<c0398142>=
] .... _raw_spin_lock+0x22/0x80=0A.....[<c03978b4>] ..   ( <=3D __down_mute=
x+0xb4/0x300)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075=
b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Aevents/1/10: BUG in lock_new_ow=
ner at kernel/rt.c:651=0Aevents/0/9: BUG in lock_new_owner at kernel/rt.c:6=
51=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013d6e2>] lock_new_owner=
+0xc2/0xf0 (40)=0A [<c0397991>] __down_mutex+0x191/0x300 (84)=0A [<c013ed7b=
>] __spin_lock+0x4b/0x60 (24)=0A [<c013ee0d>] _spin_lock_irq+0x1d/0x30 (16)=
=0A [<c0151f01>] cache_reap+0x71/0x290 (52)=0A [<c0136f11>] worker_thread+0=
x1b1/0x270 (128)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] ker=
nel_thread_helper+0x5/0xc (1048846356)=0A---------------------------=0A| pr=
eempt count: 00000002 ]=0A| 2-level deep critical section nesting:=0A------=
----------------------------------=0A.. [<c0398142>] .... _raw_spin_lock+0x=
22/0x80=0A.....[<c03978b4>] ..   ( <=3D __down_mutex+0xb4/0x300)=0A.. [<c01=
40f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_st=
ack+0x23/0x30)=0A=0Aksoftirqd/0/4: BUG in lock_new_owner at kernel/rt.c:651=
=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013d6e2>] lock_new_owner+0=
xc2/0xf0 (40)=0A [<c0397991>] __down_mutex+0x191/0x300 (84)=0A [<c013ed7b>]=
 __spin_lock+0x4b/0x60 (24)=0A [<c013ee3d>] _spin_lock_irqsave+0x1d/0x30 (1=
6)=0A [<c02920f7>] speedo_start_xmit+0x37/0x2b0 (48)=0A [<c032dade>] qdisc_=
restart+0x7e/0x290 (56)=0A [<c031f5bf>] dev_queue_xmit+0x1ef/0x2a0 (36)=0A =
[<c0339e99>] ip_finish_output+0xd9/0x280 (56)=0A [<c033a74b>] ip_queue_xmit=
+0x46b/0x600 (224)=0A [<c034c852>] tcp_transmit_skb+0x432/0x740 (76)=0A [<c=
034f4f9>] tcp_send_ack+0xa9/0xf0 (36)=0A [<c034aa99>] tcp_rcv_established+0=
x299/0x920 (52)=0A [<c035440a>] tcp_v4_do_rcv+0x15a/0x160 (32)=0A [<c0354bc=
f>] tcp_v4_rcv+0x7bf/0xa20 (80)=0A [<c03365cf>] ip_local_deliver+0x10f/0x2f=
0 (48)=0A [<c0336a4c>] ip_rcv+0x29c/0x550 (56)=0A [<c031fc35>] netif_receiv=
e_skb+0x165/0x200 (36)=0A [<c031fd66>] process_backlog+0x96/0x1a0 (48)=0A [=
<c031ff17>] net_rx_action+0xa7/0x200 (44)=0A [<c012a6f2>] ___do_softirq+0xd=
2/0x130 (48)=0A [<c012a819>] _do_softirq+0x29/0x30 (8)=0A [<c012ad96>] ksof=
tirqd+0xc6/0x100 (24)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>=
] kernel_thread_helper+0x5/0xc (1048928276)=0A---------------------------=
=0A| preempt count: 00000002 ]=0A| 2-level deep critical section nesting:=
=0A----------------------------------------=0A.. [<c0398142>] .... _raw_spi=
n_lock+0x22/0x80=0A.....[<c03978b4>] ..   ( <=3D __down_mutex+0xb4/0x300)=
=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=
=3D dump_stack+0x23/0x30)=0A=0Agrep/25524: BUG in lock_new_owner at kernel/=
rt.c:651=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013d6e2>] lock_new=
_owner+0xc2/0xf0 (40)=0A [<c0397991>] __down_mutex+0x191/0x300 (84)=0A [<c0=
13ed7b>] __spin_lock+0x4b/0x60 (24)=0A [<c013ee3d>] _spin_lock_irqsave+0x1d=
/0x30 (16)=0A [<c03842a3>] rpc_clnt_sigunmask+0x33/0x80 (28)=0A [<c0384374>=
] rpc_call_sync+0x84/0xd0 (40)=0A [<c01de376>] nfs3_rpc_wrapper+0x46/0x90 (=
40)=0A [<c01de570>] nfs3_proc_getattr+0x50/0x80 (40)=0A [<c01d5ab9>] __nfs_=
revalidate_inode+0xf9/0x3a0 (192)=0A [<c01d1b1a>] nfs_lookup_revalidate+0x4=
5a/0x550 (348)=0A [<c01789be>] do_lookup+0x5e/0xa0 (32)=0A [<c0178b1d>] lin=
k_path_walk+0x11d/0x1000 (104)=0A [<c0179d53>] path_lookup+0xa3/0x1c0 (32)=
=0A [<c017a4fb>] open_namei+0x8b/0x700 (60)=0A [<c0168951>] filp_open+0x41/=
0x70 (92)=0A [<c0168d4b>] sys_open+0x4b/0x90 (32)=0A [<c0106693>] syscall_c=
all+0x7/0xb (-8124)=0A---------------------------=0A| preempt count: 000000=
02 ]=0A| 2-level deep critical section nesting:=0A-------------------------=
---------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c0=
3978b4>] ..   ( <=3D __down_mutex+0xb4/0x300)=0A.. [<c0140f4d>] .... print_=
traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=
=0Antop/553: BUG in lock_new_owner at kernel/rt.c:651=0A [<c01075b3>] dump_=
stack+0x23/0x30 (20)=0A [<c013d6e2>] lock_new_owner+0xc2/0xf0 (40)=0A [<c03=
97991>] __down_mutex+0x191/0x300 (84)=0A [<c013ed7b>] __spin_lock+0x4b/0x60=
 (24)=0A [<c013edad>] _spin_lock+0x1d/0x30 (16)=0A [<c016a7b3>] fget+0x33/0=
x70 (28)=0A [<c031490f>] sockfd_lookup+0x1f/0x80 (24)=0A [<c031605c>] sys_r=
ecvfrom+0x2c/0x100 (208)=0A [<c0316923>] sys_socketcall+0x1b3/0x250 (68)=0A=
 [<c0106693>] syscall_call+0x7/0xb (-8124)=0A---------------------------=0A=
| preempt count: 00000002 ]=0A| 2-level deep critical section nesting:=0A--=
--------------------------------------=0A.. [<c0398142>] .... _raw_spin_loc=
k+0x22/0x80=0A.....[<c03978b4>] ..   ( <=3D __down_mutex+0xb4/0x300)=0A.. [=
<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dum=
p_stack+0x23/0x30)=0A=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013d6=
e2>] lock_new_owner+0xc2/0xf0 (40)=0A [<c013dd59>] __up_mutex+0x399/0x470 (=
72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c012e7c1>] __mod_timer+0x=
101/0x1d0 (44)=0A [<c0136cf0>] queue_delayed_work+0x60/0xd0 (36)=0A [<c0152=
047>] cache_reap+0x1b7/0x290 (52)=0A [<c0136f11>] worker_thread+0x1b1/0x270=
 (128)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread=
_helper+0x5/0xc (1048789012)=0A---------------------------=0A| preempt coun=
t: 00000002 ]=0A| 2-level deep critical section nesting:=0A----------------=
------------------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A=
=2E....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .=
=2E.. print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x2=
3/0x30)=0A=0Aksoftirqd/1/7: BUG in __up_mutex at kernel/rt.c:1064=0ABUG: sl=
eeping function called from invalid context syslogd(315) at kernel/rt.c:131=
4=0Ain_atomic():1 [00000001], irqs_disabled():0=0A [<c01075b3>] dump_stack+=
0x23/0x30 (20)=0A [<c0121365>] __might_sleep+0xe5/0x100 (36)=0A [<c013ed69>=
] __spin_lock+0x39/0x60 (24)=0A [<c013edad>] _spin_lock+0x1d/0x30 (16)=0A [=
<c016a7b3>] fget+0x33/0x70 (28)=0A [<c017e957>] do_select+0x207/0x2b0 (120)=
=0A [<c017ed0e>] sys_select+0x2be/0x580 (92)=0A [<c0106693>] syscall_call+0=
x7/0xb (-8124)=0A---------------------------=0A| preempt count: 00000002 ]=
=0A| 2-level deep critical section nesting:=0A-----------------------------=
-----------=0A.. [<c039818f>] .... _raw_spin_lock+0x6f/0x80=0A.....[<c013de=
20>] ..   ( <=3D __up_mutex+0x460/0x470)=0A.. [<c0140f4d>] .... print_trace=
s+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0ABUG:=
 scheduling while atomic: syslogd/0x00000001/315=0Acaller is schedule+0x40/=
0x140=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c039640c>] __schedule+=
0x7dc/0x830 (108)=0A [<c03964a0>] schedule+0x40/0x140 (36)=0A [<c0397225>] =
schedule_timeout+0xd5/0xe0 (128)=0A [<c017e8be>] do_select+0x16e/0x2b0 (120=
)=0A [<c017ed0e>] sys_select+0x2be/0x580 (92)=0A [<c0106693>] syscall_call+=
0x7/0xb (-8124)=0A---------------------------=0A| preempt count: 00000002 ]=
=0A| 2-level deep critical section nesting:=0A-----------------------------=
-----------=0A.. [<c039818f>] .... _raw_spin_lock+0x6f/0x80=0A.....[<c013de=
20>] ..   ( <=3D __up_mutex+0x460/0x470)=0A.. [<c0140f4d>] .... print_trace=
s+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0A [<c=
01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 =
(72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c012f3ac>] run_timer_sof=
tirq+0x1ec/0x470 (60)=0A [<c012a6f2>] ___do_softirq+0xd2/0x130 (48)=0A [<c0=
12a819>] _do_softirq+0x29/0x30 (8)=0A [<c012ad96>] ksoftirqd+0xc6/0x100 (24=
)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_help=
er+0x5/0xc (1048895508)=0A---------------------------=0A| preempt count: 00=
000002 ]=0A| 2-level deep critical section nesting:=0A---------------------=
-------------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....=
[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... pri=
nt_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=
=0A=0Agrep/25524: BUG in lock_new_owner at kernel/rt.c:651=0A [<c01075b3>] =
dump_stack+0x23/0x30 (20)=0A [<c013d6e2>] lock_new_owner+0xc2/0xf0 (40)=0A =
[<c0397991>] __down_mutex+0x191/0x300 (84)=0A [<c013ed7b>] __spin_lock+0x4b=
/0x60 (24)=0A [<c013ee3d>] _spin_lock_irqsave+0x1d/0x30 (16)=0A [<c038421c>=
] rpc_clnt_sigmask+0x6c/0xc0 (32)=0A [<c01de357>] nfs3_rpc_wrapper+0x27/0x9=
0 (40)=0A [<c01de8f5>] nfs3_proc_access+0x105/0x1b0 (224)=0A [<c01d311c>] n=
fs_do_access+0x5c/0xa0 (48)=0A [<c01d3276>] nfs_permission+0x116/0x170 (32)=
=0A [<c017837e>] permission+0x7e/0x80 (32)=0A [<c017990b>] link_path_walk+0=
xf0b/0x1000 (104)=0A [<c0179d53>] path_lookup+0xa3/0x1c0 (32)=0A [<c017a4fb=
>] open_namei+0x8b/0x700 (60)=0A [<c0168951>] filp_open+0x41/0x70 (92)=0A [=
<c0168d4b>] sys_open+0x4b/0x90 (32)=0A [<c0106693>] syscall_call+0x7/0xb (-=
8124)=0A---------------------------=0A| preempt count: 00000002 ]=0A| 2-lev=
el deep critical section nesting:=0A---------------------------------------=
-=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c03978b4>] ..   =
( <=3D __down_mutex+0xb4/0x300)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x=
60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0AIRQ 18/247: B=
UG in lock_new_owner at kernel/rt.c:651=0A [<c01075b3>] dump_stack+0x23/0x3=
0 (20)=0A [<c013d6e2>] lock_new_owner+0xc2/0xf0 (40)=0A [<c0397991>] __down=
_mutex+0x191/0x300 (84)=0A [<c013ed7b>] __spin_lock+0x4b/0x60 (24)=0A [<c01=
3edad>] _spin_lock+0x1d/0x30 (16)=0A [<c029269c>] speedo_interrupt+0xdc/0x2=
50 (56)=0A [<c0144943>] handle_IRQ_event+0x53/0xa0 (40)=0A [<c01451c2>] do_=
hardirq+0x52/0xf0 (40)=0A [<c0145385>] do_irqd+0x125/0x240 (52)=0A [<c013bc=
1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (5=
48413460)=0A---------------------------=0A| preempt count: 00000002 ]=0A| 2=
-level deep critical section nesting:=0A-----------------------------------=
-----=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c03978b4>] .=
=2E   ( <=3D __down_mutex+0xb4/0x300)=0A.. [<c0140f4d>] .... print_traces+0=
x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Aksoftir=
qd/0/4: BUG in lock_new_owner at kernel/rt.c:651=0A [<c01075b3>] dump_stack=
+0x23/0x30 (20)=0A [<c013d6e2>] lock_new_owner+0xc2/0xf0 (40)=0A [<c013dd59=
>] __up_mutex+0x399/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A =
[<c012f246>] run_timer_softirq+0x86/0x470 (60)=0A [<c012a6f2>] ___do_softir=
q+0xd2/0x130 (48)=0A [<c012a819>] _do_softirq+0x29/0x30 (8)=0A [<c012ad96>]=
 ksoftirqd+0xc6/0x100 (24)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c010=
4589>] kernel_thread_helper+0x5/0xc (1048928276)=0A------------------------=
---=0A| preempt count: 00000002 ]=0A| 2-level deep critical section nesting=
:=0A----------------------------------------=0A.. [<c0398142>] .... _raw_sp=
in_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=
=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=
=3D dump_stack+0x23/0x30)=0A=0Aksoftirqd/1/7: BUG in __up_mutex at kernel/r=
t.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mut=
ex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c012f246>=
] run_timer_softirq+0x86/0x470 (60)=0A [<c012a6f2>] ___do_softirq+0xd2/0x13=
0 (48)=0A [<c012a819>] _do_softirq+0x29/0x30 (8)=0A [<c012ad96>] ksoftirqd+=
0xc6/0x100 (24)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kern=
el_thread_helper+0x5/0xc (1048895508)=0A---------------------------=0A| pre=
empt count: 00000002 ]=0A| 2-level deep critical section nesting:=0A-------=
---------------------------------=0A.. [<c0398142>] .... _raw_spin_lock+0x2=
2/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140=
f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stac=
k+0x23/0x30)=0A=0AIRQ 0/2: BUG in __up_mutex at kernel/rt.c:1064=0A [<c0107=
5b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=
=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c010be42>] timer_interrupt+0=
xd2/0x130 (32)=0A [<c0144943>] handle_IRQ_event+0x53/0xa0 (40)=0A [<c01451c=
2>] do_hardirq+0x52/0xf0 (40)=0A [<c0145385>] do_irqd+0x125/0x240 (52)=0A [=
<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5=
/0xc (1048952852)=0A---------------------------=0A| preempt count: 00000002=
 ]=0A| 2-level deep critical section nesting:=0A---------------------------=
-------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013=
dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_tra=
ces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Aks=
oftirqd/1/7: BUG in __up_mutex at kernel/rt.c:1064=0A [<c01075b3>] dump_sta=
ck+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576=
>] up_mutex+0xb6/0x110 (40)=0A [<c012f246>] run_timer_softirq+0x86/0x470 (6=
0)=0A [<c012a6f2>] ___do_softirq+0xd2/0x130 (48)=0A [<c012a819>] _do_softir=
q+0x29/0x30 (8)=0A [<c012ad96>] ksoftirqd+0xc6/0x100 (24)=0A [<c013bc1b>] k=
thread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (1048895=
508)=0A---------------------------=0A| preempt count: 00000002 ]=0A| 2-leve=
l deep critical section nesting:=0A----------------------------------------=
=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   (=
 <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=
=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0AIRQ 0/2: BUG in=
 __up_mutex at kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=
=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/=
0x110 (40)=0A [<c010be42>] timer_interrupt+0xd2/0x130 (32)=0A [<c0144943>] =
handle_IRQ_event+0x53/0xa0 (40)=0A [<c01451c2>] do_hardirq+0x52/0xf0 (40)=
=0A [<c0145385>] do_irqd+0x125/0x240 (52)=0A [<c013bc1b>] kthread+0xbb/0xc0=
 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (1048952852)=0A---------=
------------------=0A| preempt count: 00000002 ]=0A| 2-level deep critical =
section nesting:=0A----------------------------------------=0A.. [<c0398142=
>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mutex=
+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075=
b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Aksoftirqd/1/7: BUG in __up_mute=
x at kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc=
87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=
=0A [<c012f246>] run_timer_softirq+0x86/0x470 (60)=0A [<c012a6f2>] ___do_so=
ftirq+0xd2/0x130 (48)=0A [<c012a819>] _do_softirq+0x29/0x30 (8)=0A [<c012ad=
96>] ksoftirqd+0xc6/0x100 (24)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<=
c0104589>] kernel_thread_helper+0x5/0xc (1048895508)=0A--------------------=
-------=0A| preempt count: 00000002 ]=0A| 2-level deep critical section nes=
ting:=0A----------------------------------------=0A.. [<c0398142>] .... _ra=
w_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x47=
0)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   (=
 <=3D dump_stack+0x23/0x30)=0A=0AIRQ 0/2: BUG in __up_mutex at kernel/rt.c:=
1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0=
x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c010be42>] ti=
mer_interrupt+0xd2/0x130 (32)=0A [<c0144943>] handle_IRQ_event+0x53/0xa0 (4=
0)=0A [<c01451c2>] do_hardirq+0x52/0xf0 (40)=0A [<c0145385>] do_irqd+0x125/=
0x240 (52)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_th=
read_helper+0x5/0xc (1048952852)=0A---------------------------=0A| preempt =
count: 00000002 ]=0A| 2-level deep critical section nesting:=0A------------=
----------------------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x8=
0=0A.....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>]=
 .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x2=
3/0x30)=0A=0Aksoftirqd/1/7: BUG in __up_mutex at kernel/rt.c:1064=0A [<c010=
75b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72=
)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c012f246>] run_timer_softir=
q+0x86/0x470 (60)=0A [<c012a6f2>] ___do_softirq+0xd2/0x130 (48)=0A [<c012a8=
19>] _do_softirq+0x29/0x30 (8)=0A [<c012ad96>] ksoftirqd+0xc6/0x100 (24)=0A=
 [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0=
x5/0xc (1048895508)=0A---------------------------=0A| preempt count: 000000=
02 ]=0A| 2-level deep critical section nesting:=0A-------------------------=
---------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c0=
13dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_t=
races+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0A=
IRQ 0/2: BUG in __up_mutex at kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0=
x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] u=
p_mutex+0xb6/0x110 (40)=0A [<c010be42>] timer_interrupt+0xd2/0x130 (32)=0A =
[<c0144943>] handle_IRQ_event+0x53/0xa0 (40)=0A [<c01451c2>] do_hardirq+0x5=
2/0xf0 (40)=0A [<c0145385>] do_irqd+0x125/0x240 (52)=0A [<c013bc1b>] kthrea=
d+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (1048952852)=
=0A---------------------------=0A| preempt count: 00000002 ]=0A| 2-level de=
ep critical section nesting:=0A----------------------------------------=0A.=
=2E [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=
=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=
=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Aksoftirqd/1/7: =
BUG in __up_mutex at kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 =
(20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0=
xb6/0x110 (40)=0A [<c012f246>] run_timer_softirq+0x86/0x470 (60)=0A [<c012a=
6f2>] ___do_softirq+0xd2/0x130 (48)=0A [<c012a819>] _do_softirq+0x29/0x30 (=
8)=0A [<c012ad96>] ksoftirqd+0xc6/0x100 (24)=0A [<c013bc1b>] kthread+0xbb/0=
xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (1048895508)=0A------=
---------------------=0A| preempt count: 00000002 ]=0A| 2-level deep critic=
al section nesting:=0A----------------------------------------=0A.. [<c0398=
142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mu=
tex+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01=
075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0AIRQ 0/2: BUG in __up_mutex a=
t kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>=
] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [=
<c010be42>] timer_interrupt+0xd2/0x130 (32)=0A [<c0144943>] handle_IRQ_even=
t+0x53/0xa0 (40)=0A [<c01451c2>] do_hardirq+0x52/0xf0 (40)=0A [<c0145385>] =
do_irqd+0x125/0x240 (52)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c01045=
89>] kernel_thread_helper+0x5/0xc (1048952852)=0A--------------------------=
-=0A| preempt count: 00000002 ]=0A| 2-level deep critical section nesting:=
=0A----------------------------------------=0A.. [<c0398142>] .... _raw_spi=
n_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A=
=2E. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=
=3D dump_stack+0x23/0x30)=0A=0Aksoftirqd/1/7: BUG in __up_mutex at kernel/r=
t.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mut=
ex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c012f246>=
] run_timer_softirq+0x86/0x470 (60)=0A [<c012a6f2>] ___do_softirq+0xd2/0x13=
0 (48)=0A [<c012a819>] _do_softirq+0x29/0x30 (8)=0A [<c012ad96>] ksoftirqd+=
0xc6/0x100 (24)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kern=
el_thread_helper+0x5/0xc (1048895508)=0A---------------------------=0A| pre=
empt count: 00000002 ]=0A| 2-level deep critical section nesting:=0A-------=
---------------------------------=0A.. [<c0398142>] .... _raw_spin_lock+0x2=
2/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140=
f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stac=
k+0x23/0x30)=0A=0AIRQ 0/2: BUG in __up_mutex at kernel/rt.c:1064=0A [<c0107=
5b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=
=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c010be42>] timer_interrupt+0=
xd2/0x130 (32)=0A [<c0144943>] handle_IRQ_event+0x53/0xa0 (40)=0A [<c01451c=
2>] do_hardirq+0x52/0xf0 (40)=0A [<c0145385>] do_irqd+0x125/0x240 (52)=0A [=
<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5=
/0xc (1048952852)=0A---------------------------=0A| preempt count: 00000002=
 ]=0A| 2-level deep critical section nesting:=0A---------------------------=
-------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013=
dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_tra=
ces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Aks=
oftirqd/1/7: BUG in __up_mutex at kernel/rt.c:1064=0A [<c01075b3>] dump_sta=
ck+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576=
>] up_mutex+0xb6/0x110 (40)=0A [<c012f246>] run_timer_softirq+0x86/0x470 (6=
0)=0A [<c012a6f2>] ___do_softirq+0xd2/0x130 (48)=0A [<c012a819>] _do_softir=
q+0x29/0x30 (8)=0A [<c012ad96>] ksoftirqd+0xc6/0x100 (24)=0A [<c013bc1b>] k=
thread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (1048895=
508)=0A---------------------------=0A| preempt count: 00000002 ]=0A| 2-leve=
l deep critical section nesting:=0A----------------------------------------=
=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   (=
 <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=
=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0AIRQ 0/2: BUG in=
 __up_mutex at kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=
=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/=
0x110 (40)=0A [<c010be42>] timer_interrupt+0xd2/0x130 (32)=0A [<c0144943>] =
handle_IRQ_event+0x53/0xa0 (40)=0A [<c01451c2>] do_hardirq+0x52/0xf0 (40)=
=0A [<c0145385>] do_irqd+0x125/0x240 (52)=0A [<c013bc1b>] kthread+0xbb/0xc0=
 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (1048952852)=0A---------=
------------------=0A| preempt count: 00000002 ]=0A| 2-level deep critical =
section nesting:=0A----------------------------------------=0A.. [<c0398142=
>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mutex=
+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075=
b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Aksoftirqd/1/7: BUG in __up_mute=
x at kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc=
87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=
=0A [<c012f246>] run_timer_softirq+0x86/0x470 (60)=0A [<c012a6f2>] ___do_so=
ftirq+0xd2/0x130 (48)=0A [<c012a819>] _do_softirq+0x29/0x30 (8)=0A [<c012ad=
96>] ksoftirqd+0xc6/0x100 (24)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<=
c0104589>] kernel_thread_helper+0x5/0xc (1048895508)=0A--------------------=
-------=0A| preempt count: 00000002 ]=0A| 2-level deep critical section nes=
ting:=0A----------------------------------------=0A.. [<c0398142>] .... _ra=
w_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x47=
0)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   (=
 <=3D dump_stack+0x23/0x30)=0A=0AIRQ 0/2: BUG in __up_mutex at kernel/rt.c:=
1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0=
x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c010be42>] ti=
mer_interrupt+0xd2/0x130 (32)=0A [<c0144943>] handle_IRQ_event+0x53/0xa0 (4=
0)=0A [<c01451c2>] do_hardirq+0x52/0xf0 (40)=0A [<c0145385>] do_irqd+0x125/=
0x240 (52)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_th=
read_helper+0x5/0xc (1048952852)=0A---------------------------=0A| preempt =
count: 00000002 ]=0A| 2-level deep critical section nesting:=0A------------=
----------------------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x8=
0=0A.....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>]=
 .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x2=
3/0x30)=0A=0Aksoftirqd/1/7: BUG in __up_mutex at kernel/rt.c:1064=0A [<c010=
75b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72=
)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c012f246>] run_timer_softir=
q+0x86/0x470 (60)=0A [<c012a6f2>] ___do_softirq+0xd2/0x130 (48)=0A [<c012a8=
19>] _do_softirq+0x29/0x30 (8)=0A [<c012ad96>] ksoftirqd+0xc6/0x100 (24)=0A=
 [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0=
x5/0xc (1048895508)=0A---------------------------=0A| preempt count: 000000=
02 ]=0A| 2-level deep critical section nesting:=0A-------------------------=
---------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c0=
13dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_t=
races+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0A=
IRQ 0/2: BUG in __up_mutex at kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0=
x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] u=
p_mutex+0xb6/0x110 (40)=0A [<c010be42>] timer_interrupt+0xd2/0x130 (32)=0A =
[<c0144943>] handle_IRQ_event+0x53/0xa0 (40)=0A [<c01451c2>] do_hardirq+0x5=
2/0xf0 (40)=0A [<c0145385>] do_irqd+0x125/0x240 (52)=0A [<c013bc1b>] kthrea=
d+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (1048952852)=
=0A---------------------------=0A| preempt count: 00000002 ]=0A| 2-level de=
ep critical section nesting:=0A----------------------------------------=0A.=
=2E [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=
=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=
=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Aksoftirqd/1/7: =
BUG in __up_mutex at kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 =
(20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0=
xb6/0x110 (40)=0A [<c012f246>] run_timer_softirq+0x86/0x470 (60)=0A [<c012a=
6f2>] ___do_softirq+0xd2/0x130 (48)=0A [<c012a819>] _do_softirq+0x29/0x30 (=
8)=0A [<c012ad96>] ksoftirqd+0xc6/0x100 (24)=0A [<c013bc1b>] kthread+0xbb/0=
xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (1048895508)=0A------=
---------------------=0A| preempt count: 00000002 ]=0A| 2-level deep critic=
al section nesting:=0A----------------------------------------=0A.. [<c0398=
142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mu=
tex+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01=
075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0AIRQ 0/2: BUG in __up_mutex a=
t kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>=
] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [=
<c010be42>] timer_interrupt+0xd2/0x130 (32)=0A [<c0144943>] handle_IRQ_even=
t+0x53/0xa0 (40)=0A [<c01451c2>] do_hardirq+0x52/0xf0 (40)=0A [<c0145385>] =
do_irqd+0x125/0x240 (52)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c01045=
89>] kernel_thread_helper+0x5/0xc (1048952852)=0A--------------------------=
-=0A| preempt count: 00000002 ]=0A| 2-level deep critical section nesting:=
=0A----------------------------------------=0A.. [<c0398142>] .... _raw_spi=
n_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A=
=2E. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=
=3D dump_stack+0x23/0x30)=0A=0Aksoftirqd/1/7: BUG in __up_mutex at kernel/r=
t.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mut=
ex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c012f246>=
] run_timer_softirq+0x86/0x470 (60)=0A [<c012a6f2>] ___do_softirq+0xd2/0x13=
0 (48)=0A [<c012a819>] _do_softirq+0x29/0x30 (8)=0A [<c012ad96>] ksoftirqd+=
0xc6/0x100 (24)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kern=
el_thread_helper+0x5/0xc (1048895508)=0A---------------------------=0A| pre=
empt count: 00000002 ]=0A| 2-level deep critical section nesting:=0A-------=
---------------------------------=0A.. [<c0398142>] .... _raw_spin_lock+0x2=
2/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140=
f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stac=
k+0x23/0x30)=0A=0AIRQ 0/2: BUG in __up_mutex at kernel/rt.c:1064=0A [<c0107=
5b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=
=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c010be42>] timer_interrupt+0=
xd2/0x130 (32)=0A [<c0144943>] handle_IRQ_event+0x53/0xa0 (40)=0A [<c01451c=
2>] do_hardirq+0x52/0xf0 (40)=0A [<c0145385>] do_irqd+0x125/0x240 (52)=0A [=
<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5=
/0xc (1048952852)=0A---------------------------=0A| preempt count: 00000002=
 ]=0A| 2-level deep critical section nesting:=0A---------------------------=
-------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013=
dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_tra=
ces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Aks=
oftirqd/1/7: BUG in __up_mutex at kernel/rt.c:1064=0A [<c01075b3>] dump_sta=
ck+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576=
>] up_mutex+0xb6/0x110 (40)=0A [<c012f246>] run_timer_softirq+0x86/0x470 (6=
0)=0A [<c012a6f2>] ___do_softirq+0xd2/0x130 (48)=0A [<c012a819>] _do_softir=
q+0x29/0x30 (8)=0A [<c012ad96>] ksoftirqd+0xc6/0x100 (24)=0A [<c013bc1b>] k=
thread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (1048895=
508)=0A---------------------------=0A| preempt count: 00000002 ]=0A| 2-leve=
l deep critical section nesting:=0A----------------------------------------=
=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   (=
 <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=
=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0AIRQ 0/2: BUG in=
 __up_mutex at kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=
=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/=
0x110 (40)=0A [<c010be42>] timer_interrupt+0xd2/0x130 (32)=0A [<c0144943>] =
handle_IRQ_event+0x53/0xa0 (40)=0A [<c01451c2>] do_hardirq+0x52/0xf0 (40)=
=0A [<c0145385>] do_irqd+0x125/0x240 (52)=0A [<c013bc1b>] kthread+0xbb/0xc0=
 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (1048952852)=0A---------=
------------------=0A| preempt count: 00000002 ]=0A| 2-level deep critical =
section nesting:=0A----------------------------------------=0A.. [<c0398142=
>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mutex=
+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075=
b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Aksoftirqd/1/7: BUG in __up_mute=
x at kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc=
87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=
=0A [<c012f246>] run_timer_softirq+0x86/0x470 (60)=0A [<c012a6f2>] ___do_so=
ftirq+0xd2/0x130 (48)=0A [<c012a819>] _do_softirq+0x29/0x30 (8)=0A [<c012ad=
96>] ksoftirqd+0xc6/0x100 (24)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<=
c0104589>] kernel_thread_helper+0x5/0xc (1048895508)=0A--------------------=
-------=0A| preempt count: 00000002 ]=0A| 2-level deep critical section nes=
ting:=0A----------------------------------------=0A.. [<c0398142>] .... _ra=
w_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x47=
0)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   (=
 <=3D dump_stack+0x23/0x30)=0A=0AIRQ 0/2: BUG in __up_mutex at kernel/rt.c:=
1064=0A [<c01075b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0=
x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c010be42>] ti=
mer_interrupt+0xd2/0x130 (32)=0A [<c0144943>] handle_IRQ_event+0x53/0xa0 (4=
0)=0A [<c01451c2>] do_hardirq+0x52/0xf0 (40)=0A [<c0145385>] do_irqd+0x125/=
0x240 (52)=0A [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_th=
read_helper+0x5/0xc (1048952852)=0A---------------------------=0A| preempt =
count: 00000002 ]=0A| 2-level deep critical section nesting:=0A------------=
----------------------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x8=
0=0A.....[<c013dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>]=
 .... print_traces+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x2=
3/0x30)=0A=0Aksoftirqd/1/7: BUG in __up_mutex at kernel/rt.c:1064=0A [<c010=
75b3>] dump_stack+0x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72=
)=0A [<c013e576>] up_mutex+0xb6/0x110 (40)=0A [<c012f246>] run_timer_softir=
q+0x86/0x470 (60)=0A [<c012a6f2>] ___do_softirq+0xd2/0x130 (48)=0A [<c012a8=
19>] _do_softirq+0x29/0x30 (8)=0A [<c012ad96>] ksoftirqd+0xc6/0x100 (24)=0A=
 [<c013bc1b>] kthread+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0=
x5/0xc (1048895508)=0A---------------------------=0A| preempt count: 000000=
02 ]=0A| 2-level deep critical section nesting:=0A-------------------------=
---------------=0A.. [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c0=
13dae1>] ..   ( <=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_t=
races+0x1d/0x60=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0A=
IRQ 0/2: BUG in __up_mutex at kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0=
x23/0x30 (20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] u=
p_mutex+0xb6/0x110 (40)=0A [<c010be42>] timer_interrupt+0xd2/0x130 (32)=0A =
[<c0144943>] handle_IRQ_event+0x53/0xa0 (40)=0A [<c01451c2>] do_hardirq+0x5=
2/0xf0 (40)=0A [<c0145385>] do_irqd+0x125/0x240 (52)=0A [<c013bc1b>] kthrea=
d+0xbb/0xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (1048952852)=
=0A---------------------------=0A| preempt count: 00000002 ]=0A| 2-level de=
ep critical section nesting:=0A----------------------------------------=0A.=
=2E [<c0398142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=
=3D __up_mutex+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=
=0A.....[<c01075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0Aksoftirqd/1/7: =
BUG in __up_mutex at kernel/rt.c:1064=0A [<c01075b3>] dump_stack+0x23/0x30 =
(20)=0A [<c013dc87>] __up_mutex+0x2c7/0x470 (72)=0A [<c013e576>] up_mutex+0=
xb6/0x110 (40)=0A [<c012f246>] run_timer_softirq+0x86/0x470 (60)=0A [<c012a=
6f2>] ___do_softirq+0xd2/0x130 (48)=0A [<c012a819>] _do_softirq+0x29/0x30 (=
8)=0A [<c012ad96>] ksoftirqd+0xc6/0x100 (24)=0A [<c013bc1b>] kthread+0xbb/0=
xc0 (48)=0A [<c0104589>] kernel_thread_helper+0x5/0xc (1048895508)=0A------=
---------------------=0A| preempt count: 00000002 ]=0A| 2-level deep critic=
al section nesting:=0A----------------------------------------=0A.. [<c0398=
142>] .... _raw_spin_lock+0x22/0x80=0A.....[<c013dae1>] ..   ( <=3D __up_mu=
tex+0x121/0x470)=0A.. [<c0140f4d>] .... print_traces+0x1d/0x60=0A.....[<c01=
075b3>] ..   ( <=3D dump_stack+0x23/0x30)=0A=0AIRQ 0/2: BUG in __up_mutex a=
t kernel/rt.c:1064=0A
--9jxsPFA5p3P2qPhR--

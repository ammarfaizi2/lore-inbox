Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268028AbUJPAV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268028AbUJPAV3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 20:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUJPAV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 20:21:29 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:30994 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S268028AbUJPAV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 20:21:27 -0400
Date: Fri, 15 Oct 2004 17:21:05 -0700
To: Bill Huey <bhuey@lnxw.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041016002105.GA24552@nietzsche.lynx.com>
References: <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041015231609.GA23505@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20041015231609.GA23505@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 15, 2004 at 04:16:09PM -0700, Bill Huey wrote:
> Atomic violations:

More atomic violations:

bill


--TB36FDmn/VVEgNH/
Content-Type: application/x-troff
Content-Disposition: attachment; filename=t
Content-Transfer-Encoding: quoted-printable

preempt count: 1=0Aentry 1: _spin_lock+0x22/0x80 / (timer_interrupt+0x1b/0x=
130)=0Ascheduling while atomic: kjournald/0x04010001/821=0Acaller is cond_r=
esched+0x61/0x80=0A [<c04e89fc>] schedule+0x71c/0x760=0A [<c04e8f11>] cond_=
resched+0x61/0x80=0A [<c0138052>] check_preempt_timing+0x192/0x200=0A [<c01=
38108>] touch_preempt_timing+0x48/0x50=0A [<c04e8ed5>] cond_resched+0x25/0x=
80=0A [<c0136d11>] _mutex_lock+0x31/0x70=0A [<c04e8f11>] cond_resched+0x61/=
0x80=0A [<c0136d11>] _mutex_lock+0x31/0x70=0A [<c010c77d>] set_rtc_mmss+0x1=
d/0x1d0=0A [<c0129d39>] update_wall_time_one_tick+0x9/0xb0=0A [<c0129df5>] =
update_wall_time+0x15/0x50=0A [<c010ca4f>] timer_interrupt+0xff/0x130=0A [<=
c013f8e6>] handle_IRQ_event+0x46/0x80=0A [<c013fa27>] __do_IRQ+0x107/0x160=
=0A [<c0108e0b>] do_IRQ+0x4b/0x60=0A [<c01070b8>] common_interrupt+0x18/0x2=
0=0A [<c0246876>] journal_write_metadata_buffer+0x56/0x380=0A [<c02470a6>] =
journal_next_log_block+0x66/0xd0=0A [<c0242ae5>] journal_commit_transaction=
+0x1105/0x1a70=0A [<c0138309>] sub_preempt_count+0x89/0xa0=0A [<c0138309>] =
sub_preempt_count+0x89/0xa0=0A [<c011a1ea>] finish_task_switch+0x4a/0xa0=0A=
 [<c0138052>] check_preempt_timing+0x192/0x200=0A [<c0138309>] sub_preempt_=
count+0x89/0xa0=0A [<c011a1ea>] finish_task_switch+0x4a/0xa0=0A [<c02463ad>=
] kjournald+0x19d/0x430=0A [<c0136820>] autoremove_wake_function+0x0/0x60=
=0A [<c011a1ea>] finish_task_switch+0x4a/0xa0=0A [<c0136820>] autoremove_wa=
ke_function+0x0/0x60=0A [<c02461e0>] commit_timeout+0x0/0x20=0A [<c0246210>=
] kjournald+0x0/0x430=0A [<c0104639>] kernel_thread_helper+0x5/0xc=0Apreemp=
t count: 1=0Aentry 1: _spin_lock+0x22/0x80 / (timer_interrupt+0x1b/0x130)=
=0ADebug: sleeping function called from invalid context swapper(0) at kerne=
l/mutex.c:25=0Ain_atomic():1 [00010002], irqs_disabled():1=0A
--TB36FDmn/VVEgNH/--

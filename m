Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWFACPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWFACPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 22:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWFACPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 22:15:15 -0400
Received: from xenotime.net ([66.160.160.81]:61919 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751500AbWFACPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 22:15:14 -0400
Date: Wed, 31 May 2006 19:17:58 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060531191758.3891d092.rdunlap@xenotime.net>
In-Reply-To: <20060531184046.A30481@unix-os.sc.intel.com>
References: <20060530022925.8a67b613.akpm@osdl.org>
	<20060531182507.aaf1f9fd.rdunlap@xenotime.net>
	<20060531184046.A30481@unix-os.sc.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 18:40:46 -0700 Siddha, Suresh B wrote:

> On Wed, May 31, 2006 at 06:25:07PM -0700, Randy.Dunlap wrote:
> > [   36.489028] Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
> > [   36.500245]  [<0000000000000000>] stext+0x7feff0e8/0xe8
> > [   36.549518] PGD 0 
> > [   36.570488] Oops: 0010 [1] SMP 
> > [   36.593713] last sysfs file: 
> > [   36.616496] CPU 0 
> > [   36.637392] Modules linked in:
> > [   36.660367] Pid: 0, comm: idle Not tainted 2.6.17-rc5-mm1 #1
> > [   36.688549] RIP: 0010:[<0000000000000000>]  [<0000000000000000>] stext+0x7feff0e8/0xe8
> > [   36.704388] RSP: 0000:ffffffff804f4f98  EFLAGS: 00010006
> > [   36.749115] RAX: 0000000000001d00 RBX: ffffffff8054fec8 RCX: 0000000000000000
> > [   36.780475] RDX: ffffffff8054fec8 RSI: ffffffff80544d00 RDI: 000000000000003a
> > [   36.811700] RBP: ffffffff804f4fb0 R08: ffffffff8054e000 R09: 000000000000002f
> > [   36.842745] R10: ffff810003002970 R11: ffffffff80512300 R12: 000000000000003a
> > [   36.873626] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [   36.904373] FS:  0000000000000000(0000) GS:ffffffff80542000(0000) knlGS:0000000000000000
> > [   36.937031] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> > [   36.964797] CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
> > [   36.995261] Process idle (pid: 0, threadinfo ffffffff8054e000, task ffffffff80441800)
> > [   37.027224] Stack: ffffffff8010b711 ffffffff80107d21 0000000000000000 ffffffff8054fef0 
> > [   37.043298]        ffffffff80109708  <EOI> 000020250cff65fa 10250c8b4865c900 1fd8e98148000000 
> > [   37.076996]        0003582444f70000 00fe6ebf12740000 
> > [   37.103370] Call Trace:
> > [   37.140640]  <IRQ> [<ffffffff8010b711>] do_IRQ+0x4f/0x5e
> > [   37.167285]  [<ffffffff80107d21>] mwait_idle+0x0/0x53
> > [   37.193322]  [<ffffffff80109708>] ret_from_intr+0x0/0xa
> > [   37.219723]  <EOI>
> 
> changes mentioned in this thread should help..
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0605.3/1991.html

Ack, thanks, fixed.

---
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVAYV6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVAYV6C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVAYV5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:57:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:19351 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262187AbVAYV4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:56:02 -0500
Date: Tue, 25 Jan 2005 13:55:08 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit tunable
Message-ID: <20050125135508.A24171@build.pdx.osdl.net>
References: <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us> <20050125083724.GA4812@elte.hu> <87oefdfaxp.fsf@sulphur.joq.us> <20050125214900.GA9421@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050125214900.GA9421@elte.hu>; from mingo@elte.hu on Tue, Jan 25, 2005 at 10:49:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> well, there's setrlimit, so you could add a jackd client callback that
> instructs all clients to change their RT_CPU_RATIO rlimit. In theory we
> could try to add a new rlimit syscall that changes another task's rlimit
> (right now the syscalls only allow the changing of the rlimit of the
> current task) - that would enable utilities to change the rlimit of all
> tasks in the system, achieving the equivalent of a global sysctl.

We've talked about smth. similar in another thread.  I'm not opposed to
the idea.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

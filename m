Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290391AbSAPJR2>; Wed, 16 Jan 2002 04:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290387AbSAPJRK>; Wed, 16 Jan 2002 04:17:10 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:44969 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290390AbSAPJQI>; Wed, 16 Jan 2002 04:16:08 -0500
Date: Wed, 16 Jan 2002 04:15:47 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: <mingo@devserv.devel.redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] I3 sched tweaks...
In-Reply-To: <E16Qiwf-0008Fd-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0201160412180.24929-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Jan 2002, Rusty Russell wrote:

> 1) Comment about RT event id removed (no longer relevent).
> 2) Order by address, delete rq_cpu().
> 3) lock_task_rq returns the rq, rather than assigning it, for clarity.

ok.

> 4) scheduler_tick needs no args (p is always equal to current).

i have not taken this part. We have 'current' calculated in
update_process_times(), so why not pass it along to the scheduler_tick()
function?

> 5) Unused max_rq_len() function deleted.

ok.

	Ingo


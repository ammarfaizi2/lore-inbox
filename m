Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVA1IKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVA1IKo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVA1IKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:10:44 -0500
Received: from mail.joq.us ([67.65.12.105]:13498 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261165AbVA1IKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:10:39 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	<20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	<87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu>
	<87fz0neshg.fsf@sulphur.joq.us>
	<1106782165.5158.15.camel@npiggin-nld.site>
	<874qh3bo1u.fsf@sulphur.joq.us>
	<1106796360.5158.39.camel@npiggin-nld.site>
	<20050128063857.GA32658@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Fri, 28 Jan 2005 02:09:38 -0600
In-Reply-To: <20050128063857.GA32658@elte.hu> (Ingo Molnar's message of
 "Fri, 28 Jan 2005 07:38:57 +0100")
Message-ID: <87acqu2cvx.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>> But the important elements are lost. The standard provides a
>> deterministic scheduling order, and a deterministic scheduling latency
>> (of course this doesn't mean a great deal for Linux, but I think we're
>> good enough for a lot of soft-rt applications now).
>> 
>> >  [1] http://www.opengroup.org/onlinepubs/007908799/xsh/realtime.html
>
> no, the patch does not break POSIX. POSIX compliance means that there is
> an environment that meets POSIX. Any default install of Linux 'breaks'
> POSIX in a dozen ways, you have to take a number of steps to get a
> strict, pristine POSIX environment. The only thing that changes is that
> now you have to add "set RT_CPU ulimit to 0 or 100" to that (long) list
> of things.

I agree.  Is the rest of this list documented somewhere?
-- 
  joq

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWHCBmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWHCBmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 21:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWHCBmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 21:42:08 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:21692
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1750728AbWHCBmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 21:42:07 -0400
Date: Wed, 2 Aug 2006 18:41:54 -0700
To: Mark Knecht <markknecht@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.6.17-rt8 crash amd64
Message-ID: <20060803014154.GA3370@gnuppy.monkey.org>
References: <20060802011809.GA26313@gnuppy.monkey.org> <5bdc1c8b0608021820u5235c491tdf9b25f5906fe3f8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0608021820u5235c491tdf9b25f5906fe3f8@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 06:20:50PM -0700, Mark Knecht wrote:
> On 8/1/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> >Hello folks,
> >
> >I'm getting this:
> >
> >[   41.989355] BUG: scheduling while atomic: udevd/0x00000001/1101
> <SNIP>
> >[   42.198871]        <ffffffff8025ce3d>{error_exit+0}
> >[   42.204040]        <ffffffff8025bf22>{system_call+126}
> >[   42.209715] ---------------------------
> >[   42.213716] | preempt count: 00000001 ]
> >[   42.217715] | 1-level deep critical section nesting:
> >[   42.222879] ----------------------------------------
> >[   42.228043] .. [<ffffffff8025ef7d>] .... __schedule+0xb3/0xb2a
> >[   42.234150] .....[<ffffffff8025fd89>] ..   ( <= schedule+0xec/0x11e)
> >[   42.240796]
> >[   53.347726] NET: Registered protocol family 10
> >[   53.353240] IPv6 over IPv4 tunneling driver
> 
> Hi,
>   Similar problems here also but in my case it said '2-level deep'
> and I had different stuff after that message. AMD64/ NVidia MB. I
> don't have a second Linux machine handle to do the remote boot console
> thing. If it's important that I send in more info I'll get a camera or
> something like that. Let me know if it's required.
> 
>   Anyway, not a one machine problem at all.

Any stack trace is welcomed.

I just changed a couple of things to get a better stack trace and it's
changed the timing of the system where I can't get a reliable stack
trace anymore. Try another route...

bill


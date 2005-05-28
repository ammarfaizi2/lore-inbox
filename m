Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVE1Fsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVE1Fsc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 01:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVE1Fsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 01:48:31 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:7692 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262086AbVE1Fs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 01:48:27 -0400
Date: Fri, 27 May 2005 22:53:18 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Lee Revell <rlrevell@joe-job.com>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050528055318.GB2958@nietzsche.lynx.com>
References: <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <1117254442.4253.12.camel@mindpipe> <4297F6F2.3040804@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4297F6F2.3040804@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2005 at 02:43:30PM +1000, Nick Piggin wrote:
> If you are talking about soft-RT, or things running on Linux today,
> then sure they'll keep working. Even some or all of PREEMPT_RT may
> be merged into the Linux guest too, for better soft-RT. I haven't
> been arguing against that.

Hard RT guarantee are very possible, not in years, but months (possibly
already) under constraints previously outlined.

[dual complexity issues snippeted]

> I agree we'll never have a fully functional hard-RT Linux kernel.
> But this thread hasn't been about whether or not the RT task knows
> what it is doing (we assume it does), but the possibility of making
> more parts of the kernel able to provide some RT guarantee (ie. so
> said RT task *can* use more functionality).

No sane RT app person is going to call into the kernel and expect
guarantees in a general purpose system. Folks doing this kind of
RT work will have at least a path that they can follow to *possibly*
make this happen. It's all conjecture at the moment and it won't be
known until somebody takes a shot at it and all associated kernel
issues. It's most definitely a worthy project.

If this happens Linux would be an ideal kernel for digital video
recorders and such.

bill


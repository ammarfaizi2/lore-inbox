Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbUJaKAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUJaKAr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUJaKAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:00:47 -0500
Received: from mail.gmx.de ([213.165.64.20]:18099 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261520AbUJaKAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:00:40 -0500
X-Authenticated: #4399952
Date: Sun, 31 Oct 2004 11:00:39 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041031110039.4575e49c@mango.fruits.de>
In-Reply-To: <1099189225.1754.1.camel@krustophenia.net>
References: <20041029172243.GA19630@elte.hu>
	<20041029203619.37b54cba@mango.fruits.de>
	<20041029204220.GA6727@elte.hu>
	<20041029233117.6d29c383@mango.fruits.de>
	<20041029212545.GA13199@elte.hu>
	<1099086166.1468.4.camel@krustophenia.net>
	<20041029214602.GA15605@elte.hu>
	<1099091566.1461.8.camel@krustophenia.net>
	<20041030115808.GA29692@elte.hu>
	<1099158570.1972.5.camel@krustophenia.net>
	<20041030191725.GA29747@elte.hu>
	<20041030214738.1918ea1d@mango.fruits.de>
	<1099165925.1972.22.camel@krustophenia.net>
	<20041030221548.5e82fad5@mango.fruits.de>
	<1099167996.1434.4.camel@krustophenia.net>
	<20041030231358.6f1eeeac@mango.fruits.de>
	<1099189225.1754.1.camel@krustophenia.net>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 22:20:24 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> Here is a patch that causes the number of consecutive missed interrupts
> to be printed, as well as setting RT priority itself instead of relying
> on the rt_wakeup wrapper.
> 
> I have found that moving the mouse quickly will reliably cause many
> interrupts to be missed.

thanks for the patch (it has a little problem, since it uses prio 99 which
is always equal or greater than the rtc thread prio. i changed it in my
local version to accept a parameter). will do some more cleanup of the
program [saner option handling, msec/usec output of the relevant cycle
counts, history file output, ctrl-c handling etc].

U\L in an hour or two.

flo

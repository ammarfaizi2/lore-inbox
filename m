Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbUKBLI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUKBLI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 06:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUKBLI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 06:08:56 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:60434 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261183AbUKBLIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 06:08:49 -0500
Date: Tue, 2 Nov 2004 03:08:10 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5 (networking problems)
Message-ID: <20041102110810.GA11393@nietzsche.lynx.com>
References: <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <417F7D7D.5090205@stud.feec.vutbr.cz> <20041027134822.GA7980@elte.hu> <417FD9F2.8060002@stud.feec.vutbr.cz> <20041028115719.GA9563@elte.hu> <20041030000234.GA20986@nietzsche.lynx.com> <20041102085650.GA3973@nietzsche.lynx.com> <20041102093758.GA28014@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102093758.GA28014@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 10:37:58AM +0100, Ingo Molnar wrote:
> * Bill Huey <bhuey@lnxw.com> wrote:
> > [nasty networking crash trace]
...
> which attempts to fix this particular deadlock.

getting closer...

http:590 BUG: lock held at task exit time!
 [c03f9e84] {r:0,a:-1,kernel_sem.lock}
 .. held by:              http/  590 [dc0508a0, 121]
 ... acquired at:  __schedule+0x3ac/0x850


bill


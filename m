Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbUJYMLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbUJYMLS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUJYMLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:11:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41961 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261769AbUJYMLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:11:16 -0400
Date: Mon, 25 Oct 2004 14:12:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041025121210.GA6555@elte.hu>
References: <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com> <20041025111046.GA3630@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025111046.GA3630@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > >[ NOTE: there's one known bug in this release: selinux on one of my
> > >testsystems broke, it hangs during bootup. With CONFIG_SECURITY disabled
> > >it works fine. I'm working on the fix. So please keep CONFIG_SECURITY
> > >disabled for the time being. ]
> > >
> > Does this include all models of security or just the selinux stuff?
> 
> i have only tried selinux. (which is installed/enabled by default on
> FC3 so it's easy for me to test on an out of box distro.)

i think i found the bug - now selinux boots fine. I've uploaded -V0.1
with the fix included. This fix could solve a number of other complaints
as well.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbUKNM43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUKNM43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 07:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUKNM43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 07:56:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:30086 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261296AbUKNM4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 07:56:25 -0500
X-Authenticated: #4399952
Date: Sun, 14 Nov 2004 13:56:56 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041114135656.7aa3b95b@mango.fruits.de>
In-Reply-To: <20041111215122.GA5885@elte.hu>
References: <20041022155048.GA16240@elte.hu>
	<20041022175633.GA1864@elte.hu>
	<20041025104023.GA1960@elte.hu>
	<20041027001542.GA29295@elte.hu>
	<20041103105840.GA3992@elte.hu>
	<20041106155720.GA14950@elte.hu>
	<20041108091619.GA9897@elte.hu>
	<20041108165718.GA7741@elte.hu>
	<20041109160544.GA28242@elte.hu>
	<20041111144414.GA8881@elte.hu>
	<20041111215122.GA5885@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2004 22:51:22 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> i have released the -V0.7.25-1 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/

Hi,

i just build and booted into 26-3 (w/o debugging stuff) and put a little
load on the system (find /'s plus kernel compile plus rtc_wakeup -f 8192).
Got this on the console:

`IRQ 8` [14] is being piggy. need_resched=0, cpu=0

and the machine locked. will build with debugging and try to reproduce.

flo

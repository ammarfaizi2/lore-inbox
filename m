Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbUKNOLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbUKNOLA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 09:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbUKNOLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 09:11:00 -0500
Received: from pop.gmx.net ([213.165.64.20]:43670 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261309AbUKNOKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 09:10:55 -0500
X-Authenticated: #4399952
Date: Sun, 14 Nov 2004 15:11:31 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041114151131.162f7676@mango.fruits.de>
In-Reply-To: <41975D16.3050402@cybsft.com>
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
	<20041114135656.7aa3b95b@mango.fruits.de>
	<41975D16.3050402@cybsft.com>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004 07:26:46 -0600
"K.R. Foley" <kr@cybsft.com> wrote:

> Did you get any other messages in the log? This message is harmless as 
> far as the machine locking. This gets printed from rtc when a read of 
> /dev/rtc is missed before another interrupt arrives.

Arr, this time it just locked silently. sys-rq keysd were still available
but didn't produce any console output (sys-rq-b still rebooted the machine
though :))

I suppose this doesn't relly make sense w/o a serial console. I will get a
second machine on next friday. Then i can hopefully provide more useful info
than "he my machine locked up"..

flo

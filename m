Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbUKQLW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbUKQLW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbUKQLWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:22:25 -0500
Received: from imap.gmx.net ([213.165.64.20]:51384 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262202AbUKQLWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:22:22 -0500
X-Authenticated: #4399952
Date: Wed, 17 Nov 2004 12:23:18 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: john cooper <john.cooper@timesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       Mark_H_Johnson@raytheon.com, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041117122318.479805fa@mango.fruits.de>
In-Reply-To: <419A961A.2070005@timesys.com>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com>
	<20041116184315.GA5492@elte.hu>
	<419A5A53.6050100@cybsft.com>
	<20041116212401.GA16845@elte.hu>
	<20041116222039.662f41ac@mango.fruits.de>
	<20041116223243.43feddf4@mango.fruits.de>
	<20041116224257.GB27550@elte.hu>
	<20041116230443.452497b9@mango.fruits.de>
	<20041116231145.GC31529@elte.hu>
	<20041116235535.6867290d@mango.fruits.de>
	<20041117002926.32a4b26f@mango.fruits.de>
	<419A961A.2070005@timesys.com>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 19:06:50 -0500
john cooper <john.cooper@timesys.com> wrote:

> > Arr, it did lock up again. This time i was in X, so i couldn't use any sysrq
> > stuff to see something. Will try tomorrow again..
> 
> Was this random or under some particular stress/load?

I had rtc_wakeup running with a rtc frequency of 8192 hz at the time plus
some general usage (reading mails, etc..) In earlier kernels it seemed that
the lock fell together with the rtc IRQ being piggy. will try to reproduce
now with the freshest RP kernel.

flo

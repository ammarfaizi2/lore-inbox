Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUKVBJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUKVBJj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 20:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUKVBHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 20:07:24 -0500
Received: from imap.gmx.net ([213.165.64.20]:40905 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261882AbUKVBGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 20:06:48 -0500
X-Authenticated: #4399952
Date: Mon, 22 Nov 2004 02:07:41 +0100
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
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041122020741.5d69f8bf@mango.fruits.de>
In-Reply-To: <20041122005411.GA19363@elte.hu>
References: <20041108165718.GA7741@elte.hu>
	<20041109160544.GA28242@elte.hu>
	<20041111144414.GA8881@elte.hu>
	<20041111215122.GA5885@elte.hu>
	<20041116125402.GA9258@elte.hu>
	<20041116130946.GA11053@elte.hu>
	<20041116134027.GA13360@elte.hu>
	<20041117124234.GA25956@elte.hu>
	<20041118123521.GA29091@elte.hu>
	<20041118164612.GA17040@elte.hu>
	<20041122005411.GA19363@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004 01:54:11 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> i have released the -V0.7.30-2 Real-Time Preemption patch, which can be
> downloaded from the usual place:

> the biggest change in this release are fixes for priority-inheritance
> bugs uncovered by Esben Nielsen pi_test suite. These bugs could explain
> some of the jackd-under-load latencies reported.

It seems these large load related xruns are gone :) At least i wasn't able
to trigger any during my uptime of 52 min. Will report if i ever see  any of
those again.

flo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbUK2NPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbUK2NPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 08:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUK2NPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 08:15:34 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:57042 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261353AbUK2NP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 08:15:27 -0500
Message-ID: <41358.195.245.190.93.1101734020.squirrel@195.245.190.93>
In-Reply-To: <20041129111634.GB10123@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93>
    <20041129111634.GB10123@elte.hu>
Date: Mon, 29 Nov 2004 13:13:40 -0000 (WET)
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 29 Nov 2004 13:15:26.0162 (UTC) FILETIME=[7D832320:01C4D615]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Rui Nuno Capela wrote:
>
>>   xruntrace1.0.tar.gz
>>      - scripts used for xrun trace capture automation
>>
>>   xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-7.tar.gz
>>      - actual xrun traces captured while running jackd on RT-V0.7.31-7
>
> the trace buffer is too small to capture a significant portion of the
> xrun - i'd suggest for you to increase it from 4096-1 to 4096*16-1, to
> be able to capture a couple of hundreds of millisecs worth of traces.
>

and how I do that? Is it some /proc magic or its in the kernel configuration?

please forgive my ignorance:)

bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


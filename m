Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVAXNfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVAXNfD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 08:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVAXNfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 08:35:03 -0500
Received: from mx2.elte.hu ([157.181.151.9]:19122 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261451AbVAXNe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 08:34:59 -0500
Date: Mon, 24 Jan 2005 14:34:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Alexander Nyberg <alexn@dsv.su.se>
Subject: Re: [patch, 2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit tunable
Message-ID: <20050124133434.GA4196@elte.hu>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124125814.GA31471@elte.hu>
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


> ok, here is another approach, against 2.6.10/11-ish kernels:
> 
>   http://redhat.com/~mingo/rt-limit-patches/
> 
> this patch adds the /proc/sys/kernel/rt_cpu_limit tunable: the maximum
> amount of CPU time all RT tasks combined may use, in percent. Defaults
> to 80%.

i've just updated the -B4 patch - the earlier (-B3) patch had
a last-minute bug that made the kernel enforce limit/10 - i.e.
8% instead of 80% ...

	Ingo

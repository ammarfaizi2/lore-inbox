Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263140AbVBCW3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbVBCW3B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVBCW3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:29:00 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38620 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262645AbVBCW1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:27:12 -0500
Date: Thu, 3 Feb 2005 23:26:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Con Kolivas <kernel@kolivas.org>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050203222656.GA30573@elte.hu>
References: <20050203215927.GA28634@elte.hu> <200502032224.j13MOExF013592@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502032224.j13MOExF013592@localhost.localdomain>
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


* Paul Davis <paul@linuxaudiosystems.com> wrote:

> >having this API on 2.4 kernels. But it would have one big advantage: it
> >would be evidently and trivially RT-safe :-)
> 
> no small advantage.
> 
> it has another big advantage from the user space perspective: no other
> information is required apart from <tid>. no state needs to be
> maintained by the system that uses this. thats a huge win over the
> baroque collection of FIFOs (or futexes) that we have to look after
> now.

ok, i'll whip up something after 2.6.11.

	Ingo

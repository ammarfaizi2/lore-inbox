Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVAYPKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVAYPKP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVAYPKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:10:15 -0500
Received: from mx1.elte.hu ([157.181.1.137]:55759 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261974AbVAYPJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:09:40 -0500
Date: Tue, 25 Jan 2005 16:09:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
Message-ID: <20050125150914.GA23423@elte.hu>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <87u0p6t7fi.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0p6t7fi.fsf@sulphur.joq.us>
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


* Jack O'Quin <joq@io.com> wrote:

> I was just pointing out that saying nice(-20) works as well as
> SCHED_ISO, though true, doesn't mean much since neither of them
> (currently) work well enough to be useful.

ok. While i still think nice--20 can be quite good for some purposes, it
will probably not solve all problems that the audio applications need
solved.

> For good reasons, most audio developers prefer the POSIX realtime
> interfaces.  They are far from perfect, but remain the only workable,
> portable solution available.  That is why I like your rt_cpu_limit
> proposal so much better that this one.

ok - lets forget about nice--20 for now.

	Ingo

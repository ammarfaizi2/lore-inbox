Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVAXKqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVAXKqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 05:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVAXKqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 05:46:55 -0500
Received: from mx2.elte.hu ([157.181.151.9]:24204 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261488AbVAXKqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 05:46:43 -0500
Date: Mon, 24 Jan 2005 11:46:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
Message-ID: <20050124104623.GA25119@elte.hu>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <4d8e3fd3050124015528615310@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd3050124015528615310@mail.gmail.com>
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


* Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:

> On Mon, 24 Jan 2005 09:59:02 +0100, Ingo Molnar <mingo@elte.hu> wrote:
> [...]
> > - CKRM is another possibility, and has nonzero costs as well, but solves
> >  a wider range of problems.
> 
> BTW, do you know what's the status of CKRM ? If I'm not wrong it is
> already widely used, is there any plan to push it to mainstream ?

it's a bit complex and thus not a no-brainer in terms of merging. Also,
the last version of it seems to be against 2.6.8.1. CKRM-cpu is in
essence an additional layer ontop of normal scheduling. Another patch in
this area is fairsched.

	Ingo

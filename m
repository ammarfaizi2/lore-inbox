Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVBBUYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVBBUYe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVBBUTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:19:14 -0500
Received: from mx1.elte.hu ([157.181.1.137]:26801 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262776AbVBBURf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 15:17:35 -0500
Date: Wed, 2 Feb 2005 21:17:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050202201715.GB9462@elte.hu>
References: <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu> <873bwfo8br.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873bwfo8br.fsf@sulphur.joq.us>
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

> The LSM was a stop-gap measure intended to tide us over until a real
> fix could be "done right" for 2.8.  It had the advantage of being
> minimally disruptive to the kernel and its maintainability. [...]

i'm not opposed to the LSM solution per se, especially given that none
of the other solutions in existence are fully satisfactory (and thus
acceptable for the scheduler currently). The LSM patch is clearly the
least intrusive solution.

	Ingo

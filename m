Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbVBCVo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbVBCVo3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVBCVo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:44:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:28883 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263001AbVBCVmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:42:47 -0500
Date: Thu, 3 Feb 2005 22:41:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050203214133.GA27956@elte.hu>
References: <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu> <873bwfo8br.fsf@sulphur.joq.us> <20050202111045.GA12155@nietzsche.lynx.com> <87is5ahpy1.fsf@sulphur.joq.us> <20050202211405.GA13941@nietzsche.lynx.com> <20050202212100.GA12808@elte.hu> <20050202213402.GB14023@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202213402.GB14023@nietzsche.lynx.com>
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


* Bill Huey <bhuey@lnxw.com> wrote:

> > but Jack is right in practical terms: the audio folks achieved pretty
> > good results with the current IRQ threading mechanism, partly due to the
> > fact that the audio stack doesnt use softirqs, so all the
> > latency-critical activities are in the audio IRQ thread and the
> > application itself.
> 
> It's clever that they do that, but additional control is needed in the
> future. jackd isn't the most sophisticate media app on this planet (not
> too much of an insult :)) [...]

i think you are underestimating Jack - it is easily amongst the most
sophisticated audio frameworks in existence, and it certainly has one of
the most robust designs. Just shop around on google for Jack-based audio
applications. What i'd love to see is more integration (and cooperation)
between the audio frameworks of desktop projects (KDE, Gnome) and Jack.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbVBCXEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbVBCXEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 18:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVBCXET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 18:04:19 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:55046 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S263174AbVBCXCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 18:02:35 -0500
Date: Thu, 3 Feb 2005 15:01:27 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, "Jack O'Quin" <joq@io.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050203230127.GA18378@nietzsche.lynx.com>
References: <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu> <873bwfo8br.fsf@sulphur.joq.us> <20050202111045.GA12155@nietzsche.lynx.com> <87is5ahpy1.fsf@sulphur.joq.us> <20050202211405.GA13941@nietzsche.lynx.com> <20050202212100.GA12808@elte.hu> <20050202213402.GB14023@nietzsche.lynx.com> <20050203214133.GA27956@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203214133.GA27956@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 10:41:33PM +0100, Ingo Molnar wrote:
> * Bill Huey <bhuey@lnxw.com> wrote:
> > It's clever that they do that, but additional control is needed in the
> > future. jackd isn't the most sophisticate media app on this planet (not
> > too much of an insult :)) [...]
> 
> i think you are underestimating Jack - it is easily amongst the most
> sophisticated audio frameworks in existence, and it certainly has one of
> the most robust designs. Just shop around on google for Jack-based audio
> applications. What i'd love to see is more integration (and cooperation)
> between the audio frameworks of desktop projects (KDE, Gnome) and Jack.

This is a really long winded and long standing offtopic gripe I have with
general application development under Linux. The only way I'm going to
get folks to understand my position on it is if I code it up in my
implementation language of choice with my own APIs.

There's a TON more that can be done with QoS in the kernel (EDL schedulers),
DSP JIT compiler techniques and other kernel things that can support
pro-audio. I simply can't get to yet until the RT patch has a few more
goodies and I'm permitted to do this as my next project.

I had a crazy prototype of some DSP graph system (in C++) I wrote years
ago for 3D audio where I'm drawing my knowledge from and it's getting
time to resurrect it again if I'm going to provide a proof of concept
to push an edge.

Also, think, people working with the RT patch are also ignoring frame
accurate video and many others things that just haven't been done yet
since the patch is so new and there hasn't been more interest from
folks yet regarding it. I suspect that it's because that folks don't
know about it yet.

bill


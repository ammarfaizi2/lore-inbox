Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSHTKPN>; Tue, 20 Aug 2002 06:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSHTKPN>; Tue, 20 Aug 2002 06:15:13 -0400
Received: from cibs9.sns.it ([192.167.206.29]:48400 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S316770AbSHTKPM>;
	Tue, 20 Aug 2002 06:15:12 -0400
Date: Tue, 20 Aug 2002 12:13:44 +0200 (CEST)
From: venom@sns.it
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Larry McVoy <lm@bitmover.com>,
       Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, Dax Kelson <dax@gurulabs.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Does Solaris really scale this well?
In-Reply-To: <15713.30718.950168.358907@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.43.0208201209560.13141-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


80% is quite possible, I have similar results with a E10K domain of
around 32 CPUs, with a 100mhz bus. Buf 80% is far from 94%...



On Tue, 20 Aug 2002, Peter Chubb wrote:

> Date: Tue, 20 Aug 2002 08:58:06 +1000
> From: Peter Chubb <peter@chubb.wattle.id.au>
> To: venom@sns.it
> Cc: Larry McVoy <lm@bitmover.com>,
>      Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
>      Matti Aarnio <matti.aarnio@zmailer.org>, Dax Kelson <dax@gurulabs.com>,
>      "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> Subject: Re: Does Solaris really scale this well?
>
> >>>>> "venom" == venom  <venom@sns.it> writes:
>
> venom> On Sat, 17 Aug 2002, Larry McVoy wrote:
> >> Date: Sat, 17 Aug 2002 17:55:17 -0700 From: Larry McVoy
>
> venom> And where reasonable != 94%. Seriously, 94% scalability could
> venom> be on a 8 CPUs 880, but, for example, I have a 64 CPUS domain
> venom> on a E10k which is far from 94% scalability (ok, an old E10k
> venom> with an 83Mhz bus).  For what I saw, maybe SGI Origin 3000 is
> venom> scaling a little better with a lot of CPUS, but I also never
> venom> had an E15000 around for now...
>
> I've played around with 8-way E10000 and a 128-way Origin.
> Both scaled reasonably from an OS perspective --- enabling more cpus on
> a mixed lots-of-small-jobs workload increased performance close to
> linearly --- from memory (and it was a couple of years ago) above
> 80%, and in some tests better than that.  Unfotunately, I no longer
> have access either to the machines or to the data, as I've changed jobs...
>
> Peter C
>


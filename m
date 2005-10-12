Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbVJLRsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbVJLRsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbVJLRsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:48:30 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57058 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751474AbVJLRsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:48:30 -0400
Subject: Re: 2.6.14-rc4-rt1
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <5bdc1c8b0510120937r45bbd26fr6f45b6e3a9895d3f@mail.gmail.com>
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
	 <5bdc1c8b0510111408n4ef45eadv1e12ec4d1271d971@mail.gmail.com>
	 <5bdc1c8b0510111413q7b1ea391n3bc27924d928b963@mail.gmail.com>
	 <1129065696.4718.10.camel@mindpipe>
	 <5bdc1c8b0510120937r45bbd26fr6f45b6e3a9895d3f@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 13:48:24 -0400
Message-Id: <1129139304.10599.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-12 at 09:37 -0700, Mark Knecht wrote:
> On 10/11/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Tue, 2005-10-11 at 14:13 -0700, Mark Knecht wrote:
> > > The machine had been essentially 'User space idle' for the previous
> > > two hours. The screen saver had kicked in. Audio was running and the
> > > machine was busy. I woke it up, gave xscreensaver my password, read
> > > email, sent the previous mail, then picked up the telephone to make a
> > > call. Not 2 seconds later the xruns occurred!
> >
> > So what does /proc/latency_trace report?
> >
> > Lee
> 
> Well, unfortunately it doesn't appear to report anythign helpful. The
> maximum latency report did not change when the xrun occurred. This was
> the last one reported and it happened long before the xrun:

Sounds like an application bug (some JACK client doing something not RT
safe).  Can you reproduce the xruns if you just run jackd with no
clients?

Lee


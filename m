Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVJRBuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVJRBuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 21:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVJRBuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 21:50:15 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:62568 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932278AbVJRBuO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 21:50:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hE79k5kubef6iMHYBSp0FPiuUYqhJH2GfewL5PLWuahdOzekH1NjbuRjMsmniR1lpFzueb3piBsXQe941nZYswDgzHeGw21AJacvkCzBH31CNLiEL+9hZLXImPyBDAn48M5ZtqDWyrMY7DhlWFsltCvuU2U2KW3AZElpHViEPhY=
Message-ID: <5bdc1c8b0510171850y4a81698bvbb1dc9f51d12757e@mail.gmail.com>
Date: Mon, 17 Oct 2005 18:50:11 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: 2.6.14-rc4-rt7
Cc: Ingo Molnar <mingo@elte.hu>, cc@ccrma.stanford.edu,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <1129599029.10429.1.camel@cmn3.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017160536.GA2107@elte.hu>
	 <1129576885.4720.3.camel@cmn3.stanford.edu>
	 <1129599029.10429.1.camel@cmn3.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/05, Fernando Lopez-Lezcano <nando@ccrma.stanford.edu> wrote:
> On Mon, 2005-10-17 at 12:21 -0700, Fernando Lopez-Lezcano wrote:
> > On Mon, 2005-10-17 at 18:05 +0200, Ingo Molnar wrote:
> > > i have released the 2.6.14-rc4-rt7 tree, which can be downloaded from
> > > the usual place:
> > >
> > >   http://redhat.com/~mingo/realtime-preempt/
> > >
> > > the biggest change is the merging of "ktimers next step", a'ka the
> > > clockevents framework, from Thomas Gleixner. This is mostly a design
> > > cleanup of the existing timekeeping, timer and HRT codebase. One
> > > user-visible aspect is that the PIT timer is now available as a hres
> > > source too - APIC-less systems will find this useful.
> >
> > Some feedback. It looks like the issues I was having are gone, no weird
> > key repeats or screensaver activations __plus__ no problems so far with
> > spurious warnings from Jack! Woohooo!!! (of course it may be that I
> > start getting them as soon as I press send)
>
> It took some time but I got a couple of instances of keys repeating too
> fast (it happened 3 or 4 times). Regretfully no BUG messages
> in /var/log/messages this time...
>
> -- Fernando
>
1) I managed to get through the whole day running Jack at 64/2 with no
xruns. A first.

2) I'm not clear about the latency Daniel reported. IS that the logout
problem I'm seeing or something else.

WRT the logout problem - after being logged in for a while the log out
problem doesn't happen. It only happens if I log out relatively soon
after logging in.

Great work Ingo!

- Mark

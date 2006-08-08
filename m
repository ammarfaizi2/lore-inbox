Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbWHHVoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWHHVoh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWHHVoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:44:37 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:6816 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965042AbWHHVog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:44:36 -0400
Date: Tue, 8 Aug 2006 17:44:17 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Robert Crocombe <rcrocomb@gmail.com>
cc: hui Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re:
 Problems with 2.6.17-rt8
In-Reply-To: <e6babb600608081435l575f8ecdhbbc35066a8357f59@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0608081740530.17442@gandalf.stny.rr.com>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com> 
 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com> 
 <1154541079.25723.8.camel@localhost.localdomain> 
 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com> 
 <1154615261.32264.6.camel@localhost.localdomain>  <20060808025615.GA20364@gnuppy.monkey.org>
  <20060808030524.GA20530@gnuppy.monkey.org> 
 <e6babb600608081146k663e3ee4g4b93ba325bf9257e@mail.gmail.com> 
 <Pine.LNX.4.58.0608081506060.16824@gandalf.stny.rr.com>
 <e6babb600608081435l575f8ecdhbbc35066a8357f59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006, Robert Crocombe wrote:

> On 8/8/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> > How far back do you get this bug?  I mean if you go back and test the
> > previous kernels, where did you start seeing this?
>
> I have so far been unable to provoke the problem under 2.6.16-rt29.
>
> I was able to provoke things once easily under 17-rt1, but subsequent
> attempts to trigger the bug have so far yielded no results.
>
> I'm back to poking at 16-rt29 to see if the problem is simply somewhat
> less likely.

Is it easy to poke the problem with -rt8?  Just want to know if -rt8 has
caused the problem to be more prevalent.

-- Steve


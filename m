Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWEZWdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWEZWdD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 18:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbWEZWdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 18:33:03 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:31683 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751298AbWEZWdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 18:33:02 -0400
Subject: Re: 2.6.16-rt24 Won't Apply
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Knecht <markknecht@gmail.com>
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5bdc1c8b0605261511u1d4c224rb766638de367e2c@mail.gmail.com>
References: <44775129.6030004@cybsft.com> <20060526194315.GA860@elte.hu>
	 <44775F43.8020500@cybsft.com>
	 <5bdc1c8b0605261511u1d4c224rb766638de367e2c@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 26 May 2006 18:32:49 -0400
Message-Id: <1148682769.6830.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 15:11 -0700, Mark Knecht wrote:

> 
> Ingo & (I think) Steven,
>    -rt25 applies cleanly and boots fine on my AMD64 UMP machine.

That's good to hear.  BTW, do you mean UP machine? or do you have a
Uni-Multi-Processor machine :)

> 
> mark@lightning ~ $ uname -a
> Linux lightning 2.6.16-rt25 #1 PREEMPT Fri May 26 14:53:47 PDT 2006
> x86_64 AMD Athlon(tm) 64 Processor 3000+ GNU/Linux
> mark@lightning ~ $
> 
>    Thanks to all for putting this fix together. I'm sorry I didn't do
> much with the 2.6.16-rt series. I was so happy with 2.6.15-rt18 I
> never moved forward. I promise to take a lot at 2.6.17 when that comes
> along.

Also, thanks a lot for the comment about 2.6.15-rt18.  If it ain't
broken, don't fix it.  There's no reason for you to upgrade if what you
have works.  If you just like to test our stuff, then that's great and
we really do appreciate it.

I've been working on embedded devices too much and haven't tested my
x86_64 machine in a while either, I think the last I booted was in the
2.6.15-rt16 (that's the oldest in my /boot directory).  Heck, I was
still running 2.6.15 plain.

I happened to wipe out the flash drive on my embedded device and had to
wait for the recovery CD iso to be sent to me (Germany happens to have
some sort of Holiday, so no one was in the office).  So I remembered
that people where having problems with x86_64 and -rt, so I spent the
day finding out why.  It wasn't much of a patch, but boy was it hard to
find.

Thanks,

-- Steve



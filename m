Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVIMUJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVIMUJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbVIMUJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:09:35 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58598 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932075AbVIMUJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:09:34 -0400
Date: Tue, 13 Sep 2005 22:10:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.13-rt6, ktimer subsystem
Message-ID: <20050913201004.GA32608@elte.hu>
References: <20050913100040.GA13103@elte.hu> <1126641589.13893.52.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126641589.13893.52.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2005-09-13 at 12:00 +0200, Ingo Molnar wrote:
> > i have released the 2.6.13-rt6 tree, which can be downloaded from the 
> > usual place:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/
> 
> 
> Ingo,
> 
> Is this supposed to work on amd64?  Lots of people on linux-audio-user 
> report that it just reboots immediately when booting the kernel.  I 
> have the .configs if you want them.

it wont even build right now, due to the ktimer changes. I'll fix x64 up 
once things have settled down a bit. (but if someone does patches i'll 
sure apply them)

	Ingo

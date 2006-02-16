Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWBPUZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWBPUZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWBPUZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:25:53 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:15500 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964900AbWBPUZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:25:52 -0500
Date: Thu, 16 Feb 2006 21:23:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
Message-ID: <20060216202357.GA21415@elte.hu>
References: <20060216094130.GA29716@elte.hu> <1140107585.21681.18.camel@localhost.localdomain> <20060216172435.GC29151@elte.hu> <1140111257.21681.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140111257.21681.26.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> On Thu, 2006-02-16 at 18:24 +0100, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > Another thing I noticed was that futex_offset on the surface looks 
> > > like a malicious users dream variable .. [...]
> > 
> > i have no idea what you mean by that - could you explain whatever threat 
> > you have in mind, in more detail?
> 
> 	As I said, "on the surface" you could manipulate the 
> futex_offset to access memory unrelated to the futex structure . 
> That's all I'm referring too ..

and? You can 'manipulate' arbitrary userspace memory, be that used by 
the kernel or not, and you can do a sys_futex(FUTEX_WAKE) on any 
arbitrary userspace memory address too (this is a core property of 
futexes). You must have meant something specific when you said "on the 
surface looks like a malicious users dream variable". In other words: 
please move your statement out of innuendo by backing it up with 
specifics (or by retracting it) - right now it's hanging in the air :)

	Ingo

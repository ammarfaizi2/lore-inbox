Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWAZRrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWAZRrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 12:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWAZRrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 12:47:20 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:16627 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751344AbWAZRrT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 12:47:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VBBrmpi5XggCWICWqDz3lbQW2BnJe3HwAf/BhpLevKn74YCWOGNYGkC+ZqN/n3x151laMH+uw06SKMV1ehv4M+da2OZNzaLhbUrAkGEx94vWda/ceUdUzAmZcNorWuz3m28rWXzi17C15XiTV4VJTHEjSKpzrHlu8nXAXPGy7v0=
Message-ID: <6bffcb0e0601260947g76dec61cu@mail.gmail.com>
Date: Thu, 26 Jan 2006 18:47:18 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] kstopmachine has legit preempt_enable_no_resched (was: 2.6.15-rt12 bugs)
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1138137450.6695.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6bffcb0e0601230521l59b8360et@mail.gmail.com>
	 <1138065822.6695.6.camel@localhost.localdomain>
	 <6bffcb0e0601240533h3ba1a01ci@mail.gmail.com>
	 <1138112388.6695.26.camel@localhost.localdomain>
	 <6bffcb0e0601240737u3e77245g@mail.gmail.com>
	 <1138126262.6695.29.camel@localhost.localdomain>
	 <6bffcb0e0601241300xd0b8d8dt@mail.gmail.com>
	 <1138137450.6695.34.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/01/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 2006-01-24 at 22:00 +0100, Michal Piotrowski wrote:
> > To 2.6.15-rt1 - it doesn't compile (ipv6 module). 2.6.15-rt2 gives me
> > wonderful series of oops/warnings/badness on boot ;).
>
> Ingo was busy at the time getting true mutexes into the kernel.  So he
> was pushing the -rt stuff out before testing.  So I created a tree to
> handle this:
>
> These are patches against Ingo's -rt patches, that should help make some
> of your problems work.
>
> http://home.stny.rr.com/rostedt/patches/archive/patch-2.6.15-rt1-sr2
> http://home.stny.rr.com/rostedt/patches/archive/patch-2.6.15-rt2-sr3
> http://home.stny.rr.com/rostedt/patches/archive/patch-2.6.15-rt3-sr1
> http://home.stny.rr.com/rostedt/patches/patch-2.6.15-rt4-sr2
>
> -- Steve
>
>
>

Sorry for late answer, but I have exams.

Unfortunately these patches doesn't solve my problems. I have tried
many rt-patches, but everything below 2.6.15-rt8 doesn't work
(compilation or boot problems). Is there any other way to track down
this bug? (any magic ipv6 debugging option? :)

Regards,
Michal Piotrowski

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270085AbTGMDok (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 23:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270086AbTGMDok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 23:44:40 -0400
Received: from wsip-68-15-8-100.sd.sd.cox.net ([68.15.8.100]:4992 "EHLO gnuppy")
	by vger.kernel.org with ESMTP id S270085AbTGMDoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 23:44:38 -0400
Date: Sat, 12 Jul 2003 20:59:18 -0700
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       Miguel Freitas <miguel@cetuc.puc-rio.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
Message-ID: <20030713035918.GA958@gnuppy.monkey.org>
References: <1058017391.1197.24.camel@mf> <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com> <20030712154942.GB9547@mail.jlokier.co.uk> <Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com> <20030712224246.GA5354@gnuppy.monkey.org> <Pine.LNX.4.55.0307121928540.3528@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307121928540.3528@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.5.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 07:39:25PM -0700, Davide Libenzi wrote:
> This is funny. Every time I found something interesting to read (papers) I
> print them and I stock on my desk. The are 25Kg of papers piled on my desk
> right now. Thanks to you, 25.05Kg now ;) Upon a brief read, The Italian Job,
> hemm ... paper, is very similar to SOFTRR. Once you change their "server"
> notion with the per-user allocation I have in mind, it'll come even
> closer. I really didn't have time to read the MS paper though. The problem
> is not if it can be done, the problem is how bad ppl wants it.

I want it badly, but that's just me. :) The MS is about extending these
concept to apply to SMP resource allocation, which currently isn't something
that these kind of schedulers do. IMO, all of this kind of stuff is going to
be crucial for the next generation of operating systems.  Glue that scheduler
to a thread that's suppose to process network packets/io channels and you'll
have ubiquitous QoS throughout the system directly controllable by the scheduler.

That's my intuition on the subject. Time will tell.

bill


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWJGRID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWJGRID (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 13:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWJGRIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 13:08:02 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60345 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932321AbWJGRIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 13:08:00 -0400
Subject: Re: [Alsa-user] Pb with simultaneous SATA and ALSA I/O
From: Lee Revell <rlrevell@joe-job.com>
To: Dominique Dumont <domi.dumont@free.fr>
Cc: alsa-user <alsa-user@lists.sourceforge.net>,
       Francesco Peeters <Francesco@FamPeeters.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <878xjs1geq.fsf@gandalf.hd.free.fr>
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	 <13158.212.123.217.246.1159186633.squirrel@www.fampeeters.com>
	 <87y7rusddc.fsf@gandalf.hd.free.fr> <1160081110.2481.104.camel@mindpipe>
	 <87r6xmscif.fsf@gandalf.hd.free.fr> <1160083137.2481.108.camel@mindpipe>
	 <878xjs1geq.fsf@gandalf.hd.free.fr>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 13:08:34 -0400
Message-Id: <1160240915.17615.57.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-07 at 14:03 +0200, Dominique Dumont wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > Did you ever try the latency tracer?  (See LKML archives for
> > instructions)
> 
> Yes I did (this time better than 2 or 3 days ago :-/ ).
> 
> - I compiled and booted 2.6.28-rt5 with latency tracer enabled
> - I verified that I got latency trace enabled (seen trace in kern.log)
> 
> I only got some traces after running this (detail added for the sake
> of other newbies like me) :
> 
>    gandalf:/proc/sys/kernel# echo 0 > preempt_max_latency
> 
> Here's the max latency trace I got (note that I got a similar trace
> *before* running the test, so I'd say it's unrelated to the AC3
> drop-out problem.):

I think it must be an electrical noise issue.

Lee


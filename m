Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbUKWSPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbUKWSPO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUKWSOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:14:36 -0500
Received: from brown.brainfood.com ([146.82.138.61]:47025 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261455AbUKWSHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:07:23 -0500
Date: Tue, 23 Nov 2004 12:07:13 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
In-Reply-To: <20041123115201.GA26714@elte.hu>
Message-ID: <Pine.LNX.4.58.0411231206240.2146@gradall.private.brainfood.com>
References: <OF73D7316A.42DF9BE5-ON86256F54.0057B6DC@raytheon.com>
 <Pine.LNX.4.58.0411222237130.2287@gradall.private.brainfood.com>
 <20041123115201.GA26714@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Ingo Molnar wrote:

>
> * Adam Heath <doogie@debian.org> wrote:
>
> > > >i have released the -V0.7.30-2 Real-Time Preemption patch, which can be
> > > >downloaded from the usual place:
> > > >
> > > >            http://redhat.com/~mingo/realtime-preempt/
> >
> > I'm seeing something very odd.  It's against 29-0.  I also seem to
> > recall seeing something similiar reported earlier.
> >
> > I'm seeing pauses on my system.  Not certain what is causing it.
> > Hitting a key on the keyboard unsticks it.
>
> at first sight this looks like a scheduling/wakeup anomaly. Please
> re-report this if it happens with the current (30-4) kernel too. Also,
> could you test the vanilla -mm tree, it has a few scheduler updates too.

2.6.10-rc1-mm3 doesn't have the same problem.  Didn't have a more recent mm
kernel available last night.  Will compile one, and always keep it available.

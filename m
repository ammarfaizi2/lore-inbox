Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262923AbRFFNMx>; Wed, 6 Jun 2001 09:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262982AbRFFNMo>; Wed, 6 Jun 2001 09:12:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43563 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S262923AbRFFNMa>; Wed, 6 Jun 2001 09:12:30 -0400
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: Derek Glidden <dglidden@illusionary.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Jun 2001 07:08:37 -0600
In-Reply-To: <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com>
Message-ID: <m17kyp7o2y.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeffrey W. Baker" <jwbaker@acm.org> writes:

> On Tue, 5 Jun 2001, Derek Glidden wrote:
> 
> >
> > After reading the messages to this list for the last couple of weeks and
> > playing around on my machine, I'm convinced that the VM system in 2.4 is
> > still severely broken.
> >
> > This isn't trying to test extreme low-memory pressure, just how the
> > system handles recovering from going somewhat into swap, which is a real
> > day-to-day problem for me, because I often run a couple of apps that
> > most of the time live in RAM, but during heavy computation runs, can go
> > a couple hundred megs into swap for a few minutes at a time.  Whenever
> > that happens, my machine always starts acting up afterwards, so I
> > started investigating and found some really strange stuff going on.
> 
> I reboot each of my machines every week, to take them offline for
> intrusion detection.  I use 2.4 because I need advanced features of
> iptables that ipchains lacks.  Because the 2.4 VM is so broken, and
> because my machines are frequently deeply swapped, they can sometimes take
> over 30 minutes to shutdown.  They hang of course when the shutdown rc
> script turns off the swap.  The first few times this happened I assumed
> they were dead.

Interesting.  Is it constant disk I/O?  Or constant CPU utilization.
In any case you should be able to comment that line out of your shutdown
rc script and be in perfectly good shape.

Eric

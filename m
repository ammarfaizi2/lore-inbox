Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbTA0UFh>; Mon, 27 Jan 2003 15:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTA0UFh>; Mon, 27 Jan 2003 15:05:37 -0500
Received: from mail.gmx.de ([213.165.64.20]:56712 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261996AbTA0UFg>;
	Mon, 27 Jan 2003 15:05:36 -0500
Message-Id: <5.1.1.6.2.20030127210954.00c73468@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Mon, 27 Jan 2003 21:11:37 +0100
To: Zwane Mwaikambo <zwane@holomorphy.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.59-mm6
Cc: Luuk van der Duim <l.a.van.der.duim@student.rug.nl>,
       <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301271414230.28141-100000@montezuma.mastece
 nde.com>
References: <5.1.1.6.2.20030127191904.00cc2508@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:17 PM 1/27/2003 -0500, Zwane Mwaikambo wrote:
>On Mon, 27 Jan 2003, Mike Galbraith wrote:
>
> > (something seems funky with nmi_watchdog... hard lock = no_more_nmi_ticks
> > .  Anybody out there know enough about local APIC to explain why idle=poll
> > gives nice 1 second nmi, but everything else depends upon cpu load?... and
> > why when hardlock happens, it _stops_)
>
>Because we base the performance counter on unhalted cycles, whilst the
>normal idle function does an hlt. I think the K7 can do halted too.

(well bugger, I _know_ I'm gonna regret this;)

When can the darn thing actually trigger an oops?

         -Mike


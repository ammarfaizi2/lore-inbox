Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266219AbUGJMBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbUGJMBs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUGJMBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:01:48 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:54396 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266219AbUGJMBp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:01:45 -0400
Message-ID: <2a4f155d040710050166e98a7f@mail.gmail.com>
Date: Sat, 10 Jul 2004 15:01:42 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: arjanv@redhat.com
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Cc: Ingo Molnar <mingo@elte.hu>, Redeeman <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1089458801.2704.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20040709182638.GA11310@elte.hu>
	 <1089407610.10745.5.camel@localhost> <20040710080234.GA25155@elte.hu>
	 <20040710085044.GA14262@elte.hu>
	 <2a4f155d040710035512f21d34@mail.gmail.com> <1089458801.2704.3.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cartman@southpark:~$ dmesg | grep sched
Using anticipatory io scheduler

Problem is I rarely do this copy operations like once a week or 2
weeks. Guess there is no scheduler that fits both desktop usage +
these kinds of operations?

Cheers,
ismail

On Sat, 10 Jul 2004 13:26:41 +0200, Arjan van de Ven <arjanv@redhat.com> wrote:
> On Sat, 2004-07-10 at 12:55, ismail dönmez wrote:
> > Tested on 2.6.7-bk20, Pentium3 700 mhz, 576 mb RAM
> >
> > I did cp -rf big_folder new_folder . Then opened up a gui ftp client
> > and music in amarok started to skip like for 2-3 seconds.
> 
> that somewhat sounds more like a disk IO stall... which IO scheduler are
> you using ?
> 
> (I can recommend using CFQ for this)
> 
> 
> 
> 


-- 
Time is what you make of it

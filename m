Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbTHURXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTHURXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:23:06 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12672 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262881AbTHURXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:23:03 -0400
Date: Thu, 21 Aug 2003 13:23:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pankaj Garg <PGarg@MEGISTO.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: Messaging between kernel modules and User Apps
In-Reply-To: <3F44F9D0.5010606@softhome.net>
Message-ID: <Pine.LNX.4.53.0308211318500.3389@chaos>
References: <mYVo.39N.19@gated-at.bofh.it> <mZou.3Ff.29@gated-at.bofh.it>
 <n0ud.4F4.15@gated-at.bofh.it> <3F44F9D0.5010606@softhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Ihar 'Philips' Filipau wrote:

> Zwane Mwaikambo wrote:
> >>The de facto standard for network devices is to use sockets.
> >>For character and and block devices Unix/Linux uses the
> >>open/poll/ioctl/read mechanisms.
> >
> > That sounds fine, but..
> >
> >>You could send your module a pid via proc and have it send a
> >>signal to your application as a result of an event.
> >
> > ... please don't even entertain such sick ideas.
>
>    Especially when there is fcntl(F_{G,S}ET{OWN,SIG}) infrastructure in
> place - kill_fasync().
>

Just getting 'even' for the last time I advised poll()/ioctl() and
I was pummeled with "No... use /proc"! Of course the "best" method
is to open a file in the kernel module and have the user poll for
a change in length ->;^;<-)

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



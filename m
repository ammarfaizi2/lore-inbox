Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbUC3Tkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbUC3Tkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:40:33 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:40965 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263870AbUC3Tk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:40:27 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Ben Greear <greearb@candelatech.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: sched_yield() version 2.4.24
Date: Tue, 30 Mar 2004 21:40:05 +0200
User-Agent: KMail/1.5.4
Cc: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0403301138260.6967@chaos> <4069AED1.4020102@nortelnetworks.com> <4069B3CC.1040904@candelatech.com>
In-Reply-To: <4069B3CC.1040904@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403302140.05820.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 March 2004 19:52, Ben Greear wrote:
> Chris Friesen wrote:
> > The cpu util accounting code in kernel/timer.c hasn't changed in 2.4
> > since 2002.  Must be somewhere else.
> >
> > Anyone else have any ideas?
>
> As another sample point, I have fired up about 100 processes with
> each process having 10+ threads.  On my dual-xeon, I see maybe 15
> processes shown as 99% CPU in 'top'.  System load was near 25
> when I was looking, but the machine was still quite responsive.

There was a top bug with exactly this symptom. Fixed.
I use procps-2.0.18.

> I'm guessing this is just an artifact of having lots of processes running
> very often and top is just not able to calculate with fine enough
> granularity?
>
> This is on 2.4.25 kernel.
>
> Ben
--
vda


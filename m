Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311411AbSCSQZz>; Tue, 19 Mar 2002 11:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311418AbSCSQZp>; Tue, 19 Mar 2002 11:25:45 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:8972 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311411AbSCSQZ3>; Tue, 19 Mar 2002 11:25:29 -0500
Date: Tue, 19 Mar 2002 11:22:44 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Ken Brownfield <ken@irridia.com>
cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: I/O APIC fixed in 2.4.19-pre3 & 2.5.6 (was Re: Linux 2.4.19-pre3)
In-Reply-To: <20020318204106.A24611@asooo.flowerfire.com>
Message-ID: <Pine.LNX.3.96.1020319111636.1772A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, Ken Brownfield wrote:

> As a followup, this APIC patch also prevents 2.4 machines on quite a bit
> of common hardware from freezing up after a few hours to a few days of
> production use.  Especially ServerWorks boards distributed by HP and
> Rackable/Tyan.
> 
> This patch (applied to 2.4.18) seems to fix my long-standing (and
> oft-mentioned on LKML) I/O APIC issue with all 2.4 kernels, and I no
> longer need my "pintimer" patch to disable the through-8259A mode.

  Any chance this will cure the lockups on a Dell Latitude C600 every time
you exit X? I've disabled both the IO-APIC and APIC-uni, which was
supposed to fix the problem but didn't. Dare I hope that the disable
wasn't enough?

  A quick google tells me other people have the same problem, but I
haven't seen a working solution yet. Nice machine other than needing to be
rebooted after every use of X :-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


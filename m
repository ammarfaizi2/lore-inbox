Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132802AbRDOWEa>; Sun, 15 Apr 2001 18:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbRDOWEU>; Sun, 15 Apr 2001 18:04:20 -0400
Received: from dystopia.lab43.org ([209.217.122.210]:51429 "EHLO
	dystopia.lab43.org") by vger.kernel.org with ESMTP
	id <S132802AbRDOWEC>; Sun, 15 Apr 2001 18:04:02 -0400
Date: Sun, 15 Apr 2001 18:01:57 -0400 (EDT)
From: Rod Stewart <stewart@dystopia.lab43.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Subject: Re: [new PATCH] Re: 8139too: defunct threads
In-Reply-To: <3AD99CE4.E1ED7090@colorfullife.com>
Message-ID: <Pine.LNX.4.33.0104151801170.25233-100000@dystopia.lab43.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Apr 2001, Manfred Spraul wrote:

> Alan, which fix would you prefer:
> * init could use wait3 and set __WALL.
> * all kernel thread users could set SIGCHLD. Some already do that
> (__call_usermodehelper).
> * the kernel_thread implementations could force the exit signal to
> SIGCHLD.
>
> I'd prefer the last version.
> The attached patch is tested with i386. The alpha, parisc and ppc
> assember changes are guessed.

This patch fixed my problem.

Thanks,
-Rms


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276914AbRJHPEX>; Mon, 8 Oct 2001 11:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276339AbRJHPEN>; Mon, 8 Oct 2001 11:04:13 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:26218 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S276917AbRJHPD5>; Mon, 8 Oct 2001 11:03:57 -0400
Date: Mon, 8 Oct 2001 10:03:57 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
        jamal <hadi@cyberus.ca>, Linux-Kernel <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <E15qbtV-0000hd-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1011008100030.13807A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Alan Cox wrote:
> > Of course we agree that such a "polling router/firewall" behaviour must
> > not be the default but it must be enabled on demand by the admin via
> > sysctl or whatever else userspace API. And I don't see any problem with
> > that.
> 
> No I don't agree. "Stop random end users crashing my machine at will" is not
> a magic sysctl option - its a default. 

I think (Ingo's?) analogy of an airbag was appropriate, if that's indeed
how the code winds up functioning.

Having a mechanism that prevents what would otherwise be a lockup is
useful.  NAPI is useful.  Having both would be nice :)

	Jeff





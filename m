Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUIWVwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUIWVwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267450AbUIWVtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:49:02 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:27301 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S267445AbUIWVqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:46:38 -0400
Date: Thu, 23 Sep 2004 23:46:30 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: yoshfuji@linux-ipv6.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: ArcNet and 2.6.8.1
In-Reply-To: <20040923140158.4039a39a.davem@davemloft.net>
Message-Id: <Pine.OSF.4.05.10409232336180.21511-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ArcNet can't compete with ethernet as LAN: It can only run 10 Mbit whereas
100 Mbit ethernet can run roughly 50 Mbit in practice.

But ArcNet doesn't degrade in performance when you try to fill it up as
ethernet does. Thus ArcNet is very good for real-time applications - and
is used for such in the industry. But that is not an area where people
usually use Linux.

But don't worry, the windoze drivers aren't good either. The official
driver for the PCMCIA card crashed Windows XP - with no chance of fixing
them as I have with the Linux one :-)

Esben




On Thu, 23 Sep 2004, David S. Miller wrote:

> On Thu, 23 Sep 2004 22:59:58 +0200 (METDST)
> Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > After I got the arcnet device running labtop computer froze up. I have
> > turned off preemtion and SMP. It seems to make it more stable but I can't
> > be conclusive.
> 
> Based upon the fact that most Arcnet drivers set hw.open() to NULL,
> and you're the first person to report this, I doubt arcnet is
> getting any serious use or testing at all these days.  Sorry :-/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


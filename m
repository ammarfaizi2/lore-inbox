Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRJHE6S>; Mon, 8 Oct 2001 00:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276335AbRJHE6J>; Mon, 8 Oct 2001 00:58:09 -0400
Received: from quechua.inka.de ([212.227.14.2]:7034 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S276312AbRJHE6A>;
	Mon, 8 Oct 2001 00:58:00 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <20011008023118.L726@athlon.random>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-pre3-xfs (i686))
Message-Id: <E15qSUl-0008R8-00@calista.inka.de>
Date: Mon, 08 Oct 2001 06:58:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011008023118.L726@athlon.random> you wrote:
> You're perfectly right that it's not ok for a generic computing
> environment to spend lots of cpu in polling, but it is clear that in a
> dedicated router/firewall we can just shutdown the NIC interrupt forever via
> disable_irq (no matter if the nic supports hw flow control or not, and
> in turn no matter if the kid tries to spam the machine with small
> packets) and dedicate 1 cpu to the polling-work with ksoftirqd polling
> forever the NIC to deliver maximal routing performance or something like
> that.

Yes, have a look at the work of the Click Modular Router PPL from MIT,
having a Polling Router Module Implementatin which outperforms Linux Kernel
Routing by far (according to their paper :)

You can find the Link to Click somewhere on my Page:
http://www.freefire.org/tools/index.en.php3in the Operating System section
(i think)

I can recommend the click-paper.pdf

Greetings
Bernd

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293458AbSCKCFz>; Sun, 10 Mar 2002 21:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293463AbSCKCFq>; Sun, 10 Mar 2002 21:05:46 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:39042
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S293458AbSCKCFb>; Sun, 10 Mar 2002 21:05:31 -0500
Date: Sun, 10 Mar 2002 18:05:10 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200203110205.g2B25Ar05044@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>,
        "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
In-Reply-To: <200203110114.g2B1EuG24994@vindaloo.ras.ucalgary.ca>
In-Reply-To: <20020310.170338.83978717.davem@redhat.com> <20020310163339.H16784@sunbeam.de.gnumonks.org> <20020310.164113.01028736.davem@redhat.com> <200203110055.g2B0tiP24585@vindaloo.ras.ucalgary.ca> <20020310.170338.83978717.davem@redhat.com> <200203110114.g2B1EuG24994@vindaloo.ras.ucalgary.ca>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, Richard Gooch wrote:

> What are these "Addtron" cards I see listed on www.pricewatch.com
> for US$36?  Is that a supported card under another name?

This card seems to be based on the National Semiconductors DP83820,
for which there is an in-kernel driver.  Note that US$36 only gets you
the 32-bit/33MHz PCI version (AEG-320T); the 64-bit version (AEG-620T)
goes for about twice as much (according to google).

There is also the D-Link DGE-550T, a 64-bit/66MHz card starting at
US$80 (according to pricewatch).  It apparently uses a different
in-kernel driver, dl2k.o.

So does anyone have any comments on the stability and performance of
these cards/drivers?

Cheers,
Wayne

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265677AbSKODbe>; Thu, 14 Nov 2002 22:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265681AbSKODbe>; Thu, 14 Nov 2002 22:31:34 -0500
Received: from ns.suse.de ([213.95.15.193]:56583 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265677AbSKODbd>;
	Thu, 14 Nov 2002 22:31:33 -0500
Date: Fri, 15 Nov 2002 04:38:27 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>,
       John Alvord <jalvo@mbay.net>, linux-kernel@vger.kernel.org
Subject: Re: module mess in -CURRENT
Message-ID: <20021115043827.A20764@wotan.suse.de>
References: <20021115002730.GA22547@bjl1.asuk.net> <Pine.LNX.4.44.0211141634060.12390-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211141634060.12390-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and then have the timer clear "xtime_count" every time it updates it.  

Problem is that you cannot easily synchronize such a monotonously increasing
timer in a network. But make needs synchronized times.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbTHaRHO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 13:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTHaRHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 13:07:14 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:52488 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S262466AbTHaRHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 13:07:08 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
References: <20030830230701.GA25845@work.bitmover.com>
	<Pine.LNX.4.44.0308310256420.16308-100000@neptune.local>
	<20030831013928.GN24409@dualathlon.random>
	<20030831025659.GA18767@work.bitmover.com>
	<1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk>
	<20030831144505.GS24409@dualathlon.random>
	<1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk>
	<20030831154301.GD30196@wohnheim.fh-wedel.de>
	<20030831155012.GW24409@dualathlon.random>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>, =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,  Larry McVoy <lm@bitmover.com>, Pascal Schmidt <der.eremit@email.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 31 Aug 2003 19:06:55 +0200
In-Reply-To: <20030831155012.GW24409@dualathlon.random> (Andrea Arcangeli's
 message of "Sun, 31 Aug 2003 17:50:12 +0200")
Message-ID: <87llt9bvtc.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> yes, that's unfixable at Larry's end, and normaly it's unfixable for the
> ISP too.

The ISP can do several things to prioritize production traffic or drop
malicious traffic.  However, this isn't trivial and requires careful
planning, and it's unlikely that anyone who is able to would want to
do this for a T1 customer (typically, it requires "unusual"
configuration of vital production routers with the fat pipes).

>> iirc, Larry was worried about well behaved traffic still doing bad
>> things to his connection.

In this case, it's a bit easier for the ISP because the tweaking can
be done on edge routers (which typically die during DoS attacks as
well, so countermeasures cannot be applied there).  Especially with
low-bandwidth links, it shouldn't be too hard to find a smallish,
geeky ISP who is willing to try some fiddling on the edge router to
improve performance (at least that's true in Germany, don't know about
the U.S.).

However, why can't bkbits.net distributed around the world, at least
for read access?  This would eliminate the choking point once and for
all.

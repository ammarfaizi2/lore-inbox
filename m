Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWH0WBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWH0WBs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 18:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWH0WBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 18:01:48 -0400
Received: from avas-mr14.fibertel.com.ar ([24.232.0.245]:54440 "EHLO
	avas-mr14.fibertel.com.ar") by vger.kernel.org with ESMTP
	id S1751188AbWH0WBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 18:01:47 -0400
Subject: Re: Touchpad problems with latest kernels
From: Javier Kohen <jkohen@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 27 Aug 2006 18:26:14 -0300
Message-Id: <1156713975.20067.15.camel@null.tough.com.ar>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
X-Fib-Al-Info: Al
X-Fib-Al-MRId: 68c78303b1763dacb5fef4347b3492b3
X-Fib-Al-SA: analyzed
X-Fib-Al-From: jkohen@users.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just got a HP dv8301nr laptop and found out about this problem. I'm
running kernel 2.6.17-debian and 2.6.17-ck1. The Touchpad is a model: 1,
fw: 6.2, id: 0x1a0b1, caps: 0xa04713/0x200000.

I've tried many suggested workarounds that I found on the net to no
avail. Even forcing the imps/exps protocols cause a similar problem
here: no pointer freezes as with the SynPS protocol, but yes periodical
random jerky mouse movements and clicks. Moreover, I haven't found a way
to disable the mouse-tap feature (which I find annoying) when using this
protocol and X. I haven't tried the bare protocol because I'm very used
to the scrolling wheel behavior.
Incidentally, it seems that the driver resynchs are always useless, at
least for me.

I booted with the ec_intr=0 option (it took effect according to the boot
logs) to no avail. I'd like to help fix this problem, so if there is
anything that I can do, please let me know. I modified synaptics.c to
print the packets that were failed the validation check to fail, but
they don't say much to me.

Meanwhile, I think I'll get a cheap external mouse (I read they work
fine) and keep my hopes up.

Thanks in advance,
-- 
Javier Kohen <jkohen@users.sourceforge.net>
ICQ: blashyrkh #2361802
Jabber: jkohen@jabber.org

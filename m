Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUK0WH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUK0WH6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 17:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbUK0WH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 17:07:58 -0500
Received: from science.horizon.com ([192.35.100.1]:47945 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261347AbUK0WHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 17:07:53 -0500
Date: 27 Nov 2004 22:07:52 -0000
Message-ID: <20041127220752.16491.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge
Cc: pavel@ucw.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My machine suspends in 7 seconds, and that's swsusp1. According to
> your numbers, suspend2 should suspend it in 1 second and LZE
> compressed should be .5 second.
> 
> I'd say "who cares". 7 seconds seems like fast enough for me.  And I'm
> *not* going to add 2000 lines of code for 500msec speedup during
> suspend.

Lucky you.  My machine takes minutes.
(To be precise, it prints about a line and a half of dots in the
count_data_pages() loop, and often takes 2 seconds per dot.)

AMD Athlon XP, 1066 MHz, 768K RAM, VIA KT133 chipset.
Stock 2.6.10-rc1.

I could really use a speedup.


Remember, Linux is the aggregate of a lot of people scratching their
itches.  It's okay to criticize *how* people go about addressing
what's annoying them, since that has a long-term maintenance effect,
if nothing else.  But complaining that it doesn't annoy *you* isn't the
most valid argument.

That's what's fundamentally wrong with people complainging about
wanting to "stabilize" 2.6.x.  Stability is in the eye of the beholder.
Unless you want no changes at all (and you can get that easily enough),
what it means is that the bugs that particularly annoy you get fixed.

But the point is, every bug fixed particularly annoys *someone*;
that's why it's getting fixed.

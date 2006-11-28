Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935900AbWK1RYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935900AbWK1RYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 12:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935901AbWK1RYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 12:24:13 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57794 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S935900AbWK1RYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 12:24:12 -0500
Date: Tue, 28 Nov 2006 18:24:09 +0100
From: Martin Mares <mj@ucw.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
Message-ID: <mj+md-20061128.172328.19498.atrey@ucw.cz>
References: <ek2nva$vgk$1@sea.gmane.org> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu> <mj+md-20061128.131233.3594.atrey@ucw.cz> <456C704F.3050008@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456C704F.3050008@cfl.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> After a reboot the entropy estimate starts at zero, so if you are adding 
> data to the pool from the previous boot, you DO want the estimate to 
> increase because you are, in fact, adding entropy.

I'm adding entropy, but unless I record the exact amount of entropy when
dumping the pool, I don't know how much I am adding, so using any fixed
number is obviously wrong.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Object orientation is in the mind, not in the compiler." -- Alan Cox

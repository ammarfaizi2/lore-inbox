Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935993AbWK1R7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935993AbWK1R7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 12:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935994AbWK1R7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 12:59:22 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28872 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S935993AbWK1R7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 12:59:22 -0500
Date: Tue, 28 Nov 2006 18:59:20 +0100
From: Martin Mares <mj@ucw.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
Message-ID: <mj+md-20061128.175844.1273.atrey@ucw.cz>
References: <ek2nva$vgk$1@sea.gmane.org> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu> <456C74F7.3060902@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456C74F7.3060902@cfl.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I still don't see how feeding tons of zeros ( or some other carefully 
> crafted sequence ) in will not decrease the entropy of the pool ( even 
> if it does so in a way that is impossible to predict ), but assuming it 
> can't, what good does a non root user do by writing to random?

Even if so, you should control that by filesystem permissions, not by
in-kernel policy.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Man is the highest animal. Man does the classifying.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755691AbWK1VFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691AbWK1VFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 16:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755681AbWK1VFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 16:05:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20450 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1755691AbWK1VFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 16:05:33 -0500
Date: Tue, 28 Nov 2006 22:05:33 +0100
From: Martin Mares <mj@ucw.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
Message-ID: <mj+md-20061128.210510.8000.atrey@ucw.cz>
References: <ek2nva$vgk$1@sea.gmane.org> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu> <mj+md-20061128.131233.3594.atrey@ucw.cz> <456C704F.3050008@cfl.rr.com> <mj+md-20061128.174904.27577.atrey@ucw.cz> <456C82AE.6030505@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456C82AE.6030505@cfl.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> That is exactly my point.  Since you can not tell how much randomness is 
> in the data you provide, you can not tell the kernel how much to add to 
> its entropy estimate.  Instead it just has to estimate based on the 
> amount of data you provide.

No, the only safe thing the kernel can do is to add NO entropy,
unless explicitly told otherwise.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"All that is necessary for the triumph of evil is that good men do nothing." -- E. Burke

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWF0KEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWF0KEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 06:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWF0KEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 06:04:34 -0400
Received: from mail.gmx.net ([213.165.64.21]:55951 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751314AbWF0KEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 06:04:32 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH] i386: Fix softirq accounting with 4K stacks
From: Mike Galbraith <efault@gmx.de>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       danial_thom@yahoo.com, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060626175844.GA3822@atjola.homenet>
References: <1151166193.8516.8.camel@Homer.TheSimpsons.net>
	 <20060624192523.GA3231@atjola.homenet>
	 <1151211993.8519.6.camel@Homer.TheSimpsons.net>
	 <20060625111238.GB8223@atjola.homenet>
	 <20060625142440.GD8223@atjola.homenet>
	 <1151257451.7858.45.camel@Homer.TheSimpsons.net>
	 <1151257397.4940.45.camel@laptopd505.fenrus.org>
	 <20060625184244.GA11921@atjola.homenet>
	 <1151288602.7470.22.camel@Homer.TheSimpsons.net>
	 <1151291114.7611.8.camel@Homer.TheSimpsons.net>
	 <20060626175844.GA3822@atjola.homenet>
Content-Type: text/plain; charset=utf-8
Date: Tue, 27 Jun 2006 12:09:01 +0200
Message-Id: <1151402942.7800.32.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 19:58 +0200, Björn Steinbrink wrote:

> The results for the forcedeth driven NIC do not agree though, and your
> results differ from what I see as well, right? So I'm kinda lost again.

I'm not.  Not any more.  After much fruitless rummaging, I did some more
profiling to verify the numbers.  It really does take that much more cpu
when booted with noapic, nearly 50%!  I've been chasing swamp gas.

Oh well.  I got a warm fuzzy wrt tools cpu usage numbers out of it.

Stick a fork in this bug, it's done ;-)

	-Mike


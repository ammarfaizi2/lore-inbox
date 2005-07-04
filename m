Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVGDUWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVGDUWu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 16:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVGDUWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 16:22:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12165 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261618AbVGDUWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 16:22:38 -0400
Date: Mon, 4 Jul 2005 14:32:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050704123233.GA3449@openzaurus.ucw.cz>
References: <9a8748490507031832546f383a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490507031832546f383a@mail.gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > BTW, we are on irc.freenode.org in #hdaps If anyone is interested.
> > 
> > .Alejandro
> > 
> I just had a nice chat with the guys there and we got some
> improvements made by them and us merged up. And I /think/ we agreed
> that I'll maintain the driver, merge fixes/features etc and eventually
> try to get it merged.
> 
> Currently the driver loads, initializes the accelerometer and we can
> read data from it.
> I'll be working on adding sysfs stuff to it tomorrow so it's generally
> useful (at least for monitoring things - not yet for parking disk

Actually you should probably implement it as an input device; no need to
mess with sysfs. drivers/input/accell ?

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


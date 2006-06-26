Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbWFZTA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWFZTA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWFZTAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:00:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25062 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932691AbWFZTAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:00:23 -0400
Subject: Re: [PATCH] Kconfig for radio cards to allow VIDEO_V4L1_COMPAT
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910606261015l13399f96hebebeb00b6b01790@mail.gmail.com>
References: <9e4733910606251040v62675399gdfe438aaac691a5a@mail.gmail.com>
	 <1151327213.3687.13.camel@praia>
	 <9e4733910606260855kf2e57ado5c69d8295d1be5@mail.gmail.com>
	 <1151341122.13794.2.camel@praia>
	 <9e4733910606261015l13399f96hebebeb00b6b01790@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 26 Jun 2006 16:00:03 -0300
Message-Id: <1151348403.16290.5.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Seg, 2006-06-26 às 13:15 -0400, Jon Smirl escreveu:
> On 6/26/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:

> I don't have any of the hardware. I was just doing some work on
> Kconfig and noticed that a bunch of drivers had gone missing. I see
> now that a lot of the drivers in media/video have the same problem.
Yes, mostly webcam stuff, where there are active developers. Hopefully
those stuff will be fixed in time to 2.6.19.
> I guess V4L1 is going to be with us for a while longer since all of
> these drivers need to get ported.
Radio devices will be more complicated to test. Those devices emerged a
long time ago, and it seems that nobody is using they, at least with 2.6
series. I'm not sure if it would be valuable to port all those stuff.
Some devices even don't have pnp support (you need to specify IO ports
and IRQ lines).
> 
Cheers, 
Mauro.


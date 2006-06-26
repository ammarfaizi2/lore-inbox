Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWFZQ7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWFZQ7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWFZQ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:59:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55721 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750999AbWFZQ66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:58:58 -0400
Subject: Re: [PATCH] Kconfig for radio cards to allow VIDEO_V4L1_COMPAT
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910606260855kf2e57ado5c69d8295d1be5@mail.gmail.com>
References: <9e4733910606251040v62675399gdfe438aaac691a5a@mail.gmail.com>
	 <1151327213.3687.13.camel@praia>
	 <9e4733910606260855kf2e57ado5c69d8295d1be5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 26 Jun 2006 13:58:42 -0300
Message-Id: <1151341122.13794.2.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon,

Em Seg, 2006-06-26 às 11:55 -0400, Jon Smirl escreveu:
> On 6/26/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:

> > All radio stuff at kernel are still using the old obsoleted V4L1 API,
> > and requires some changes to be V4L2 compliant. The correct fix is to
> > replace the old calls to V4L2 calls, and include videodev2.h header
> > instead of videodev.h.
> 
> Is anyone who knows how V4L2 works going to port those drivers?
Nobody started working on it yet.

> I would hate to see 20 device drivers lost because they weren't ported
> and V4L1 gets removed.
The driver conversion shouldn't be that hard. The main problem is that
those devices are really obsolete hardware and none of the current V4L
developers have those boards for testing. Do you have any of those
devices? Can you help porting it to V4L2?

Cheers, 
Mauro.


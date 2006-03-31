Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWCaRc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWCaRc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWCaRc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:32:57 -0500
Received: from nacho.alt.net ([207.14.113.18]:48825 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S1751075AbWCaRc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:32:56 -0500
Date: Fri, 31 Mar 2006 17:32:50 +0000 (GMT)
To: Jens Axboe <axboe@suse.de>
cc: erich <erich@areca.com.tw>, "(?s?w????)?w?iO" <billion.wu@areca.com.tw>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dax@gurulabs.com, Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: about ll_rw_blk.c of void generic_make_request(struct bio *bio)
In-Reply-To: <20060330155804.GP13476@suse.de>
Message-ID: <Pine.LNX.4.64.0603311700310.14317@nacho.alt.net>
References: <001d01c65302$0fee8e10$b100a8c0@erich2003>
	<20060330155804.GP13476@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Jens Axboe wrote:
> I can't really say, from my recollection of leafing over lkml emails, I
> seem to recall someone saying he hit this with a newer kernel where as
> the older one did not?
> 
> What are the sectors exactly it complains about, eg the full line you
> see?

I see:

  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016

Chris

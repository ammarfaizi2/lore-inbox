Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUC2RT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbUC2RT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:19:58 -0500
Received: from moonshine.cih.com ([204.69.206.3]:26581 "EHLO mail.cih.com")
	by vger.kernel.org with ESMTP id S263015AbUC2RTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 12:19:12 -0500
Date: Mon, 29 Mar 2004 09:19:11 -0800 (PST)
From: "Craig I. Hagan" <hagan@cih.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, Jamie Lokier <jamie@shareable.org>,
       Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
In-Reply-To: <1080565536.3570.4.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0403290918320.12087@svr.cih.com>
References: <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> 
 <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> 
 <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org>
  <20040328181502.GO24370@suse.de> <40671FAF.6080501@pobox.com> 
 <20040329080943.GR24370@suse.de> <20040329124147.GC4984@mail.shareable.org>
  <20040329124421.GB24370@suse.de> <1080565536.3570.4.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Might not be a silly thing to experiment with, definitely something that
> > should be tested (added to list...)
> 
> I wonder if the max read size could/should be correlated with the
> readahead size for such devices... it sounds like a related property at
> least.

I'd like to see that (for areas where this is supported). This would
make folks with fibre storage much happier.

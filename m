Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTLWR3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTLWR3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:29:46 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:45011 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S261812AbTLWR3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:29:44 -0500
Date: Tue, 23 Dec 2003 18:29:42 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1
In-Reply-To: <20031223165829.GF1601@suse.de>
Message-ID: <Pine.LNX.4.44.0312231828540.972-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003, Jens Axboe wrote:

> On Tue, Dec 23 2003, Jens Axboe wrote:
> > -				rq->errors = 1;
> > +					info->write_timeout = jiffies + ATAPI_WAIT_WRITE_BUSY;
> > +				++rq->errors;
> 
> Didn't mean to change the = 1, here's an updated one.

Applied, compiled, and tested. MO drive workes just fine with the
updated patch applied.

-- 
Ciao,
Pascal


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266607AbUAWRhc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 12:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266609AbUAWRhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 12:37:32 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:51369 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S266607AbUAWRhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 12:37:31 -0500
Date: Fri, 23 Jan 2004 18:37:20 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
In-Reply-To: <20040123161846.GR2734@suse.de>
Message-ID: <Pine.LNX.4.44.0401231836290.3523-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004, Jens Axboe wrote:

> > I think Jens means storing it only in q->hardsect_size.  This way you
> > can just use rq->q->hardsect_size << 9 to get sectors_per_frame.
> 
> Yes that's precisely what I mean, there's no need to keep the same info
> in several places.

Yes, agreed. I'll do a new version based on your and Bart's comments.

-- 
Ciao,
Pascal


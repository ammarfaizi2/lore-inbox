Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbUAWRgP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 12:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUAWRgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 12:36:15 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:2472 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S266599AbUAWRgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 12:36:13 -0500
Date: Fri, 23 Jan 2004 18:36:09 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: linux-kernel@vger.kernel.org, <axboe@suse.de>
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
In-Reply-To: <200401231624.14687.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0401231834260.3523-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004, Bartlomiej Zolnierkiewicz wrote:

> I think Jens means storing it only in q->hardsect_size.
> This way you can just use rq->q->hardsect_size << 9 to get
> sectors_per_frame.

Agreed (though it will have to be >> 9 ;).

> If you do that please remember to revert this chunk
> (except comment fix of course):

[dma alignment]

Agreed, thanks.

-- 
Ciao,
Pascal


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTFJOK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 10:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTFJOKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 10:10:25 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:34534 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262934AbTFJOKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 10:10:17 -0400
Date: Tue, 10 Jun 2003 16:23:25 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jens Axboe <axboe@suse.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE Power Management, try 3
In-Reply-To: <1055228889.641.35.camel@gaston>
Message-ID: <Pine.SOL.4.30.0306101621020.27439-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Jun 2003, Benjamin Herrenschmidt wrote:

> On Fri, 2003-06-06 at 23:25, Bartlomiej Zolnierkiewicz wrote:
> > I have corrected it a bit and I am going to submit it, any comments?
> >
> > Ben, can you verify my changes and check that it still works after 'fixing'?
> > :-)
>
> Heh, thanks for the "corrections" ;)
>
> Regarding ide_wait_not_busy(), I'd rather have it return -ENODEV
> when it reads 0xff, what do you think ?

Nope, if you change it to return -ENODEV callers will fail.

> I'll test the patch later today (just back from a long week-end),
> Ben.

Good!
--
Bartlomiej


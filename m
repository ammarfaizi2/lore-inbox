Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSE1K3N>; Tue, 28 May 2002 06:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSE1K3M>; Tue, 28 May 2002 06:29:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:40440 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313419AbSE1K3L>; Tue, 28 May 2002 06:29:11 -0400
Subject: Re: [PATCH][RFC] block plugging reworked
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
In-Reply-To: <20020528084829.GI17674@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 12:31:44 +0100
Message-Id: <1022585504.4124.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 09:48, Jens Axboe wrote:
> This patch provides the ability for a block driver to signal it's too
> busy to receive more work and temporarily halt the request queue. In
> concept it's similar to the networking netif_{start,stop}_queue helpers.

I am now a very happy person. That will clean up some much crap in the
i2o and some of the scsi drivers its wonderful


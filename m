Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131140AbRCGSU1>; Wed, 7 Mar 2001 13:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131141AbRCGSUR>; Wed, 7 Mar 2001 13:20:17 -0500
Received: from zeus.kernel.org ([209.10.41.242]:11731 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131140AbRCGSUM>;
	Wed, 7 Mar 2001 13:20:12 -0500
Date: Wed, 7 Mar 2001 15:12:17 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit capable block device layer
In-Reply-To: <20010307184749.A4653@suse.de>
Message-ID: <Pine.LNX.4.33.0103071504250.1409-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Jens Axboe wrote:
> On Wed, Mar 07 2001, Rik van Riel wrote:

> > how would you feel about having the block device layer 64-bit
> > capable, so Linux can have block devices of more than 2GB in
> > size ?
>
> I already did this here, or something similar at least. Using
> a sector_t type that is 64-bit, regardless of platform. Is it
> really worth it to differentiate and use 32-bit types for old
> machines?

Wonderful !

I'm not sure how expensive 64-bit arithmetic would be on
eg. 386, 486 or 68k machines, or how much impact the extra
memory taken would have.

OTOH, I'm not sure what problems it could give to make this
a compile-time option...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


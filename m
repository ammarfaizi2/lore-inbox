Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136317AbRD1B6c>; Fri, 27 Apr 2001 21:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136318AbRD1B6X>; Fri, 27 Apr 2001 21:58:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37586 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136317AbRD1B6F>;
	Fri, 27 Apr 2001 21:58:05 -0400
Date: Fri, 27 Apr 2001 21:58:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup for fixing get_super() races
In-Reply-To: <Pine.LNX.4.21.0104271835480.1120-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0104272154260.21109-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Apr 2001, Linus Torvalds wrote:

> 
> On Fri, 27 Apr 2001, Alexander Viro wrote:
> > 
> > PS: last time I've separated that part of patch was a couple months
> > ago. See if something similar to the variant below would be OK with
> > you (I'll rediff it):
> 
> This one looks fine.

Erm? It _does_ pull the fsync_dev() in there (conditionally, depending
on the "flag" argument of invalidate_dev()).

Oh, well... Check the variant I've sent to you couple of minutes ago and
tell which one you prefer, OK?

								Al
PS: gotta love the email latency...



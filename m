Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265286AbRF0HoQ>; Wed, 27 Jun 2001 03:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265290AbRF0HoF>; Wed, 27 Jun 2001 03:44:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30166 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265286AbRF0Hnu>;
	Wed, 27 Jun 2001 03:43:50 -0400
Date: Wed, 27 Jun 2001 03:43:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Paul Menage <pmenage@ensim.com>, "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot
In-Reply-To: <20010627191946.B5913@weta.f00f.org>
Message-ID: <Pine.GSO.4.21.0106270335220.19655-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jun 2001, Chris Wedgwood wrote:

> On Tue, Jun 26, 2001 at 09:40:36PM -0400, Alexander Viro wrote:
> 
> > You need /dev/zero to get anywhere near the normal behaviour of the
> > system.
> 
> Not commenting on the original patch, I think requiring /dev/zero for
> a 'usable' system should be considered a [g]libc bug. /dev/zero should
> be present, but if not, [g]libc should have fall-back mechanisms to
> deal with things.

Frankly, glibc already has too many fall-back mechanisms of various kinds.
Several things Should Be There(tm). /dev/zero, /dev/null and /dev/tty are
definitely among them.


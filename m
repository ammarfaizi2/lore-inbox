Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265279AbRF0HUo>; Wed, 27 Jun 2001 03:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265288AbRF0HUd>; Wed, 27 Jun 2001 03:20:33 -0400
Received: from metastasis.f00f.org ([203.167.249.89]:49536 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S265279AbRF0HUV>;
	Wed, 27 Jun 2001 03:20:21 -0400
Date: Wed, 27 Jun 2001 19:19:46 +1200
To: Alexander Viro <viro@math.psu.edu>
Cc: Paul Menage <pmenage@ensim.com>, "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot
Message-ID: <20010627191946.B5913@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0106262138370.18037-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.18i
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 09:40:36PM -0400, Alexander Viro wrote:

> You need /dev/zero to get anywhere near the normal behaviour of the
> system.

Not commenting on the original patch, I think requiring /dev/zero for
a 'usable' system should be considered a [g]libc bug. /dev/zero should
be present, but if not, [g]libc should have fall-back mechanisms to
deal with things.


  --cw

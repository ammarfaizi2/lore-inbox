Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274252AbRISXD3>; Wed, 19 Sep 2001 19:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274251AbRISXDV>; Wed, 19 Sep 2001 19:03:21 -0400
Received: from [195.223.140.107] ([195.223.140.107]:14832 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274252AbRISXDL>;
	Wed, 19 Sep 2001 19:03:11 -0400
Date: Thu, 20 Sep 2001 01:03:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010920010338.B720@athlon.random>
In-Reply-To: <20010919225505.P720@athlon.random> <Pine.GSO.4.21.0109191655560.901-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109191655560.901-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Sep 19, 2001 at 05:17:23PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 05:17:23PM -0400, Alexander Viro wrote:
> fsync_dev() is not needed for raw devices or swap.  It _is_ needed for
> file access.

then what's the difference between raw devices and swap.

And there's reason we should we avoid the fsync_dev with the raw devices
and swap.

I just found it an useless complication.

Andrea

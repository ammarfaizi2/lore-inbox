Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131561AbQLNChj>; Wed, 13 Dec 2000 21:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132127AbQLNCha>; Wed, 13 Dec 2000 21:37:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:18920 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131561AbQLNChX>;
	Wed, 13 Dec 2000 21:37:23 -0500
Date: Wed, 13 Dec 2000 21:06:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Lattner <sabre@nondot.org>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012131755030.24165-100000@www.nondot.org>
Message-ID: <Pine.GSO.4.21.0012132050140.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Chris Lattner wrote:

> Err... how about this:  Give me two or three kORBit syscalls and I can get
> rid of all the other 100+ syscalls!  :) 

Like it ioctl() does it? Number of entry points is _not_ an issue. Diversity
of the API is. Technically, kernel has 1 (_o_n_e_) entry point as far as
userland is concerned. int 0x80 on x86. Can't beat that, can you?

Yes, standard RPC mechanism would be nice. No, CORBA is not a good candidate -
too baroque and actually known to lead to extremely tasteless APIs being
implemented over it. Yes, I mean GNOME. So sue me.

I would take 9P over that any day, thank you very much.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

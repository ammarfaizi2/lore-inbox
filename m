Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNRHB>; Thu, 14 Dec 2000 12:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLNRGw>; Thu, 14 Dec 2000 12:06:52 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:39440 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129260AbQLNRGd>; Thu, 14 Dec 2000 12:06:33 -0500
Date: Thu, 14 Dec 2000 17:34:56 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Chris Lattner <sabre@nondot.org>, "Mohammad A. Haque" <mhaque@haque.net>,
        Ben Ford <ben@kalifornia.com>, linux-kernel@vger.kernel.org,
        orbit-list@gnome.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
Message-ID: <20001214173456.A7639@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.21.0012131755030.24165-100000@www.nondot.org> <Pine.GSO.4.21.0012132050140.6300-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0012132050140.6300-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Dec 13, 2000 at 09:06:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> > Err... how about this:  Give me two or three kORBit syscalls and I can get
> > rid of all the other 100+ syscalls!  :) 
> 
> Like it ioctl() does it? Number of entry points is _not_ an issue. Diversity
> of the API is. Technically, kernel has 1 (_o_n_e_) entry point as far as
> userland is concerned. int 0x80 on x86. Can't beat that, can you?

If there's one thing that could be nicer, ioctl() would be it.
ioctl() works ok in C and terribly in everything else.
CORBA works well in scripting languages and Java, and sucks in C
compared with a simple ioctl().

Is there a way to marry the best sides of each?

Is 9P that way (I don't know much about it)?

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

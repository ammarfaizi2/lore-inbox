Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132107AbQLNCVG>; Wed, 13 Dec 2000 21:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132106AbQLNCUq>; Wed, 13 Dec 2000 21:20:46 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3790 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130753AbQLNCUm>;
	Wed, 13 Dec 2000 21:20:42 -0500
Date: Wed, 13 Dec 2000 20:48:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chris Lattner <sabre@nondot.org>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <E146Mvx-0003Zj-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0012132037110.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Alan Cox wrote:

> > Don't worry about kORBit.  Like most open source projects, it will simply
> > die out after a while, because people don't find it interesting and there
> > is really no place for it.  If it becomes useful, mature, and refined,
> > however, it could be a very powerful tool for a large class of problems
> > (like moving code OUT of the kernel).
> 
> I do have one sensible question. Given that corba is while flexible a 
> relatively expensive encoding system, wouldn't it be better to keep corba
> out of kernel space and talk something which is a simple and cleaner encoding

p9fs exists.  I didn't see these patches since August, but probably I can poke
Roman into porting it to the current tree.  9P is quite simple and unlike
CORBA it had been designed for taking kernel stuff to userland.  Besides,
authors definitely understand UNIX...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

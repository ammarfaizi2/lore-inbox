Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132287AbQLNEHz>; Wed, 13 Dec 2000 23:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132305AbQLNEHq>; Wed, 13 Dec 2000 23:07:46 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:15908 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S132287AbQLNEHg>; Wed, 13 Dec 2000 23:07:36 -0500
Message-ID: <3A384054.E38C8C25@holly-springs.nc.us>
Date: Wed, 13 Dec 2000 22:36:52 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.18pre25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Lattner <sabre@nondot.org>
CC: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012132106070.24665-100000@www.nondot.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also, 9P is a general communications framework only in the context of
> Plan9 itself.  In reality it only applys directly/well to filesystem
> related issues... the reason it works well in Plan9 is that _everything_
> is a file (part of the beauty of plan9).

So... in a 9P-enabled system, you write a regular server program that
uses read(), write(), etc. to use the local (or another, remote) 9P
system and exports some interface over the network protocol and
encapsulation format of your choice. In your case, CORBA over IIOP or
something. :)

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

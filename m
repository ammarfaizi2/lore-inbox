Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQLNDja>; Wed, 13 Dec 2000 22:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130304AbQLNDjT>; Wed, 13 Dec 2000 22:39:19 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2251 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131376AbQLNDjI>;
	Wed, 13 Dec 2000 22:39:08 -0500
Date: Wed, 13 Dec 2000 22:08:39 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Lattner <sabre@nondot.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012132025310.24483-100000@www.nondot.org>
Message-ID: <Pine.GSO.4.21.0012132142100.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Chris Lattner wrote:

> CORBA, today, gives us superior interoperability (through IIOP), with
> extensibility for the future.  As Alexander Viro mentions, 9P may be a
> better protocol for local communications...

	Local? Funny. It lives atop of TCP or IL quite fine. What's
even funnier, I can use it to export /proc from CPU server to workstation
and use _that_ for remote debugging. Ditto for window system. Ditto for
DNS. Ditto for plumber. No, not on Linux...

	What you do is mapping your RPC to hierarchical namespace. After
that... What extensibility do you need? You can use every utility written
for core UNIX API (open()/read()/write()/close()) as a client. No need
to reinvent the wheel...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

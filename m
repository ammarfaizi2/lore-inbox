Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130613AbQLND0Y>; Wed, 13 Dec 2000 22:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132164AbQLND0O>; Wed, 13 Dec 2000 22:26:14 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:64289 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S130613AbQLNDZ4>; Wed, 13 Dec 2000 22:25:56 -0500
Message-ID: <3A383635.6EB5CF68@holly-springs.nc.us>
Date: Wed, 13 Dec 2000 21:53:41 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.18pre25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Lattner <sabre@nondot.org>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.GSO.4.21.0012132037110.6300-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> p9fs exists.  I didn't see these patches since August, but probably I can poke
> Roman into porting it to the current tree.  9P is quite simple and unlike
> CORBA it had been designed for taking kernel stuff to userland.  Besides,
> authors definitely understand UNIX...

I would side with Viro here. Just as we would all cringe if MSFT added
COM/ActiveX support to the NT kernel, us Unix folks cringe at the
thought of adding CORBA to the kernel. However, that doesn't mean that
we dislike the idea of exporting kernel services and interfaces for use
in userland. And Plan9 seems to have some rather elegant and efficient
methods for doing that. In Plan9, everything really is a file! It's as
if they got a chance to do Unix again, and they did it consistently this
time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130865AbQLRVKD>; Mon, 18 Dec 2000 16:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbQLRVJs>; Mon, 18 Dec 2000 16:09:48 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:47111 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S129436AbQLRVJX>;
	Mon, 18 Dec 2000 16:09:23 -0500
Date: Mon, 18 Dec 2000 14:39:37 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Fredrik Vraalsen <vraalsen@cs.uiuc.edu>,
        Rik van Riel <riel@conectiva.com.br>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Alexander Viro <viro@math.psu.edu>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <20001218004227.A2552@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21.0012181438200.13491-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   cat /mnt/www/www.kernel.org/index.html
> 
> can you do ls /mnt/www/www.kernel.org/ as well? I'm interested, I came
> to conclusion that web filesystem is not possible... (If you can't do

Yes, if the server supports webDAV or something similar.

> listings, it is not really filesystem; you could do
> 
>  cat /mnt/www/www.kernel.org_index.html as well, and that's easy to
> do.) 
> 
> > and the CorbaFS userspace server takes care of loading the webpage and
> > returning it to the kernel client.  And these new filesystems don't
> > take up any extra space in the kernel, since they all talk to the same
> > CorbaFS kernel module!  Not to mention being able to implement the
> > filesystem in any language you like, debug the implementation in
> > userspace, etc.
> 
> codafs can do pretty much the same.

Yes, but codaFS is specific to filesystems.  kORBit, of course, can do
much much more, in a very uniform way.  :)

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

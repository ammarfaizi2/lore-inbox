Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLRUiq>; Mon, 18 Dec 2000 15:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQLRUih>; Mon, 18 Dec 2000 15:38:37 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2820 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129406AbQLRUib>;
	Mon, 18 Dec 2000 15:38:31 -0500
Message-ID: <20001218004227.A2552@bug.ucw.cz>
Date: Mon, 18 Dec 2000 00:42:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: Fredrik Vraalsen <vraalsen@cs.uiuc.edu>,
        Rik van Riel <riel@conectiva.com.br>
Cc: Chris Lattner <sabre@nondot.org>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Alexander Viro <viro@math.psu.edu>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012141442390.1437-100000@duckman.distro.conectiva> <sz2g0jq9as0.fsf@kazoo.cs.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <sz2g0jq9as0.fsf@kazoo.cs.uiuc.edu>; from Fredrik Vraalsen on Thu, Dec 14, 2000 at 11:23:59AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The cool thing is that the CorbaFS userspace server can implement any
> kind of filesystem you want, as long as it follows the CorbaFS
> interface!  The current implementation exports the filesystem on the
> host machine that it is running on, similar to NFS.  But we also have
> ideas for FTP or web filesystems, for example.  Imagine being able to
> mount the web CorbaFS onto /mnt/www and do a
>  
>   cat /mnt/www/www.kernel.org/index.html

can you do ls /mnt/www/www.kernel.org/ as well? I'm interested, I came
to conclusion that web filesystem is not possible... (If you can't do
listings, it is not really filesystem; you could do

 cat /mnt/www/www.kernel.org_index.html as well, and that's easy to
do.) 

> and the CorbaFS userspace server takes care of loading the webpage and
> returning it to the kernel client.  And these new filesystems don't
> take up any extra space in the kernel, since they all talk to the same
> CorbaFS kernel module!  Not to mention being able to implement the
> filesystem in any language you like, debug the implementation in
> userspace, etc.

codafs can do pretty much the same.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

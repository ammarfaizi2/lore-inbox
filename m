Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLNSHH>; Thu, 14 Dec 2000 13:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQLNSG5>; Thu, 14 Dec 2000 13:06:57 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:61456 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129314AbQLNSGp>; Thu, 14 Dec 2000 13:06:45 -0500
Date: Thu, 14 Dec 2000 18:34:21 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Fredrik Vraalsen <vraalsen@cs.uiuc.edu>
Cc: Rik van Riel <riel@conectiva.com.br>, Chris Lattner <sabre@nondot.org>,
        Alexander Viro <viro@math.psu.edu>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
Message-ID: <20001214183421.A8472@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.21.0012141442390.1437-100000@duckman.distro.conectiva> <sz2g0jq9as0.fsf@kazoo.cs.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <sz2g0jq9as0.fsf@kazoo.cs.uiuc.edu>; from vraalsen@cs.uiuc.edu on Thu, Dec 14, 2000 at 11:23:59AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fredrik Vraalsen wrote:
> The cool thing is that the CorbaFS userspace server can implement any
> kind of filesystem you want, as long as it follows the CorbaFS
> interface!

Sorry, it's yet another one.  Or does it do something different?
(YAO hasn't stopped me working on userspace filesystems either :-)

> The current implementation exports the filesystem on the
> host machine that it is running on, similar to NFS.  But we also have
> ideas for FTP or web filesystems, for example.  Imagine being able to
> mount the web CorbaFS onto /mnt/www and do a
>  
>   cat /mnt/www/www.kernel.org/index.html
> 
> and the CorbaFS userspace server takes care of loading the webpage and
> returning it to the kernel client.  And these new filesystems don't
> take up any extra space in the kernel, since they all talk to the same
> CorbaFS kernel module!  Not to mention being able to implement the
> filesystem in any language you like, debug the implementation in
> userspace, etc.

A bit like CodaFS and Perlfs.  Except, being CORBA, you can run the
userspace server remotely? ;-) <evil grin>

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288311AbSACUvH>; Thu, 3 Jan 2002 15:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288312AbSACUur>; Thu, 3 Jan 2002 15:50:47 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:9486 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288311AbSACUuk>;
	Thu, 3 Jan 2002 15:50:40 -0500
Date: Thu, 3 Jan 2002 18:50:10 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Ken Brownfield <brownfld@irridia.com>
Cc: Andreas Hartmann <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com>
Message-ID: <Pine.LNX.4.33L.0201031848060.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Ken Brownfield wrote:

> 	A) VM has major issues
> 		1) about a dozen recent OOPS reports in VM code
> 		2) VM falls down on large-memory machines with a
> 		   high inode count (slocate/updatedb, i/dcache)
> 		3) Memory allocation failures and OOM triggers
> 		   even though caches remain full.
> 		4) Other bugs fixed in -aa and others
> 	B) Live- and dead-locks that I'm seeing on all 2.4 production
> 	   machines > 2.4.9, possibly related to A.  But how will I
> 	   ever find out?

I've spent ages trying to fix these bugs in the -ac kernel,
but they got all backed out in search of better performance.

Right now I'm developing a VM again, but I have no interest
at all in fixing the livelocks in the main kernel, they'll
just get removed again after a while.

If you want to test my VM stuff, you can get patches from
http://surriel.com/patches/ or direct access at the bitkeeper
tree on http://linuxvm.bkbits.net/

cheers,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/


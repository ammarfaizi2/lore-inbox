Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSEPCmp>; Wed, 15 May 2002 22:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316546AbSEPCmp>; Wed, 15 May 2002 22:42:45 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:4879 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316545AbSEPCmo>; Wed, 15 May 2002 22:42:44 -0400
Date: Wed, 15 May 2002 23:42:24 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
In-Reply-To: <20020516023238.GE1025@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0205152340250.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Andrea Arcangeli wrote:

> I'm not using the full blown initrd of most distros that is aware of the

Then I guess we found the problem. ;)

> > --- snip from linuxrc ----
> > mount --ro -t $rootfs $rootdev /sysroot
> > pivot_root /sysroot /sysroot/initrd
> > ------

> both lines are completly superflous, very misleading as well. I
> recommend to drop such two lines from all the full blown bug-aware
> linuxrc out there (of course after you apply the ordering fix to the
> kernel).

Personally I hope the special initrd code gets moved from
kernelspace into userspace.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/



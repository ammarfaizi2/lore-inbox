Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262157AbREQALM>; Wed, 16 May 2001 20:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262159AbREQALC>; Wed, 16 May 2001 20:11:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:4775 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262157AbREQAKs>;
	Wed, 16 May 2001 20:10:48 -0400
Date: Wed, 16 May 2001 20:10:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <E150AnM-0004cy-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105162005190.26191-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 May 2001, Alan Cox wrote:

> > 	Linus, patch is the first chunk of rootfs stuff. I've tried to
> > get it as small as possible - all it does is addition of absolute root
> > on ramfs and necessary changes to mount_root/change_root/sys_pivot_root
> > and follow_dotdot. Real root is mounted atop of the "absolute" one.
> 
> Surely this is getting right into 2.5 stuff. 

Maybe. I still think that it's local enough to be tolerable in 2.4, but
postponing it until 2.5 is not a big deal. I'll put that (and the rest
of rootfs stuff) on anonftp and post CFT. I'd appreciate review of
that code once the splitup is done, if you have time for that.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129222AbRBBG0z>; Fri, 2 Feb 2001 01:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129219AbRBBG0q>; Fri, 2 Feb 2001 01:26:46 -0500
Received: from mdmgrp1-228.accesstoledo.net ([207.43.106.228]:3844 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S129148AbRBBG0g>;
	Fri, 2 Feb 2001 01:26:36 -0500
Date: Fri, 2 Feb 2001 01:25:06 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: hiren_mehta@agilent.com, linux-kernel@vger.kernel.org
Subject: Re: problem with devfsd compilation
In-Reply-To: <E14OOjA-0004qS-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102020124010.226-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Feb 2001, Alan Cox wrote:

> > I am trying to compile devfsd on my system running RedHat linux 7.0
> > (kernel 2.2.16-22). I get the error "RTLD_NEXT" undefined. I am not
> > sure where this symbol is defined. Is there anything that I am missing 
> > on my system. 
> 
> Sounds like a missing include in the devfsd code. That comes from
> dlfcn.h.
> 

If you add -D_GNU_SOURCE to the make line in CC_OPTS (or CCOPTS, I forget
which) it works fine.  Had the same exact problem here.

	- Mike

===========================================================================
Michael B. Trausch                                    fd0man@crosswinds.net
Avid Linux User since April, '96!                           AIM:  ML100Smkr

              Contactable via IRC (DALNet) or AIM as ML100Smkr
===========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbRAaWCQ>; Wed, 31 Jan 2001 17:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129202AbRAaWCG>; Wed, 31 Jan 2001 17:02:06 -0500
Received: from mdmgrp1-167.accesstoledo.net ([207.43.106.167]:8708 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S129076AbRAaWBf>;
	Wed, 31 Jan 2001 17:01:35 -0500
Date: Tue, 30 Jan 2001 17:00:09 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: Lukasz Gogolewski <lucas@supremedesigns.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with sblive as well as 3com 3c905
In-Reply-To: <3A787D97.CBF7B327@supremedesigns.com>
Message-ID: <Pine.LNX.4.21.0101301658550.1832-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Lukasz Gogolewski wrote:
>
> After I compiled kernel 2.4.1 on rh 6.2 I enabled module support for 2
> of those devices.
> 
> However when I rebooted my machine both of those devices are not
> working.
> 
> I don't know what's wrong since I did make moudle and make
> module_install.
> 
> When I try to configure mdoule for the sound card, I get a message
> saying that module wasn't found.
> 
> For the network card I get Delaying initialization
> 
> any suggestions on how to fix it?
> 

Upgrade modutils, pppd, and other things to fix all the "problems" with
this kernel.  I found this one out, becuase the guys here politely pointed
that out to me that the "Documentation/Changes" file tells this stuff for
every kernel release.

The module directory was redesigned, as well as other internals to the
Kernel, and that's why newer utilities are required.

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129461AbRBBIXR>; Fri, 2 Feb 2001 03:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbRBBIXH>; Fri, 2 Feb 2001 03:23:07 -0500
Received: from mdmgrp1-228.accesstoledo.net ([207.43.106.228]:21508 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S129461AbRBBIWu>;
	Fri, 2 Feb 2001 03:22:50 -0500
Date: Fri, 2 Feb 2001 03:21:19 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: hiren_mehta@agilent.com
cc: linux-kernel@vger.kernel.org
Subject: Re: problem with devfsd compilation
In-Reply-To: <FEEBE78C8360D411ACFD00D0B747797188097A@xsj02.sjs.agilent.com>
Message-ID: <Pine.LNX.4.21.0102020320300.226-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001 hiren_mehta@agilent.com wrote:
>
> Hi,
> 
> I am trying to compile devfsd on my system running RedHat linux 7.0
> (kernel 2.2.16-22). I get the error "RTLD_NEXT" undefined. I am not
> sure where this symbol is defined. Is there anything that I am missing 
> on my system. 
> 

It's a problem with the makefile -- You need to have -D_GNU_SOURCE (or
#define _GNU_SOURCE as one of the first lines in all the source files of
the package)

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

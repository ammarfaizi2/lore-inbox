Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267188AbRGPChZ>; Sun, 15 Jul 2001 22:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267194AbRGPChP>; Sun, 15 Jul 2001 22:37:15 -0400
Received: from mail008.mail.bellsouth.net ([205.152.58.28]:34046 "EHLO
	imf08bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S267188AbRGPCg7>; Sun, 15 Jul 2001 22:36:59 -0400
Date: Sun, 15 Jul 2001 22:38:31 -0400 (EDT)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Aaron Smith <yoda_2002@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: "oversized" files
In-Reply-To: <20010715212006.A408@jacana.dyn.dhs.org>
Message-ID: <Pine.LNX.4.20.0107152228060.1650-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Jul 2001, Aaron Smith wrote:

> I'm really not sure if this is pertinent to Linux Kernel, but I'm asking here anyway, 0 in advance if it's not.
> 
> I have a file that is approximately 3.25GB and my system keeps bitching about "Value too large for defined data type."  Is there any way to stop this?  Since I'm sure you're wondering why I have a file that large, I'm using it via loopback as my MP3 partition, so I can remove it fairly quick if the need should ever arise.

As was explained to me (just today ;) ) this is an issue of 32bit versus
64bit file sizes (and not filesystem returning junk values as I thought),
so to get this working you need a version of fileutils and C library that
supports this.

I still don't know how to upgrade by compiling the source code, but
installation of latest (8.0) Slackware packages for C library and
fileutils fixed things for me. Be careful while upgrading your C library -
things might break.

                           Vladimir Dergachev

> -- 
> -Aaron
> 
> Don't hate yourself in the morning, sleep till noon
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRGPCwI>; Sun, 15 Jul 2001 22:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264582AbRGPCv6>; Sun, 15 Jul 2001 22:51:58 -0400
Received: from 64.5.206.104 ([64.5.206.104]:516 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S262288AbRGPCvp>; Sun, 15 Jul 2001 22:51:45 -0400
Date: Sun, 15 Jul 2001 22:51:45 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <volodya@mindspring.com>
cc: Aaron Smith <yoda_2002@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: "oversized" files
In-Reply-To: <Pine.LNX.4.20.0107152228060.1650-100000@node2.localnet.net>
Message-ID: <Pine.LNX.4.33.0107152248380.17437-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jul 2001 volodya@mindspring.com wrote:

> On Sun, 15 Jul 2001, Aaron Smith wrote:
>
> > I'm really not sure if this is pertinent to Linux Kernel, but I'm asking here anyway, 0 in advance if it's not.
> >
> > I have a file that is approximately 3.25GB and my system keeps bitching about "Value too large for defined data type."  Is there any way to stop this?  Since I'm sure you're wondering why I have a file that large, I'm using it via loopback as my MP3 partition, so I can remove it fairly quick if the need should ever arise.
>
> As was explained to me (just today ;) ) this is an issue of 32bit versus
> 64bit file sizes (and not filesystem returning junk values as I thought),
> so to get this working you need a version of fileutils and C library that
> supports this.
>
> I still don't know how to upgrade by compiling the source code, but
> installation of latest (8.0) Slackware packages for C library and
> fileutils fixed things for me. Be careful while upgrading your C library -
> things might break.
>
>                            Vladimir Dergachev
> > --
> > -Aaron

Actually, in this case it will probably require losetup to be rebuilt.

And as always, the kernel will require LFS support as well.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>



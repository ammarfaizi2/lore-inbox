Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267591AbRGPS1b>; Mon, 16 Jul 2001 14:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267597AbRGPS1W>; Mon, 16 Jul 2001 14:27:22 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:43759 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267591AbRGPS1G>; Mon, 16 Jul 2001 14:27:06 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107161826.f6GIQqlL002806@webber.adilger.int>
Subject: Re: [CHECKER] 52 probable security holes in 2.4.6 and 2.4.6-ac2
In-Reply-To: <3B530E9A.2080500@valinux.com> "from Jeff Hartmann at Jul 16, 2001
 09:56:10 am"
To: Jeff Hartmann <jhartmann@valinux.com>
Date: Mon, 16 Jul 2001 12:26:51 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Hartmann write:
> Kenneth Michael Ashcraft wrote:
> > [BUG] but mainly can make the kernel allocate unbounded amount of
> >       memory and crash.
> This is not a bug.  This is a root only ioctl called only during Xserver 
> initialization/recycle.  It can't be called anywhere else.

So you're saying that root is perfectly secure, and that the Xserver never
has any bugs in it? ;-)

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

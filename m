Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSFFQ2W>; Thu, 6 Jun 2002 12:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317006AbSFFQ2W>; Thu, 6 Jun 2002 12:28:22 -0400
Received: from www.transvirtual.com ([206.14.214.140]:7433 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317005AbSFFQ2V>; Thu, 6 Jun 2002 12:28:21 -0400
Date: Thu, 6 Jun 2002 09:28:02 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: More fbdev to pull
In-Reply-To: <20020606155621.C21322@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0206060927470.18272-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Jun 06, 2002 at 06:48:00AM -0700, James Simmons wrote:
> >    Now for the new rounds of updates. Please pull the fbdev BK updates and
> > bug fixes.
> >
> > http://fbdev.bkbits.net:8080/fbdev-2.5
> >
> > Standard diff:
> >
> > http://www.transvirtual.com/~jsimmons/fbdev.diff.gz
>
> diffstat output would be useful.  Can you make it part of your standard
> mailings please?  That way, individual framebuffer maintainers know
> whether they need to bother looking or not.

 drivers/video/Config.in     |   40
 drivers/video/Makefile      |   28
 drivers/video/anakinfb.c    |    4
 drivers/video/aty128fb.c    |    5
 drivers/video/cfbcopyarea.c |    4
 drivers/video/cfbimgblt.c   |   10
 drivers/video/clps711xfb.c  |    3
 drivers/video/cyber2000fb.c |    5
 drivers/video/dn_accel.h    |    9
 drivers/video/dn_cfb4.c     |  492 -----
 drivers/video/dn_cfb8.c     |  540 ------
 drivers/video/dnfb.c        |  535 +-----
 drivers/video/fbcmap.c      |    2
 drivers/video/fbmem.c       |    3
 drivers/video/maxinefb.c    |  290 ---
 drivers/video/neofb.c       | 3639 ++++++++++++++++++++------------------------
 drivers/video/neofb.h       |  291 ---
 drivers/video/pm2fb.c       |  745 ++++++---
 drivers/video/pmag-ba-fb.c  |  343 ----
 drivers/video/pmagb-b-fb.c  |  344 ----
 drivers/video/skeletonfb.c  |    2
 drivers/video/tdfxfb.c      | 2434 ++++++++---------------------
 drivers/video/tx3912fb.c    |  566 ++----
 drivers/video/tx3912fb.h    |  128 -
 drivers/video/vfb.c         |    4
 include/video/neomagic.h    |  264 +++
 include/video/pm2fb.h       |  222 ++
 include/video/tx3912.h      |   62
 28 files changed, 4034 insertions(+), 6980 deletions(-)


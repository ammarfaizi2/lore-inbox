Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSFERV2>; Wed, 5 Jun 2002 13:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSFERV1>; Wed, 5 Jun 2002 13:21:27 -0400
Received: from www.transvirtual.com ([206.14.214.140]:65029 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315629AbSFERV0>; Wed, 5 Jun 2002 13:21:26 -0400
Date: Wed, 5 Jun 2002 10:21:19 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbdev updates.
In-Reply-To: <20020605175013.G10293@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0206051020150.24667-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Jun 05, 2002 at 09:39:48AM -0700, James Simmons wrote:
> > Since no one has complianed for some time I like to push the next set of
> > changes to Linus. Anyone with objections please give a yell.
>
> A small suggestion - could you post diffstat -p1 output with your patch
> announcements please?

Patch at http://www.transvirtual.com/~jsimmons/fbdev.diff.gz

diffstat results:

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



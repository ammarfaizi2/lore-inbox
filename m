Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262621AbSJIXkt>; Wed, 9 Oct 2002 19:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbSJIXkt>; Wed, 9 Oct 2002 19:40:49 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:30362 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262621AbSJIXkr>; Wed, 9 Oct 2002 19:40:47 -0400
Date: Wed, 9 Oct 2002 20:46:07 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andreas Dilger <adilger@clusterfs.com>
cc: Robert Love <rml@tech9.net>, Marco Colombo <marco@esi.it>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
In-Reply-To: <20021009152731.GY3045@clusterfs.com>
Message-ID: <Pine.LNX.4.44L.0210092045195.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Andreas Dilger wrote:
> On Oct 09, 2002  10:14 -0400, Robert Love wrote:
> > On Wed, 2002-10-09 at 10:10, Marco Colombo wrote:
> >
> > > >  #define O_NOFOLLOW	0400000 /* don't follow links */
> > > >  #define O_NOFOLLOW	0x20000	/* don't follow links */
> >
> > No need.  See for example O_NOFOLLOW right above.  Each architecture can
> > do has it pleases (I wish otherwise, but...).
>
> I would say - if you are picking a new flag that doesn't need to have
> compatibility with any platform-specific existing flag, simply set them
> all high enough so that they are the same on all platforms.

Doesn't really matter, you can't run x86 binaries on MIPS so
you need to recompile anyway.

Source level compatibility is enough for flags like this.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>


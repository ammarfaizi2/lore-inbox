Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVFUNoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVFUNoN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVFUNlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:41:21 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:520 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261462AbVFUNhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:37:40 -0400
Date: Tue, 21 Jun 2005 15:37:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] lib/zlib*: possible cleanups
Message-ID: <20050621133738.GM3666@stusta.de>
References: <20050620234326.GG3666@stusta.de> <20050620172920.541f4112.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620172920.541f4112.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 05:29:20PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > - #if 0 the following unused functions:
> >   - zlib_deflate/deflate.c: zlib_deflateSetDictionary
> >   - zlib_deflate/deflate.c: zlib_deflateParams
> >   - zlib_deflate/deflate.c: zlib_deflateCopy
> >   - zlib_inflate/infblock.c: zlib_inflate_set_dictionary
> >   - zlib_inflate/infblock.c: zlib_inflate_blocks_sync_point
> >   - zlib_inflate/inflate_sync.c: zlib_inflateSync
> >   - zlib_inflate/inflate_sync.c: zlib_inflateSyncPoint
> 
> OK...
> 
> > - remove the following unneeded EXPORT_SYMBOL's:
> >   - zlib_deflate/deflate_syms.c: zlib_deflateCopy
> >   - zlib_deflate/deflate_syms.c: zlib_deflateParams
> >   - zlib_inflate/inflate_syms.c: zlib_inflateSync
> >   - zlib_inflate/inflate_syms.c: zlib_inflateSyncPoint
> 
> Adrian, I've dropped just about every "remove the following unneeded
> EXPORT_SYMBOL's" I've seen in the past several months.  We've been round this
> numerous times.
> 
> The question is, who are we screwing if we remove these?
> 
> It's difficult to answer, but we need to answer it.


I'm sorry, but I'm not getting your point:

First, you ACK the part of my patch to #if 0 unused functions.

Then you complain that I've documented which EXPORT_SYMBOL's I have to 
remove because I have #if 0'ed the functions they are exporting.


Will the patch be OK for you if I'll simply remove the part of the patch 
description stating which of the #if 0'ed functions had been exported?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


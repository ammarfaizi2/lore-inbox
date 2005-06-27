Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVF0Lf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVF0Lf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 07:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVF0Le3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 07:34:29 -0400
Received: from 135.80-203-45.nextgentel.com ([80.203.45.135]:10290 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261931AbVF0LeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 07:34:16 -0400
Subject: Re: [2.6 patch] lib/zlib*: possible cleanups
From: Kjartan Maraas <kmaraas@broadpark.no>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050621133738.GM3666@stusta.de>
References: <20050620234326.GG3666@stusta.de>
	 <20050620172920.541f4112.akpm@osdl.org>  <20050621133738.GM3666@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Jun 2005 10:51:58 +0200
Message-Id: <1119862318.2760.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 21,.06.2005 kl. 15.37 +0200, skrev Adrian Bunk:
> On Mon, Jun 20, 2005 at 05:29:20PM -0700, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > - #if 0 the following unused functions:
> > >   - zlib_deflate/deflate.c: zlib_deflateSetDictionary
> > >   - zlib_deflate/deflate.c: zlib_deflateParams
> > >   - zlib_deflate/deflate.c: zlib_deflateCopy
> > >   - zlib_inflate/infblock.c: zlib_inflate_set_dictionary
> > >   - zlib_inflate/infblock.c: zlib_inflate_blocks_sync_point
> > >   - zlib_inflate/inflate_sync.c: zlib_inflateSync
> > >   - zlib_inflate/inflate_sync.c: zlib_inflateSyncPoint
> > 
> > OK...
> > 
> > > - remove the following unneeded EXPORT_SYMBOL's:
> > >   - zlib_deflate/deflate_syms.c: zlib_deflateCopy
> > >   - zlib_deflate/deflate_syms.c: zlib_deflateParams
> > >   - zlib_inflate/inflate_syms.c: zlib_inflateSync
> > >   - zlib_inflate/inflate_syms.c: zlib_inflateSyncPoint
> > 
> > Adrian, I've dropped just about every "remove the following unneeded
> > EXPORT_SYMBOL's" I've seen in the past several months.  We've been round this
> > numerous times.
> > 
> > The question is, who are we screwing if we remove these?
> > 
> > It's difficult to answer, but we need to answer it.
> 
> 
> I'm sorry, but I'm not getting your point:
> 
> First, you ACK the part of my patch to #if 0 unused functions.
> 
> Then you complain that I've documented which EXPORT_SYMBOL's I have to 
> remove because I have #if 0'ed the functions they are exporting.
> 
The way I read it the "OK..." wasn't an agreement with the first hunk
but more of a prelude to the following comment. Or maybe I got it all
wrong too :-)

Cheers
Kjartan


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319288AbSHNT6v>; Wed, 14 Aug 2002 15:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319290AbSHNT6u>; Wed, 14 Aug 2002 15:58:50 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:43668 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S319288AbSHNT6u>;
	Wed, 14 Aug 2002 15:58:50 -0400
Date: Wed, 14 Aug 2002 22:02:40 +0200
From: David Weinehall <tao@acc.umu.se>
To: Christoph Hellwig <hch@infradead.org>,
       Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac1 does not compile
Message-ID: <20020814200240.GS259@khan.acc.umu.se>
References: <3D5A9451.C240C27A@wanadoo.fr> <20020814184040.A21382@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020814184040.A21382@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 06:40:40PM +0100, Christoph Hellwig wrote:
> On Wed, Aug 14, 2002 at 07:33:05PM +0200, Jean-Luc Coulon wrote:
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6  
> > -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
> > -DKBUILD_BASENAME=swap_state  -c -o swap_state.o swap_state.c
> > swap_state.c:155: macro `PAGE_BUG' used without args
> 
> make that a plain BUG() - no idea what drove alan into that..

Shouldn't it be PAGE_BUG(page)?!


Regards: David
-- 
 /> David Weinehall <tao@acc.umu.se> /> Northern lights wander      <\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </

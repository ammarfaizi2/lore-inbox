Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319273AbSHNTue>; Wed, 14 Aug 2002 15:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319274AbSHNTue>; Wed, 14 Aug 2002 15:50:34 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:54458 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S319273AbSHNTud>;
	Wed, 14 Aug 2002 15:50:33 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac1 does not compile
References: <3D5A9451.C240C27A@wanadoo.fr>
	<20020814184040.A21382@infradead.org>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 14 Aug 2002 21:53:53 +0200
In-Reply-To: <20020814184040.A21382@infradead.org>
Message-ID: <m3znvpjjxq.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Wed, Aug 14, 2002 at 07:33:05PM +0200, Jean-Luc Coulon wrote:
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6  
> > -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
> > -DKBUILD_BASENAME=swap_state  -c -o swap_state.o swap_state.c
> > swap_state.c:155: macro `PAGE_BUG' used without args
> 
> make that a plain BUG() - no idea what drove alan into that..
> 

When nfsd is compiled as a module it fails on depmod -a, as
exp_readunlock can't be found.

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313038AbSC0PgB>; Wed, 27 Mar 2002 10:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313037AbSC0Pfv>; Wed, 27 Mar 2002 10:35:51 -0500
Received: from durham-24-086.biz.dsl.gtei.net ([4.3.24.86]:52102 "EHLO
	amanda.mallet-assembly.org") by vger.kernel.org with ESMTP
	id <S313036AbSC0Pfi>; Wed, 27 Mar 2002 10:35:38 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
In-Reply-To: <Pine.LNX.4.33.0203271419230.28110-100000@sphinx.mythic-beasts.com>
From: Michael Alan Dorman <mdorman@debian.org>
Date: 27 Mar 2002 10:35:37 -0500
Message-ID: <87r8m6f2gm.fsf@amanda.mallet-assembly.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Kirkwood <matthew@hairy.beasts.org> writes:
> Postgres doesn't pre-allocate datafiles.  

I haven't recieved your original message, so I don't know what version
of PostgreSQL you're using, but I believe it is pertinent given that
versions >= 7.2 (and perhaps >= 7.1) *do* pre-allocate WAL logs, which
is where most of the action is.

It might be that in this situation you might benefit from any
reduction in FS overhead even if it means a reduction in features
because WAL is going to dramatically change the way disk access
happens.

Mike.

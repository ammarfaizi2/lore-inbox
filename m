Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSJPRrK>; Wed, 16 Oct 2002 13:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261273AbSJPRrK>; Wed, 16 Oct 2002 13:47:10 -0400
Received: from mail-2.tiscali.it ([195.130.225.148]:22525 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S261310AbSJPRrJ> convert rfc822-to-8bit;
	Wed, 16 Oct 2002 13:47:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>
Organization: -ENOENT
To: "Theodore Ts'o" <tytso@mit.edu>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>
Subject: Re: [PATCH 2/3] Add extended attributes to ext2/3
Date: Wed, 16 Oct 2002 19:50:54 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <E181a3S-0006Nq-00@snap.thunk.org> <aojc1q$l37$1@forge.intermeta.de> <20021016161620.GC8210@think.thunk.org>
In-Reply-To: <20021016161620.GC8210@think.thunk.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210161950.54993.l.allegrucci@tiscalinet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 October 2002 18:16, Theodore Ts'o wrote:
> On Wed, Oct 16, 2002 at 09:38:02AM +0000, Henning P. Schmiedehausen wrote:
> > tytso@mit.edu writes:
> > >+	int ea_blocks = EXT3_I(inode)->i_file_acl ?
> > >+		(inode->i_sb->s_blocksize >> 9) : 0;
> >
> > Sometimes I wonder if we shouldn't have the block size (512) and the
> > bit shift (9) as defines somewhere and gradually shift away from hard
> > coded values...
> >
> > If we ever decide to change the block size of ext2/ext3, we're in for
> > a "looking for nines"... :-)
>
> We already have different block sizes for ext2/3; we support 1k, 2k,
> and 4k block sizes.

BTW, why doesn't ext2/3 support 512 byte block sizes?


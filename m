Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262440AbSJOLVY>; Tue, 15 Oct 2002 07:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262443AbSJOLVY>; Tue, 15 Oct 2002 07:21:24 -0400
Received: from thunk.org ([140.239.227.29]:42701 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262440AbSJOLVY>;
	Tue, 15 Oct 2002 07:21:24 -0400
Date: Tue, 15 Oct 2002 07:27:13 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Add extended attributes to ext2/3
Message-ID: <20021015112713.GA31235@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <E181ISM-0001DW-00@snap.thunk.org> <87it04ngk1.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87it04ngk1.fsf@goat.bogus.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 12:26:54PM +0200, Olaf Dietsche wrote:
> > diff -Nru a/fs/Config.in b/fs/Config.in
> > --- a/fs/Config.in	Mon Oct 14 23:21:23 2002
> > +++ b/fs/Config.in	Mon Oct 14 23:21:23 2002
> > @@ -93,6 +93,7 @@
> >  tristate 'ROM file system support' CONFIG_ROMFS_FS
> >  
> >  tristate 'Second extended fs support' CONFIG_EXT2_FS
> > +dep_bool '  Ext2 extended attributes' CONFIG_EXT2_FS_XATTR $CONFIG_EXT3_FS
>                                                                         ^^^
> Is this intentional?

Nope, that's a typo.  Thanks for catching it.

							- Ted

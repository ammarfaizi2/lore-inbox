Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264640AbSJOKVL>; Tue, 15 Oct 2002 06:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264641AbSJOKVL>; Tue, 15 Oct 2002 06:21:11 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:23525 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264640AbSJOKVK>; Tue, 15 Oct 2002 06:21:10 -0400
To: tytso@mit.edu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Add extended attributes to ext2/3
References: <E181ISM-0001DW-00@snap.thunk.org>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Tue, 15 Oct 2002 12:26:54 +0200
Message-ID: <87it04ngk1.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu writes:

> This patch adds extended attribute support to the ext2 filesystem.  This
> uses the generic extended attribute patch which was developed by Andreas
> Gruenbacher and the XFS team.  As a result, the user space utilities
> which work for XFS will also work with these patches.
[...]
> diff -Nru a/fs/Config.in b/fs/Config.in
> --- a/fs/Config.in	Mon Oct 14 23:21:23 2002
> +++ b/fs/Config.in	Mon Oct 14 23:21:23 2002
> @@ -93,6 +93,7 @@
>  tristate 'ROM file system support' CONFIG_ROMFS_FS
>  
>  tristate 'Second extended fs support' CONFIG_EXT2_FS
> +dep_bool '  Ext2 extended attributes' CONFIG_EXT2_FS_XATTR $CONFIG_EXT3_FS
                                                                        ^^^
Is this intentional?

Regards, Olaf.

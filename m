Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVDBWsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVDBWsS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 17:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVDBWsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:48:18 -0500
Received: from mail.dif.dk ([193.138.115.101]:41378 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261308AbVDBWsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:48:14 -0500
Date: Sun, 3 Apr 2005 00:50:31 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][0/7] cifs: dir.c cleanup 
Message-ID: <Pine.LNX.4.62.0504030042490.2525@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steve,

Here's yet another round of cleanups for fs/cifs/ - this time it's for 
dir.c. 
I believe this marks the end of the files you wanted done in a specific 
order, so now I'll be going through the remaining ones in arbitrary order.

Just like for the previous files I've split the cleanups into chunks that 
do just one (or a few closely related) thing.

The patches will be sent inline with explanations shortly, but are also 
available here : 
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_dir-cleanup-functions.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_dir-cleanup-spaces.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_dir-cleanup-comments.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_dir-cleanup-kfree.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_dir-cleanup-cast.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_dir-cleanup-long-lines-1.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_dir-cleanup-long-lines-2.patch
		(listed in the order they apply)


-- 
Jesper Juhl



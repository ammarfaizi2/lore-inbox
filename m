Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVCPNPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVCPNPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 08:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbVCPNPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 08:15:22 -0500
Received: from mail.dif.dk ([193.138.115.101]:50834 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262572AbVCPNOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 08:14:47 -0500
Date: Wed, 16 Mar 2005 14:14:50 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: smfrench@austin.rr.com, linux-kernel@vger.kernel.org
Subject: [PATCH][0/7] cifs: file.c cleanups in incremental bits
Message-ID: <Pine.LNX.4.62.0503161402550.3141@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steven,

Here 's a version of my fs/cifs/file.c cleanup patch split into seven 
chunks for easier review.
Please use these incremental patches instead of the big one I send you 
earlier since I've made a few changes compared to that.

Since you seemed to have trouble with the original patch when included 
inline I'll attach the patch files instead, along with a description of 
each patch in the email.

For your convenience the patches are also available online at :
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-whitespace-changes.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-kfree-changes.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-cifs_init_private.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-cifs_open_inode_helper.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-cifs_convert_flags.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-cifs_get_disposition.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-condense_if_else.patch
(listed in the order they apply)

The first patch applies on top of the first whitespace cleanup patch you 
already applied to your tree, so you should be able to just apply all 7 in 
order to your tree.

I still haven't managed to get hold of/setup a cifs server to test these 
against, so they are still only compile tested.


-- 
Jesper Juhl



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVCSQpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVCSQpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 11:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVCSQpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 11:45:16 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:6547 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262463AbVCSQpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 11:45:11 -0500
Message-ID: <423C5715.3020307@austin.rr.com>
Date: Sat, 19 Mar 2005 10:45:09 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/7] cifs: file.c cleanups in incremental bits
References: <Pine.LNX.4.62.0503161402550.3141@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0503161402550.3141@dragon.hyggekrogen.localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

>Here 's a version of my fs/cifs/file.c cleanup patch split into seven 
>chunks for easier review.
>Please use these incremental patches instead of the big one I send you 
>earlier since I've made a few changes compared to that.
>
>For your convenience the patches are also available online at :
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-whitespace-changes.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-kfree-changes.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-cifs_init_private.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-cifs_open_inode_helper.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-cifs_convert_flags.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-cifs_get_disposition.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_file-cleanups-3-condense_if_else.patch
>(listed in the order they apply)
>
I have reviewed and applied the first two, and also reviewed the 
get_disposition patch (which is also fine).  I will review the others 
this weekend.  Good work - thanks.

>I still haven't managed to get hold of/setup a cifs server to test these 
>against, so they are still only compile tested.
>  
>
I did some testing of this against Samba server last night.

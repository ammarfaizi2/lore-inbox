Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135858AbRDYMkE>; Wed, 25 Apr 2001 08:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135857AbRDYMjy>; Wed, 25 Apr 2001 08:39:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54923 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135854AbRDYMjk>;
	Wed, 25 Apr 2001 08:39:40 -0400
Date: Wed, 25 Apr 2001 08:39:38 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Subject: Re: [CFT][PATCH] namespaces patch (2.4.4-pre6)
In-Reply-To: <Pine.GSO.4.21.0104231758300.4968-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0104250836270.10935-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



New version of patch is on ftp.math.psu.edu/pub/viro/namespaces-d-S4-pre6.gz

	* Fixed idiotic bug in do_add_mount() - the thing forgot
to pass error value back to the caller.

> News:
> 	* ported to 2.4.4-pre6
> 	* fixes for d_flags races (already in -ac, hopefully will go into
> the main tree soon)
> 	* fixes for sync_inodes()/kill_super() races (submitted to Linus
> and Alan, hopefully will go into the tree soon)
> 	* killed low-memory deadlocks between {u,re,}mount and kswapd.
> 	* further cleanup of fs/super.c
> 
> It works here. Please, help with testing. Patch had somewhat grown, but
> new pieces are fixes for the bugs present in the main tree and these
> fixes had been submitted for inclusion in 2.4, so hopefully it will
> shrink again.
>  							Cheers,
>  								Al
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


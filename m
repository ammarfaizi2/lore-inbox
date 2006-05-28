Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWE1W7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWE1W7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 18:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWE1W7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 18:59:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:24985 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751029AbWE1W7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 18:59:03 -0400
From: Neil Brown <neilb@suse.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 29 May 2006 08:58:36 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17530.11036.427239.812677@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.18 - spelling fix
In-Reply-To: message from Justin Piszcz on Saturday May 27
References: <Pine.LNX.4.64.0605272016520.28903@p34>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday May 27, jpiszcz@lucidpixels.com wrote:
> I was experimenting with Linux SW raid today and found a spelling error 
> when reading the help menus...
> 
> Patch attached, not sure if this is the right place to send it or if 
> patches go to Andrew Morton (misc ones like this)...

Thanks....
but more helpful than a spelling fix would be a chunk of elisp that I
could stick in my .emacs, which would automatically turn on flyspell
mode in Kconfig files, and inside comments in .c and .h files.

The first bit is probably trivial.  The second has got to be
possible...

Or maybe just keep posting patches like this in the hope of shaming
people like me into learning how to spell....

;-)

Thanks.

NeilBrown

> 
> Justin.
> 
> diff -uprN linux-2.6.16.18/drivers/md/Kconfig linux-2.6.16.18-diff/drivers/md/Kconfig
> --- linux-2.6.16.18/drivers/md/Kconfig	2006-05-22 14:04:35.000000000 -0400
> +++ linux-2.6.16.18-diff/drivers/md/Kconfig	2006-05-27 20:14:50.501458687 -0400
> @@ -90,7 +90,7 @@ config MD_RAID10
>  	depends on BLK_DEV_MD && EXPERIMENTAL
>  	---help---
>  	  RAID-10 provides a combination of striping (RAID-0) and
> -	  mirroring (RAID-1) with easier configuration and more flexable
> +	  mirroring (RAID-1) with easier configuration and more flexible
>  	  layout.
>  	  Unlike RAID-0, but like RAID-1, RAID-10 requires all devices to
>  	  be the same size (or at least, only as much as the smallest device

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVDYVrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVDYVrb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVDYVrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:47:31 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:46350 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261226AbVDYVrX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:47:23 -0400
Date: Mon, 25 Apr 2005 17:34:48 -0400
From: Jeff Dike <jdike@addtoit.com>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, axboe@suse.de
Subject: Re: [patch 1/1] uml ubd: handle readonly status
Message-ID: <20050425213448.GA6343@ccure.user-mode-linux.org>
References: <20050425191949.E56D145EBB@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425191949.E56D145EBB@zion>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 09:19:49PM +0200, blaisorblade@yahoo.it wrote:
> +	/* This should no more be needed. And it didn't work anyway to exclude
> +	 * read-write remounting of filesystems.*/
> +	/*if((filp->f_mode & FMODE_WRITE) && !dev->openflags.w){
>  	        if(--dev->count == 0) ubd_close(dev);
>  	        err = -EROFS;
> -	}
> +	}*/

> +	/* This should be impossible now */

> +		/* This should be impossible now */

If code can't run any more because of now-impossible conditions, then just
delete it.

				Jeff

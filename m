Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289321AbSBGMk1>; Thu, 7 Feb 2002 07:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287710AbSBGMkR>; Thu, 7 Feb 2002 07:40:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42759 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287681AbSBGMkB>;
	Thu, 7 Feb 2002 07:40:01 -0500
Date: Thu, 7 Feb 2002 13:39:33 +0100
From: Jens Axboe <axboe@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make ide-dma compile in 2.5.4-pre2, woops
Message-ID: <20020207133933.K731@suse.de>
In-Reply-To: <200202071235.NAA23592@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202071235.NAA23592@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07 2002, Mikael Pettersson wrote:
> On Thu, 7 Feb 2002 09:45:12 +0100, Jens Axboe wrote:
> >A minor slip up on my behalf broke ide-dma compile in 2.5.4-pre2 due to
> >the scatterlist ->address removal. This patch should make it work again,
> 
> ide-dma, ide-scsi, and sg compile and work fine for me in 2.5.4-pre2.
> It seems the ->address removal is only in your tree, not Linus'.

It's quite possible that there is some patch confusion atm, I haven't
even read the 'regular' patch yet. Or maybe it just didn't make
2.5.4-pre2 tag, it seems to be in there.

-- 
Jens Axboe


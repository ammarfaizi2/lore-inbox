Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271518AbRHPIHm>; Thu, 16 Aug 2001 04:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271519AbRHPIHd>; Thu, 16 Aug 2001 04:07:33 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:57098 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S271518AbRHPIHZ>; Thu, 16 Aug 2001 04:07:25 -0400
Date: Thu, 16 Aug 2001 10:10:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Hisaaki Shibata <shibata@luky.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4.7GB DVD-RAM geometry wrong?
Message-ID: <20010816101007.T4352@suse.de>
In-Reply-To: <20010815233424P.shibata@luky.org> <20010816114439K.shibata@luky.org> <20010816085025.M4352@suse.de> <20010816165326B.shibata@luky.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010816165326B.shibata@luky.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16 2001, Hisaaki Shibata wrote:
> I got many warnings. but I dare send this.
> 
> I hope it will be your help and mine.

I don't have the -ac[5] tree handy, in the 2.4.9-pre4 there's no BUG in
get_empty_inode(). For DVD-RAM + UDF, I would suggest using the version
from CVS. I know it quite recently got some fixes that removed a BUG or
two when used with the -ac kernels.

So could you reproduce with latest -ac or Linus kernel + CVS UDF?
Thanks.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263806AbRFDUOs>; Mon, 4 Jun 2001 16:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263819AbRFDUOi>; Mon, 4 Jun 2001 16:14:38 -0400
Received: from cicero2.cybercity.dk ([212.242.40.53]:30981 "HELO
	cicero2.cybercity.dk") by vger.kernel.org with SMTP
	id <S263806AbRFDUOY>; Mon, 4 Jun 2001 16:14:24 -0400
Date: Mon, 4 Jun 2001 22:14:04 +0200
From: Jens Axboe <axboe@suse.de>
To: PROFETA Mickael <profeta@crans.ens-cachan.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide retry on 2.4.5-ac7
Message-ID: <20010604221404.A19333@suse.de>
In-Reply-To: <20010604140207.A529@alezan.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010604140207.A529@alezan.dyndns.org>; from profeta@crans.ens-cachan.fr on Mon, Jun 04, 2001 at 02:02:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04 2001, PROFETA Mickael wrote:
> Hi
> 
> 	Since my first try on 2.4 kernel, I had trouble with DMA when I
> 	select activate on boot time because it selects udma4, whereas
> 	my HD is only able to do udma2. I correct that with hdparm, but
> 	I was quite happy of the patch in ac4 whixh detect ide lost
> 	interrupt and retry with a value lower of dma.  But it seems
> 	that this patch does not work anymore in ac7?? I can not see in
> 	the changelog that you come back or made other change in ide??
> 	Should it work in the same way or not?
> 
> 	My hardware: via 686a of course, with Athlon 500 on a k7m MB

It worked sucessfully for you in 2.4.5-ac4 but not in -ac7? I can't see
any changes to the patch, so more details on the nature of the problem
would be helpful.

-- 
Jens Axboe

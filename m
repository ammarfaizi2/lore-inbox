Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263886AbRFDV1J>; Mon, 4 Jun 2001 17:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263900AbRFDV07>; Mon, 4 Jun 2001 17:26:59 -0400
Received: from 246.35.232.212.infosources.fr ([212.232.35.246]:47621 "HELO
	fjord.dyndns.org") by vger.kernel.org with SMTP id <S263886AbRFDV0r>;
	Mon, 4 Jun 2001 17:26:47 -0400
Date: Mon, 4 Jun 2001 23:25:58 +0200
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide retry on 2.4.5-ac7
Message-ID: <20010604232558.C6188@alezan.dyndns.org>
In-Reply-To: <20010604140207.A529@alezan.dyndns.org> <20010604221404.A19333@suse.de> <20010604230215.A6188@alezan.dyndns.org> <20010604230932.A23128@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010604230932.A23128@suse.de>; from axboe@suse.de on Mon, Jun 04, 2001 at 11:09:33PM +0200
From: profeta@crans.ens-cachan.fr (PROFETA Mickael)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2001 at 11:09:33PM +0200, Jens Axboe wrote:
> 
> This is not the case that is attempted solve. The above could be a cable
> error (it looks like it). These are usually genuine and indicate a real
> hw problem.

I know about that, but I tried with other cable and the trouble leaves the
same. On the other hand, before kernel 2.4.2 I think, (not sure of the number)
the kernel does not want to activate UDMA on startup even with the option
activated, and this on via mb. At that time, I used to force the DMA with
hdparm, and I had no troubles in dma mode 3 with that hard disk, and I can
remeber that udma mode 4 was even not indicate when I try hdparm -I /dev/hdc,
so I don't know why it detects dma 4, and I did not manage to change that at
boot time. 
Another example is the hda, which is an ibm DTLA hard drive. In 2.4.2 a 2.4.3
he made the same error in udma mode4, and since 2.4.4 no troubles anymore... I
find it difficult to believe that it is hardware trouble!
Furthemore, I began this thread because I heard someone else on this mailing
list with the same crc error and I thought the patch in ac4 was in a way to
solve the dma detect fails.

	thanks for your help

	Mike

> 
> -- 
> Jens Axboe


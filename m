Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAIRjg>; Tue, 9 Jan 2001 12:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbRAIRjO>; Tue, 9 Jan 2001 12:39:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30476 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129383AbRAIRjA>;
	Tue, 9 Jan 2001 12:39:00 -0500
Date: Tue, 9 Jan 2001 18:38:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mingo@elte.hu, "Stephen C. Tweedie" <sct@redhat.com>,
        Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109183808.A12128@suse.de>
In-Reply-To: <Pine.LNX.4.30.0101091743090.5932-100000@e2> <E14G2aT-00071v-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14G2aT-00071v-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jan 09, 2001 at 05:29:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09 2001, Alan Cox wrote:
> > ever seen, this is why i quoted it - the talk was about block-IO
> > performance, and Stephen said that our block IO sucks. It used to suck,
> > but in 2.4, with the right patch from Jens, it doesnt suck anymore. )
> 
> Thats fine. Get me 128K-512K chunks nicely streaming into my raid controller
> and I'll be a happy man

No problem, apply blk-13B and you'll get 512K chunks for SCSI and RAID.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

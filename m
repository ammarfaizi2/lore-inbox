Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281727AbRKULVV>; Wed, 21 Nov 2001 06:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281726AbRKULVN>; Wed, 21 Nov 2001 06:21:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22033 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281294AbRKULUy>;
	Wed, 21 Nov 2001 06:20:54 -0500
Date: Wed, 21 Nov 2001 12:20:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
Message-ID: <20011121122034.B9978@suse.de>
In-Reply-To: <Pine.GSO.4.33.0111210945590.795-100000@gurney> <E166VOz-0004kH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E166VOz-0004kH-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21 2001, Alan Cox wrote:
> > CPU0 is labelled as an "AMD Athlon(tm) MP Processor 1800+", as expected.
> > CPU1 is instead labelled just "AMD Athlon(tm) Processor".
> 
> Those strings are read directly out of the CPU. Mine for example says
> 
> cpu family      : 6
> model           : 1
> model name      : AMD-K7(tm) Processor
> stepping        : 1

No there is a bug there, I can confirm that mine does the same (ie
second athlon is not reported with correct model name)

-- 
Jens Axboe


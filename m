Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269282AbUJFPE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269282AbUJFPE7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269283AbUJFPE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:04:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56013 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269282AbUJFPE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:04:57 -0400
Date: Wed, 6 Oct 2004 17:01:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] ide-dma blacklist behaviour broken
Message-ID: <20041006150157.GN3638@suse.de>
References: <20041005142001.GR2433@suse.de> <20041005163730.A19554@infradead.org> <20041005154628.GG19971@suse.de> <1097016410.23923.8.camel@localhost.localdomain> <20041006054532.GA13631@suse.de> <1097069227.29255.2.camel@localhost.localdomain> <20041006144152.GK3638@suse.de> <1097071095.29251.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097071095.29251.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06 2004, Alan Cox wrote:
> On Mer, 2004-10-06 at 15:41, Jens Axboe wrote:
> > Ah, I think you are misreading it. It wasn't the DMA'ing of the atapi
> > cdb, that was always pio'ed to the drive. But DMA for the command itself
> > was turned on before the cdb had been transferred.
> 
> Yep. I may have the detail wrong, its a long time ago. That fixed
> several CD's that were on the blacklist and most of the others may well
> never have been tested.

Yeah, it was a very nasty bug. So do you suggest we try and scrap the
atapi drives from the blacklist?

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUJFPA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUJFPA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269240AbUJFPA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:00:57 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:50090 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268265AbUJFPA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:00:56 -0400
Subject: Re: [PATCH] ide-dma blacklist behaviour broken
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20041006144152.GK3638@suse.de>
References: <20041005142001.GR2433@suse.de>
	 <20041005163730.A19554@infradead.org> <20041005154628.GG19971@suse.de>
	 <1097016410.23923.8.camel@localhost.localdomain>
	 <20041006054532.GA13631@suse.de>
	 <1097069227.29255.2.camel@localhost.localdomain>
	 <20041006144152.GK3638@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097071095.29251.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 14:58:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-06 at 15:41, Jens Axboe wrote:
> Ah, I think you are misreading it. It wasn't the DMA'ing of the atapi
> cdb, that was always pio'ed to the drive. But DMA for the command itself
> was turned on before the cdb had been transferred.

Yep. I may have the detail wrong, its a long time ago. That fixed
several CD's that were on the blacklist and most of the others may well
never have been tested.


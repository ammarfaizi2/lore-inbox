Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269265AbUJFOaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269265AbUJFOaG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 10:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269270AbUJFOaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 10:30:06 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:27306 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269265AbUJFOaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 10:30:03 -0400
Subject: Re: [PATCH] ide-dma blacklist behaviour broken
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20041006054532.GA13631@suse.de>
References: <20041005142001.GR2433@suse.de>
	 <20041005163730.A19554@infradead.org> <20041005154628.GG19971@suse.de>
	 <1097016410.23923.8.camel@localhost.localdomain>
	 <20041006054532.GA13631@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097069227.29255.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 14:27:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-06 at 06:45, Jens Axboe wrote:
> > We should actually probably nuke most of the IDE blacklist, much of the
> > CD-ROM blacklist arose because we DMA rather than PIO'd the ATAPI CDB.
> 
> Hmm? When have we ever done that?

2.0, 2.2, 2.4 to about 2.4.18 or so (Khalid Aziz eventually pinned it
down and fixed it).



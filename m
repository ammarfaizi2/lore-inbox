Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUJFFpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUJFFpo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 01:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267278AbUJFFpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 01:45:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20184 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267263AbUJFFpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 01:45:42 -0400
Date: Wed, 6 Oct 2004 07:45:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] ide-dma blacklist behaviour broken
Message-ID: <20041006054532.GA13631@suse.de>
References: <20041005142001.GR2433@suse.de> <20041005163730.A19554@infradead.org> <20041005154628.GG19971@suse.de> <1097016410.23923.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097016410.23923.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05 2004, Alan Cox wrote:
> On Maw, 2004-10-05 at 16:46, Jens Axboe wrote:
> > I didn't check, someone just reported today. But looking at eg 2.6.5, it
> > seems to have the same bug. So it's likely very old.
> 
> We should actually probably nuke most of the IDE blacklist, much of the
> CD-ROM blacklist arose because we DMA rather than PIO'd the ATAPI CDB.

Hmm? When have we ever done that?

-- 
Jens Axboe


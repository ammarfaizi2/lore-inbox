Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUJEXt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUJEXt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUJEXt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:49:56 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:33448 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266362AbUJEXtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:49:53 -0400
Subject: Re: [PATCH] ide-dma blacklist behaviour broken
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20041005154628.GG19971@suse.de>
References: <20041005142001.GR2433@suse.de>
	 <20041005163730.A19554@infradead.org>  <20041005154628.GG19971@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097016410.23923.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 05 Oct 2004 23:46:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-10-05 at 16:46, Jens Axboe wrote:
> I didn't check, someone just reported today. But looking at eg 2.6.5, it
> seems to have the same bug. So it's likely very old.

We should actually probably nuke most of the IDE blacklist, much of the
CD-ROM blacklist arose because we DMA rather than PIO'd the ATAPI CDB.


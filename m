Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbUKQR1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUKQR1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbUKQRYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:24:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28901 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262432AbUKQQ5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:57:47 -0500
Subject: Re: [BUG] Kernel disables DMA on RICOH CD-R/RW
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>
In-Reply-To: <58cb370e04111605019fc1df8@mail.gmail.com>
References: <20041116124656.82075.qmail@web52601.mail.yahoo.com>
	 <58cb370e04111605019fc1df8@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100706838.420.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 15:54:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-16 at 13:01, Bartlomiej Zolnierkiewicz wrote:
> Previously VIA IDE driver ignored DMA blacklists completely
> (which was of course wrong), it was fixed.
> 
> Probably this drive should be removed from the blacklist.
> Does anybody remember why was it added there?

As I said before almost all of our blacklist is junk from when the IDE
ATAPI DMA bug wasn't fixed.


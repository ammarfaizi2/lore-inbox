Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbUAaKKk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 05:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUAaKKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 05:10:40 -0500
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:5901 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S263983AbUAaKKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 05:10:39 -0500
Subject: Re: ide-cdrom / atapi burning bug - 2.6.1
From: Mans Matulewicz <cybermans@xs4all.nl>
Reply-To: cybermans@xs4all.nl
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040131093438.GS11683@suse.de>
References: <1075511134.5412.59.camel@localhost>
	 <20040131093438.GS11683@suse.de>
Content-Type: text/plain
Message-Id: <1075543838.5426.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 31 Jan 2004 11:10:38 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-31 at 10:34, Jens Axboe wrote:
> On Sat, Jan 31 2004, Mans Matulewicz wrote:
> > Hi,
> > After replacing my 2.4.22  with a 2.6.1 kernel I tried ATAPI cd burning.
> > This totally fails. Most of the CD's are corrupt and my system totally
> > locks up when erasing an cdrw (reset button was the option I needed to
> > reboot my system) . k3b reports cd is completely burned but fails are
> > not identical or totally unreadable. I tried it both with an tainted
> > (nvidia) and an untainted (nv) kernel: same results. With ide-scsi
> > burning in 2.4.x I had no problems. 
> 
> Did you use DMA in 2.4 as well? Does 2.6 work if you turn it off? It's
> most likely an issue with your via adapter.

I used DMA in 2.4.

I tried without dma on but it still totally locks my system while
erasing an rw.


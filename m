Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUAaJeo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 04:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUAaJeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 04:34:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29611 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264283AbUAaJen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 04:34:43 -0500
Date: Sat, 31 Jan 2004 10:34:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Mans Matulewicz <cybermans@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cdrom / atapi burning bug - 2.6.1
Message-ID: <20040131093438.GS11683@suse.de>
References: <1075511134.5412.59.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075511134.5412.59.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31 2004, Mans Matulewicz wrote:
> Hi,
> After replacing my 2.4.22  with a 2.6.1 kernel I tried ATAPI cd burning.
> This totally fails. Most of the CD's are corrupt and my system totally
> locks up when erasing an cdrw (reset button was the option I needed to
> reboot my system) . k3b reports cd is completely burned but fails are
> not identical or totally unreadable. I tried it both with an tainted
> (nvidia) and an untainted (nv) kernel: same results. With ide-scsi
> burning in 2.4.x I had no problems. 

Did you use DMA in 2.4 as well? Does 2.6 work if you turn it off? It's
most likely an issue with your via adapter.

-- 
Jens Axboe


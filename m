Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVIWUYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVIWUYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 16:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVIWUYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 16:24:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751227AbVIWUYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 16:24:20 -0400
Date: Fri, 23 Sep 2005 13:23:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: joshk@triplehelix.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] updated version of Jens' SATA suspend-to-ram patch
In-Reply-To: <20050923180711.GH22655@suse.de>
Message-ID: <Pine.LNX.4.58.0509231323120.3325@g5.osdl.org>
References: <20050923163334.GA13567@triplehelix.org> <20050923180711.GH22655@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Sep 2005, Jens Axboe wrote:
> 
> Port looks fine, thanks. The only problem I've seen with the base patch
> is that sometimes ata_do_simple_cmd() seems to be invoked right before a
> previous command has completed. So I needed this addon to work around
> that issue.

Ok. Can we have this in -mm for a few days just to shake out anything 
interesting, and then merge it into mainline?

		Linus

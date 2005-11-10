Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVKJNOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVKJNOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVKJNOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:14:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24235 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750833AbVKJNOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:14:53 -0500
Date: Thu, 10 Nov 2005 14:13:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: userspace block driver?
Message-ID: <20051110131356.GA9584@elf.ucw.cz>
References: <4371A4ED.9020800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4371A4ED.9020800@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Has anybody put any thought towards how a userspace block driver would work?
> 
> Consider a block device implemented via an SSL network connection.  I 
> don't want to put SSL in the kernel, which means the only other 
> alternative is to pass data to/from a userspace daemon.
> 
> Anybody have any favorite methods?  [similar to] mmap'd packet socket? 
> ramfs?

drivers/block/nbd?
								Pavel

-- 
Thanks, Sharp!

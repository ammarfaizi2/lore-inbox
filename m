Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbTEQIER (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 04:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTEQIER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 04:04:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1182 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261301AbTEQIEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 04:04:14 -0400
Date: Sat, 17 May 2003 10:16:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode, #2
Message-ID: <20030517081658.GU812@suse.de>
References: <20030516113309.GY812@suse.de> <20030516195535.GC372@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516195535.GC372@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16 2003, Pavel Machek wrote:
> Hi!
> 
> > Made a few tweaks and adjustments:
> > 
> > - If block_dump is set, also dump who is marking a page/buffer as dirty.
> >   akpm recommended this.
> > 
> > - Don't touch default bdflush parameters (see script)
> > 
> > That's about it. I've gotten several mails who really like the patch and
> > that it really adds a non-significant amount of extra battery
> > time. I
> 
> Non-significant? Like it adds no time at all?

Woops, that was reversed :)

> > consider the patch final at this point.
> > 
> > Patch is against 2.4.21-rc2 (ish)
> 
> It looks nice, but without Documentation/laptop_mode, I can't say much
> more ;-)))).

The attached script basically explained everything, but yes I will add a
laptop_mode file as well.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUB0KAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUB0KAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:00:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1757 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261764AbUB0KAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:00:18 -0500
Date: Fri, 27 Feb 2004 10:59:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-mmX locks up reading scratched SVCD
Message-ID: <20040227095950.GK5996@suse.de>
References: <403F120C.5090200@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403F120C.5090200@freemail.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27 2004, Boszormenyi Zoltan wrote:
> Hi,
> 
> I have a scratched SVCD and reading it back with vcdimager-0.7.14
> locks up the machine completely. I tried it with kernels is 2.6.3-mm[1234].
> I have not tried older kernel.
> 
> A flawless SVCD can be read back. I also tried reading back a bad 
> overburned SVCD,
> (cdrdao-1.1.8 reported error at the end) and it also locked up the machine.
> I fixated this disk, tried reading back -> lockup.
> Two IDE CD-RWs produce the same effect: LG 52/24/52 and Sony 48/24/48.
> Something must be bad in the ide-cd driver, it should at least report an
> error instead of locking up.

With damaged media, the problem is often the hardware locking up. In
that case there's really not much the kernel can do. That said, does the
keyboard LED's blink when the machine hangs?

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUCFOEc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 09:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbUCFOEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 09:04:32 -0500
Received: from zork.zork.net ([64.81.246.102]:39311 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261669AbUCFOEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 09:04:31 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
References: <20040303113756.GQ9196@suse.de>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Date: Sat, 06 Mar 2004 14:04:26 +0000
In-Reply-To: <20040303113756.GQ9196@suse.de> (Jens Axboe's message of "Wed,
 3 Mar 2004 12:37:56 +0100")
Message-ID: <6ufzcmm5qt.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> Hi,
>
> 2.6 still uses PIO for CDROMREADAUDIO cdda ripping, which is less than
> optimal of course... This patch uses the block layer infrastructure to
> enable zero copy DMA ripping through CDROMREADAUDIO.
>
> I'd appreciate people giving this a test spin. Patch is against
> 2.6.4-rc1 (well current BK, actually).

Applied successfully to 2.6.4-rc1-mm2, and it works great.  For some
reason, on two different machines, ripping with cdparanoia used to
somehow crowd out the serial port, but now everything just works.

Thanks a lot!


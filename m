Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284944AbRLUXw7>; Fri, 21 Dec 2001 18:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284979AbRLUXwt>; Fri, 21 Dec 2001 18:52:49 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:32230 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S284944AbRLUXwb>; Fri, 21 Dec 2001 18:52:31 -0500
Date: Fri, 21 Dec 2001 18:55:38 -0500
To: Jens Axboe <axboe@kernel.org>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011221185538.A131@earthlink.net>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011221154654.E811@suse.de>; from axboe@kernel.org on Fri, Dec 21, 2001 at 03:46:54PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, please try something for me. In drivers/block/elevator.c, comment
> out this block:

After commenting the block of code, make clean, etc, I rebooted and ran 
the dbench 32, 128 scripty.  It completed dbench 32 again, but dbench
128 hung again.  I could quit some tools.  df, ps, wouldn't return
and didn't listen to <ctrl c>.

> Loop back highmem issue is different, I'll take a look at that later.
> I'll be pretty unresponsive over christmas, though.
> 
> Jens Axboe

Enjoy the holidays!

-- 
Randy Hron


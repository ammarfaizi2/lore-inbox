Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319150AbSHFPIj>; Tue, 6 Aug 2002 11:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319152AbSHFPIj>; Tue, 6 Aug 2002 11:08:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52447 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319150AbSHFPIh>;
	Tue, 6 Aug 2002 11:08:37 -0400
Date: Tue, 6 Aug 2002 17:12:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <mcp@linux-systeme.de>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.4.19' drivers/block/ll_rw_blk.c
Message-ID: <20020806151205.GD1132@suse.de>
References: <200208051223.29329.mcp@linux-systeme.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208051223.29329.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05 2002, Marc-Christian Petersen wrote:
> Hi there,
> 
> could you please consider changing those very slow behaviour in 
> "drivers/block/ll_rw_blk.c"? ... Benchmarked against 2.4.18 this is horribly 
> slower ... Doing some heavy disk i/o, want to start another thing, system 
> freeze for some seconds ... Opening a xterm , Ctrl-D to leave, this takes 
> about 5 seconds and somewhat is doing flushing to the disk.
> 
> Maybe req_finished_io ?
> 
> Adrian, could this be the problem you've experienced?

This is a crazy bug report, sorry :-)

What slow behaviour in ll_rw_blk.c?! Consider providing vmstat when the
slowdown takes place. Also, try enable profiling if it seems like hard
system freezes.

> Afaik this was changed for 2.4.19-pre7 and above.

2.4.19-pre7 works fine, 2.4.19-pre8 stinks?

-- 
Jens Axboe


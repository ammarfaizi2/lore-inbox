Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUCXPNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 10:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbUCXPMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 10:12:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1438 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263742AbUCXPMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 10:12:25 -0500
Date: Wed, 24 Mar 2004 16:12:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: drivers/block/elevator.c:249
Message-ID: <20040324151222.GS3377@suse.de>
References: <Pine.LNX.4.58.0403241006310.28727@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403241006310.28727@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24 2004, Zwane Mwaikambo wrote:
> I'm hitting the following WARN_ON constantly on a slow (133MHz) SMP box
> with Fast SCSI for disks. Kernel is 2.6.5-rc2-mm1, i'll be trying
> 2.6.5-rc2-mm2 shortly. The warning crops up as early as the bootscripts.
> 
> Badness in elv_remove_request at drivers/block/elevator.c:249
> Call Trace:
>  [<c034ab67>] elv_remove_request+0x77/0x80
>  [<c03a3432>] scsi_request_fn+0x432/0x4f0

Known bug in that kernel, just go to the next one...

-- 
Jens Axboe


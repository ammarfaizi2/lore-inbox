Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUCPS4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUCPS4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:56:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22253 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261214AbUCPS4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:56:11 -0500
Date: Tue, 16 Mar 2004 19:56:09 +0100
From: Jens Axboe <axboe@suse.de>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3-order allocation failed with cdda2wav
Message-ID: <20040316185609.GV2977@suse.de>
References: <20040316184640.GA14088@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316184640.GA14088@DervishD>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16 2004, DervishD wrote:
>     Hi all :)
> 
>     I've recently started to use cdda2wav (I've been using cdparanoia
> for years and wanted to take a look at cdda2wav), and I have a
> problem: each time I use cdda2wav the kernel spills '__alloc_pages:
> 3-order allocation failed (gpf=0x20/0)' six times.
> 
>     I'm using cdrtools 2.0.3, with kernel 2.4.25 and ide-scsi. I have
> a Plextor CD-writer that I use to do CDDA ripping, but the problem
> appears with other drives too (I've tested with a Liteon DVD, too).
> 
>     Maybe a cdda2wav problem? Kernel problem?

You can ignore the messages, but yeah I know they are annoying...

>     In addition to this problem, I have another one, this time
> related with interfaces: if I use the SCSI generic interface with
> cdda2wav, it runs without problems (well, except that noted above)
> but uses a lot of CPU (up to 60%), so I tested with cooked_ioctl
> interface, and then the CPU use drops to 4% but I got two error
> messages about CDIOCSETCDDA not available, but the allocation problem
> DOES NOT HAPPEN :?
> 
>     Any help? Thanks in advance :)

Upgrade to 2.6.5-rc1, it'll solve all your problems in this area :-)

-- 
Jens Axboe


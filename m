Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbUKEOPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbUKEOPU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbUKEOPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:15:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53219 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262697AbUKEOOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:14:51 -0500
Date: Fri, 5 Nov 2004 15:14:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Terry Kyriacopoulos <terryk@echo-on.net>, linux-kernel@vger.kernel.org,
       gadio@netvision.net.il, andre@linux-ide.org, linu-ide@vger.kernel.org
Subject: Re: [PATCH] ide-scsi: DMA alignment bug fixed
Message-ID: <20041105141414.GH18527@suse.de>
References: <Pine.LNX.4.56.0411050042250.88@vk.local> <20041105073556.GE16649@suse.de> <58cb370e041105060837f6c555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e041105060837f6c555@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05 2004, Bartlomiej Zolnierkiewicz wrote:
> [ linux-ide@vger.kernel.org added to cc: ]
> 
> Before going further please both of you check the current -linus tree.
> 
> I fixed ide-scsi to "pass" scatterlist table obtained from
> SCSI layer to IDE layer and killed BIO mapping completely.
> 
> Thanks.
> 
> Jens, while unaligned DMA is a problem for ide-scsi?
> AFAIR ide-cd does it so this is not a hardware limitation...

ide-cd just requires 32-byte alignment currently.

-- 
Jens Axboe


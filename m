Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267252AbUHDFbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267252AbUHDFbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 01:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUHDFbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 01:31:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41400 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267252AbUHDFbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 01:31:49 -0400
Date: Wed, 4 Aug 2004 07:31:34 +0200
From: Jens Axboe <axboe@suse.de>
To: "David N. Arnold" <dnarnold@yahoo.com>
Cc: David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wiggly@wiggly.org, matt@mattcaron.net, seymour@astro.utoronto.ca
Subject: Re: cdrom: dropping to single frame dma
Message-ID: <20040804053134.GA10340@suse.de>
References: <41040A4B.6080703@blue-labs.org> <20040802132457.GT10496@suse.de> <41102FAB.40701@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41102FAB.40701@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03 2004, David N. Arnold wrote:
> I don't know if it's a result of upgrading to 2.6.8-rc2 (from 2.6.5) or 
> from the patch, but it has changed things.  I still get
> 
> hdd: DMA timeout retry
> hdd: timeout waiting for DMA
> hdd: status timeout: status=0xd0 { Busy }
> hdd: status timeout: error=0x00
> hdd: drive not ready for command
> hdd: ATAPI reset complete
> cdrom: dropping to single frame dma
> 
> but ripping stays at its normal speed (5.0x instead of 0.6x) and the 
> file produced is correct instead of skipping/silence.
> 
> It doesn't fix the true issue of why I'm getting DMA timeouts, but it 
> does make ripping useable.

After the 'dropping to single frame' message, does it work reliably
after that? And when does the above occur, initially or after some time?
Details, please.

-- 
Jens Axboe


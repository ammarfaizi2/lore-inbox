Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270910AbUJUU0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270910AbUJUU0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270928AbUJUUWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:22:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32475 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270829AbUJUUQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:16:06 -0400
Date: Thu, 21 Oct 2004 22:15:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: readcd hangs in blk_execute_rq
Message-ID: <20041021201532.GG32465@suse.de>
References: <20041021161100.GA14154@suse.de> <Pine.GSO.4.44.0410212014540.21865-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0410212014540.21865-100000@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21 2004, Meelis Roos wrote:
> > Does 2.6.9 work if you turn off
> > dma first?
> 
> Turned DMA off with hdparm -d 0 /dev/hdc, still the same.
> Turned ATAPI DMA support off completely (activated "Use DMA only for
> disks" compile option), still the same half-hang.
> 
> BTW, the hang sector is different all the time - it varies from 980 to
> 3200 so far.

Can I talk you into trying to find out when this broke? You mention
2.4.18 as working, did 2.4.19 break? Narrowing this down as much as
possible would be very helpful.

-- 
Jens Axboe


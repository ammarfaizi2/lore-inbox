Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270751AbUJURXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270751AbUJURXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270735AbUJURXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:23:34 -0400
Received: from math.ut.ee ([193.40.5.125]:42465 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S270759AbUJURQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:16:47 -0400
Date: Thu, 21 Oct 2004 20:16:40 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: readcd hangs in blk_execute_rq
In-Reply-To: <20041021161100.GA14154@suse.de>
Message-ID: <Pine.GSO.4.44.0410212014540.21865-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does 2.6.9 work if you turn off
> dma first?

Turned DMA off with hdparm -d 0 /dev/hdc, still the same.
Turned ATAPI DMA support off completely (activated "Use DMA only for
disks" compile option), still the same half-hang.

BTW, the hang sector is different all the time - it varies from 980 to
3200 so far.

-- 
Meelis Roos (mroos@linux.ee)


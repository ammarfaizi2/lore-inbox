Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbQLAWp7>; Fri, 1 Dec 2000 17:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129626AbQLAWpt>; Fri, 1 Dec 2000 17:45:49 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:32260 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129568AbQLAWpa>; Fri, 1 Dec 2000 17:45:30 -0500
Date: Sat, 2 Dec 2000 01:11:04 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Phillip Ezolt <ezolt@perf.zko.dec.com>
Cc: Andrea Arcangeli <andrea@suse.de>, rth@twiddle.net,
        Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org,
        wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
Message-ID: <20001202011104.A2089@jurassic.park.msu.ru>
In-Reply-To: <20001201203522.B2098@inspiron.random> <Pine.OSF.3.96.1001201145152.32335I-100000@perf.zko.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.OSF.3.96.1001201145152.32335I-100000@perf.zko.dec.com>; from ezolt@perf.zko.dec.com on Fri, Dec 01, 2000 at 02:56:43PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 02:56:43PM -0500, Phillip Ezolt wrote:
> What data structure's would I look at?  What should I investigate to
> verify this?

In the arch/alpha/kernel/pci_iommu.c change
#define DEBUG_ALLOC 0
to
#define DEBUG_ALLOC 2

Perhaps this will give us more info.
At the first look window 1 is being set up properly.

Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

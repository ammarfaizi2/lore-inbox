Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbQLAU1l>; Fri, 1 Dec 2000 15:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbQLAU1W>; Fri, 1 Dec 2000 15:27:22 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:16659 "HELO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S129663AbQLAU1R>; Fri, 1 Dec 2000 15:27:17 -0500
Date: Fri, 1 Dec 2000 14:56:43 -0500 (EST)
From: Phillip Ezolt <ezolt@perf.zko.dec.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, rth@twiddle.net,
        Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org,
        wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
In-Reply-To: <20001201203522.B2098@inspiron.random>
Message-ID: <Pine.OSF.3.96.1001201145152.32335I-100000@perf.zko.dec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

> large 2G. So it's maybe the second window between 1G and 2G that isn't set
> correctly? 

What data structure's would I look at?  What should I investigate to
verify this?

> Does the qlogic driver works on a tsunami southbridge?

	What would I have to do to test this?  I have an ES40 & 3 miata's 
at my disposal.

Thanks,
--Phil

Compaq:  High Performance Server Division/Benchmark Performance Engineering 
---------------- Alpha, The Fastest Processor on Earth --------------------
Phillip.Ezolt@compaq.com        |C|O|M|P|A|Q|        ezolt@perf.zko.dec.com
------------------- See the results at www.spec.org -----------------------

On Fri, 1 Dec 2000, Andrea Arcangeli wrote:

> On Fri, Dec 01, 2000 at 01:30:10PM -0500, Phillip Ezolt wrote:
> > Any ideas? (Or patches that I can test... ;-) ) 
> 
> miata seems to use cia southbridge so it should set an iommu direct mapping
> large 2G. So it's maybe the second window between 1G and 2G that isn't set
> correctly? Does the qlogic driver works on a tsunami southbridge?
> 
> Andrea
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

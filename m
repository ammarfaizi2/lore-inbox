Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLEQXj>; Tue, 5 Dec 2000 11:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLEQX3>; Tue, 5 Dec 2000 11:23:29 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:51985 "HELO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S129210AbQLEQXT>; Tue, 5 Dec 2000 11:23:19 -0500
Date: Tue, 5 Dec 2000 10:52:46 -0500 (EST)
From: Phillip Ezolt <ezolt@perf.zko.dec.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, rth@twiddle.net,
        Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org,
        wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
In-Reply-To: <20001201212628.A9247@inspiron.random>
Message-ID: <Pine.OSF.3.96.1001205104717.11166A-100000@perf.zko.dec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

> Does the qlogic driver works well on an ES40 with more than 1G of ram? If
> yes then qlogic driver should be ok.

Yes. I have tried it on an ES40 with 16 Gig of ram, and it boots just fine.

	From what you say, this appears to be a Miata problem and NOT
a qlogic problem.  What next? 

--Phil

Compaq:  High Performance Server Division/Benchmark Performance Engineering 
---------------- Alpha, The Fastest Processor on Earth --------------------
Phillip.Ezolt@compaq.com        |C|O|M|P|A|Q|        ezolt@perf.zko.dec.com
------------------- See the results at www.spec.org -----------------------

On Fri, 1 Dec 2000, Andrea Arcangeli wrote:

> On Fri, Dec 01, 2000 at 02:56:43PM -0500, Phillip Ezolt wrote:
> > What data structure's would I look at?  What should I investigate to
> > verify this?
> 
> The relevant code is in arch/alpha/kernel/core_cia.c
> 
> > 	What would I have to do to test this?  I have an ES40 & 3 miata's 
> 
> Does the qlogic driver works well on an ES40 with more than 1G of ram? If
> yes then qlogic driver should be ok.
> 
> Andrea
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

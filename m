Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLAUGT>; Fri, 1 Dec 2000 15:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbQLAUF5>; Fri, 1 Dec 2000 15:05:57 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:22290 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129351AbQLAUFt>; Fri, 1 Dec 2000 15:05:49 -0500
Date: Fri, 1 Dec 2000 20:35:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Phillip Ezolt <ezolt@perf.zko.dec.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, rth@twiddle.net,
        Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org,
        wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
Message-ID: <20001201203522.B2098@inspiron.random>
In-Reply-To: <20001201145619.A553@jurassic.park.msu.ru> <Pine.OSF.3.96.1001201132729.32335G-100000@perf.zko.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.3.96.1001201132729.32335G-100000@perf.zko.dec.com>; from ezolt@perf.zko.dec.com on Fri, Dec 01, 2000 at 01:30:10PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 01:30:10PM -0500, Phillip Ezolt wrote:
> Any ideas? (Or patches that I can test... ;-) ) 

miata seems to use cia southbridge so it should set an iommu direct mapping
large 2G. So it's maybe the second window between 1G and 2G that isn't set
correctly? Does the qlogic driver works on a tsunami southbridge?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

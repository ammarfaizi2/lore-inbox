Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129719AbQLAU5Y>; Fri, 1 Dec 2000 15:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbQLAU5N>; Fri, 1 Dec 2000 15:57:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:9498 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129719AbQLAU4w>; Fri, 1 Dec 2000 15:56:52 -0500
Date: Fri, 1 Dec 2000 21:26:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Phillip Ezolt <ezolt@perf.zko.dec.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, rth@twiddle.net,
        Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org,
        wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
Message-ID: <20001201212628.A9247@inspiron.random>
In-Reply-To: <20001201203522.B2098@inspiron.random> <Pine.OSF.3.96.1001201145152.32335I-100000@perf.zko.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.3.96.1001201145152.32335I-100000@perf.zko.dec.com>; from ezolt@perf.zko.dec.com on Fri, Dec 01, 2000 at 02:56:43PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 02:56:43PM -0500, Phillip Ezolt wrote:
> What data structure's would I look at?  What should I investigate to
> verify this?

The relevant code is in arch/alpha/kernel/core_cia.c

> 	What would I have to do to test this?  I have an ES40 & 3 miata's 

Does the qlogic driver works well on an ES40 with more than 1G of ram? If
yes then qlogic driver should be ok.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbQKAFU6>; Wed, 1 Nov 2000 00:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbQKAFUt>; Wed, 1 Nov 2000 00:20:49 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:41485 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129063AbQKAFUc>; Wed, 1 Nov 2000 00:20:32 -0500
Date: Tue, 31 Oct 2000 23:20:28 -0600
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001031232028.H1041@wire.cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0011010010380.16674-100000@elte.hu> <39FF4773.CA06CB60@timpanogas.org> <20001031230120.G1041@wire.cadcamlab.org> <20001031210918.A29536@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001031210918.A29536@work.bitmover.com>; from lm@bitmover.com on Tue, Oct 31, 2000 at 09:09:18PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [me]
> > So the real question is, how many gettimeofday() per sec can Linux
> > do?

[Larry McVoy]
> Oh, about 3,531,073 on a 1Ghz AM thunderbird running 
> Linux disks.bitmover.com 2.4.0-test5.

So, at two "context switches" (Jeff's term) per syscall, we're
somewhere around half the speed of Netware's longjmp.

Not bad. (:

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262055AbREQRBO>; Thu, 17 May 2001 13:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262057AbREQRBE>; Thu, 17 May 2001 13:01:04 -0400
Received: from rainbow.studorg.tuwien.ac.at ([128.130.43.98]:9737 "EHLO
	rainbow.studorg.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S262055AbREQRAv>; Thu, 17 May 2001 13:00:51 -0400
Date: Thu, 17 May 2001 19:00:43 +0200 (CEST)
From: Michael Wildpaner <mike@rainbow.studorg.tuwien.ac.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: alpha/2.4.x: CPU misdetection, possible miscompilation
In-Reply-To: <E150N9p-0005KA-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105171845310.2692-100000@rainbow.studorg.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001, Alan Cox wrote:

> > possible miscompilation of smp_tune_scheduling:
> > 	These versions of gcc
> > 		gcc version 2.95.3 20010111
> > 		gcc version 2.95.4 20010506
> 
> Does gcc 2.96 or the gcc 3.0 snapshot also show this problem ?

'gcc version 3.0 20010426' is fine.

I don't have 2.96 at the moment, but can install if necessary.

With the value of on_chip_cache unused, the block could be commented out.
If activated, the cpu->type should be masked (at least for our machines).

Anyone with better knowledge of the alpha's hwrpb than me, please check if
the value of cpu->type can be masked, e.g. to the lower 32 (8?) bits.

Greetings, Mike

-- 
Don't feed.                                               DI Michael Wildpaner
Don't provoke.                                                   Ph.D. Student
Don't enter the cage.



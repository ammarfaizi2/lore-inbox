Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132022AbQKSAfu>; Sat, 18 Nov 2000 19:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132050AbQKSAfk>; Sat, 18 Nov 2000 19:35:40 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:517 "EHLO tellus.mine.nu")
	by vger.kernel.org with ESMTP id <S132022AbQKSAfc>;
	Sat, 18 Nov 2000 19:35:32 -0500
Date: Sun, 19 Nov 2000 01:05:26 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Frank Davis <fdavis@andrew.cmu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] dmfe.c network driver update for 2.4
In-Reply-To: <3819508582.974482117@primetime2>
Message-ID: <Pine.LNX.4.21.0011190100250.24779-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Frank Davis wrote:
> 
> 	I would rather fix those non-SMP compliant drivers to be SMP compliant, 
> then keeping them 'broken'. Adding the print statements would only be a 
> temporary solution.

Of course. This list of priorites is very natural, I think:

1. Working SMP driver
2. Broken SMP driver with a warning.
3. Broken SMP driver without a warning. (Even if "everyone" knows it
   is broken)

It takes less than a minute to add such a warning, but it can take days
or weeks to find someone to really fix the driver. That was my point.

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

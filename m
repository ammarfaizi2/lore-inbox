Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132033AbQKSAlV>; Sat, 18 Nov 2000 19:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132050AbQKSAlL>; Sat, 18 Nov 2000 19:41:11 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:49420 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132033AbQKSAlC>;
	Sat, 18 Nov 2000 19:41:02 -0500
Message-ID: <3A171A92.18FF3C3E@mandrakesoft.com>
Date: Sat, 18 Nov 2000 19:10:58 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@tellus.mine.nu>
CC: Frank Davis <fdavis@andrew.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CFT] dmfe.c network driver update for 2.4
In-Reply-To: <Pine.LNX.4.21.0011190100250.24779-100000@svea.tellus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:
> 
> On Fri, 17 Nov 2000, Frank Davis wrote:
> >
> >       I would rather fix those non-SMP compliant drivers to be SMP compliant,
> > then keeping them 'broken'. Adding the print statements would only be a
> > temporary solution.
> 
> Of course. This list of priorites is very natural, I think:
> 
> 1. Working SMP driver
> 2. Broken SMP driver with a warning.
> 3. Broken SMP driver without a warning. (Even if "everyone" knows it
>    is broken)
> 
> It takes less than a minute to add such a warning, but it can take days
> or weeks to find someone to really fix the driver. That was my point.

Marking them with a #warning is fine with me.

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
